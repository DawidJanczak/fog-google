module Fog
  module Compute
    class Google
      class Mock
        def list_regions
          Fog::Mock.not_implemented
        end
      end

      class Real
        def list_regions
          @compute.list_regions(@project)
        end
      end
    end
  end
end
