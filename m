From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 07/13] PCI: cadence: Add new *ops* for CPU addr fixup
Date: Thu, 19 Dec 2019 17:33:56 +0530
Message-ID: <936cd6d6-33fc-6432-6fec-2b5173cb9ca4@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-8-kishon@ti.com>
 <20191217124050.GD24359@e119886-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217124050.GD24359@e119886-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 17/12/19 6:10 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:41PM +0530, Kishon Vijay Abraham I wrote:
>> Cadence driver uses "mem" memory resource to obtain the offset of
>> configuration space address region, memory space address region and
>> message space address region. The obtained offset is used to program
>> the Address Translation Unit (ATU). However certain platforms like TI's
>> J721E SoC require the absolute address to be programmed in the ATU and not
>> just the offset.
>>
>> The same problem was solved in designware driver using a platform specific
>> ops for CPU addr fixup in commit a660083eb06c5bb0 ("PCI: dwc: designware:
> 
> Thanks for this reference, though this doesn't need to be in the commit
> log, please put such comments underneath a ---.
> 
>> Add new *ops* for CPU addr fixup"). Follow a similar mechanism in
>> Cadence too instead of directly using "mem" memory resource in Cadence
>> PCIe core.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../pci/controller/cadence/pcie-cadence-host.c    | 15 ++++-----------
>>  drivers/pci/controller/cadence/pcie-cadence.c     |  8 ++++++--
>>  drivers/pci/controller/cadence/pcie-cadence.h     |  1 +
>>  3 files changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 2efc33b1cade..cf817be237af 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -105,15 +105,14 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>>  static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>>  {
>>  	struct cdns_pcie *pcie = &rc->pcie;
>> -	struct resource *mem_res = pcie->mem_res;
>>  	struct resource *bus_range = rc->bus_range;
>>  	struct resource *cfg_res = rc->cfg_res;
>>  	struct device *dev = pcie->dev;
>>  	struct device_node *np = dev->of_node;
>>  	struct of_pci_range_parser parser;
>> +	u64 cpu_addr = cfg_res->start;
>>  	struct of_pci_range range;
>>  	u32 addr0, addr1, desc1;
>> -	u64 cpu_addr;
>>  	int r, err;
>>  
>>  	/*
>> @@ -126,7 +125,9 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
>>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
>>  
>> -	cpu_addr = cfg_res->start - mem_res->start;
>> +	if (pcie->ops->cpu_addr_fixup)
>> +		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>> +
> 
> Won't this patch cause a breakage for existing users that won't have defined a
> cpu_addr_fixup? The offset isn't being calculated and so cpu_addr will be wrong?

Correct, this will need an additional patch in pcie-cadence-plat.c.

Thanks
Kishon
