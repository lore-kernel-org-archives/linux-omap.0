From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 10/13] dt-bindings: PCI: Add EP mode dt-bindings for TI's
 J721E SoC
Date: Thu, 19 Dec 2019 18:44:46 +0530
Message-ID: <fb090674-abff-e2e1-492d-0585100980d0@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-11-kishon@ti.com> <20191219001408.GA20303@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191219001408.GA20303@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Tom Joseph <tjoseph@cadence.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

+Tom

On 19/12/19 5:44 am, Rob Herring wrote:
> On Mon, Dec 09, 2019 at 02:51:44PM +0530, Kishon Vijay Abraham I wrote:
>> Add PCIe EP mode dt-bindings for TI's J721E SoC.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 113 ++++++++++++++++++
>>  1 file changed, 113 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> new file mode 100644
>> index 000000000000..4e2af4733998
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>> @@ -0,0 +1,113 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-ep.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: TI J721E PCI EP (PCIe Wrapper)
>> +
>> +maintainers:
>> +  - Kishon Vijay Abraham I <kishon@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +      enum:
>> +          - ti,j721e-pcie-ep
> 
> Indentation.
> 
>> +
>> +  reg:
>> +    maxItems: 4
>> +
>> +  reg-names:
>> +    items:
>> +      - const: intd_cfg
>> +      - const: user_cfg
>> +      - const: reg
>> +      - const: mem
>> +
>> +  ti,syscon-pcie-ctrl:
>> +    description: Phandle to the SYSCON entry required for configuring PCIe mode
>> +                 and link speed.
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  max-link-speed:
>> +    minimum: 1
>> +    maximum: 3
>> +
>> +  num-lanes:
>> +    minimum: 1
>> +    maximum: 2
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: clock-specifier to represent input to the PCIe
>> +
>> +  clock-names:
>> +    items:
>> +      - const: fck
>> +
>> +  cdns,max-outbound-regions:
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/int32
> 
> uint32
> 
>> +      - enum: [16]
>> +
>> +  max-functions:
>> +    minimum: 1
>> +    maximum: 6
> 
> Needs a type ref. Or a common definition.
> 
>> +
>> +  dma-coherent:
>> +    description: Indicates that the PCIe IP block can ensure the coherency
>> +
>> +  phys:
> 
> How many? Need to convert cdns,cdns-pcie-host.txt...


Tom, Can you convert cdns,cdns-pcie-host.txt to YAML binding?
> 
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>> +
>> +  phy-names:
>> +    description: As defined in
>> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> 
> For all the properties shared with host mode, it might make sense to 
> define a common schema with all those properties and then include it in 
> the host and endpoint schemas.

Sure.

Thanks
Kishon
