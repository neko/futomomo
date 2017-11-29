# frozen_string_literal: false

module Bot
  module Utilities
    # Module for the inrole command
    module IAm
      extend Discordrb::Commands::CommandContainer


      command(:iam,
              description: 'Assigns the current user a role if it is assignable',
              usage: "#{BOT.prefix}iam <role>") do |event, *role_args|
        role = nil
        event.server.roles.each do |serv_role|
          role = serv_role if serv_role.name == role_args.join(' ')
        end

        if role.nil?
          event.channel.send_embed do |embed|
            embed.color = CONFIG.error_embed_color
            embed.description = 'ERROR: That role does not exist'
          end
        else
          if CONFIG.assignable_roles.include? role.name
            event.user.add_role(role)
            event.channel.send_embed do |embed|
              embed.color = CONFIG.utilities[:embed_color]
              embed.description = "You have been assigned the role: #{role.name}"
            end
          else
            event.channel.send_embed do |embed|
              embed.color = CONFIG.error_embed_color
              embed.description = 'ERROR: That role is not assignable'
            end
          end
        end
      end
    end
  end
end