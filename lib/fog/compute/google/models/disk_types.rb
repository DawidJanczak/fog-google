module Fog
  module Compute
    class Google
      class DiskTypes < Fog::Collection
        model Fog::Compute::Google::DiskType

        def all(filters = {})
          if filters["zone"]
            data = service.list_disk_types(filters["zone"]).items || []
          else
            data = service.list_aggregated_disk_types.items.values.flat_map(&:disk_types)
          end
          load(data.map(&:to_h))
        end

        def get(identity, zone = nil)
          response = nil
          if zone
            response = service.get_disk_type(identity, zone).body
          else
            disk_types = service.list_aggregated_disk_types(:filter => "name eq .*#{identity}").body["items"] || {}
            disk_type = disk_types.each_value.detect { |zone| zone.key?("diskTypes") } || {}

            response = disk_type["diskTypes"].first unless disk_type.empty?
          end
          return nil if response.nil?
          new(response)
        rescue Fog::Errors::NotFound
          nil
        end
      end
    end
  end
end
