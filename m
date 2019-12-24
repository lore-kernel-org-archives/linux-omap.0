From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 09/13] dt-bindings: PCI: Add host mode dt-bindings for
 TI's J721E SoC
Date: Tue, 24 Dec 2019 13:36:25 +0530
Message-ID: <fc145cbc-88f2-5ccb-5c20-4be1ac81fe25@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-10-kishon@ti.com> <20191219000841.GA4251@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191219000841.GA4251@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On 19/12/19 5:38 AM, Rob Herring wrote:
> On Mon, Dec 09, 2019 at 02:51:43PM +0530, Kishon Vijay Abraham I wrote:
>> Add host mode dt-bindings for TI's J721E SoC.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/pci/ti,j721e-pci-host.yaml       | 161 ++++++++++++++++++
>>  1 file changed, 161 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> new file mode 100644
>> index 000000000000..96184e1f419f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>> @@ -0,0 +1,161 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-host.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: TI J721E PCI Host (PCIe Wrapper)
>> +
>> +maintainers:
>> +  - Kishon Vijay Abraham I <kishon@ti.com>
> 
> There's now a PCI bus schema. Reference it here:
> 
> allOf:
>   - $ref: "/schemas/pci/pci-bus.yaml#"
> 
>> +
>> +properties:
>> +  compatible:
>> +      enum:
>> +          - ti,j721e-pcie-host
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
>> +      - const: cfg
>> +
>> +  ti,syscon-pcie-ctrl:
>> +    description: Phandle to the SYSCON entry required for configuring PCIe mode
>> +                 and link speed.
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/phandle
> 
> You can drop the 'allOf' here if there aren't more constraints.

Do you mean I don't have to include phandle schema here? I don't seem to
be able to include $ref without allOf.

Thanks
Kishon
