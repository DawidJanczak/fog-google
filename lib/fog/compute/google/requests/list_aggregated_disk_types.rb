module Fog
  module Compute
    class Google
      class Mock
        def list_aggregated_disk_types(options = {})
          Fog::Mock.not_implemented
        end
      end

      class Real
        def list_aggregated_disk_types(options = {})
          @compute.list_aggregated_disk_types(@project, :filter => options[:filter])
        end
      end
    end
  end
end
