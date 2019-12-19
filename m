From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 06/13] PCI: cadence: Allow pci_host_bridge to have custom
 pci_ops
Date: Thu, 19 Dec 2019 17:32:48 +0530
Message-ID: <0176543a-bc9b-0584-537e-ea407f5340c2@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-7-kishon@ti.com>
 <20191217123243.GC24359@e119886-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217123243.GC24359@e119886-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

On 17/12/19 6:02 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:40PM +0530, Kishon Vijay Abraham I wrote:
>> Certain platforms like TI's J721E allows only 32-bit configuration
>> space access. In such cases pci_generic_config_read and
>> pci_generic_config_write cannot be used. Add support in Cadence core
>> to let pci_host_bridge have custom pci_ops.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence-host.c | 7 ++++---
>>  drivers/pci/controller/cadence/pcie-cadence.h      | 8 ++++++++
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 0929554f5a81..2efc33b1cade 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -12,8 +12,8 @@
>>  
>>  #include "pcie-cadence.h"
>>  
>> -static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>> -				      int where)
>> +void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>> +			       int where)
>>  {
>>  	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>>  	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
>> @@ -289,7 +289,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>  	list_splice_init(&resources, &bridge->windows);
>>  	bridge->dev.parent = dev;
>>  	bridge->busnr = pcie->bus;
>> -	bridge->ops = &cdns_pcie_host_ops;
>> +	if (!bridge->ops)
>> +		bridge->ops = &cdns_pcie_host_ops;
>>  	bridge->map_irq = of_irq_parse_and_map_pci;
>>  	bridge->swizzle_irq = pci_common_swizzle;
>>  
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index 5171d0da37da..c879dd3d2893 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -472,11 +472,19 @@ static inline bool cdns_pcie_is_link_up(struct cdns_pcie *pcie)
>>  
>>  #ifdef CONFIG_PCIE_CADENCE_HOST
>>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
>> +void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>> +			       int where);
> 
> The commit message doesn't explain why this change in visibility is needed).

So that platform drivers can write custom read() and write() ops and
re-use map_bus. Will add this info in commit message.
> 
>>  #else
>>  static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>  {
>>  	return 0;
>>  }
>> +
>> +static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus,
>> +					     unsigned int devfn,
>> +					     int where)
>> +{
> 
> This still needs to return something right?

Right, thanks for spotting this.

Thanks
Kishon
