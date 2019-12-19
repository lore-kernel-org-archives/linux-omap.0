From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 03/13] PCI: cadence: Add support to use custom read and
 write accessors
Date: Thu, 19 Dec 2019 17:11:00 +0530
Message-ID: <cdd13dd0-6595-c11c-72b2-6a1d140c2bbc@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-4-kishon@ti.com>
 <20191216140729.GX24359@e119886-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216140729.GX24359@e119886-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 16/12/19 7:37 pm, Andrew Murray wrote:
> On Mon, Dec 09, 2019 at 02:51:37PM +0530, Kishon Vijay Abraham I wrote:
>> Add support to use custom read and write accessors. Platforms that
>> doesn't support half word or byte access or any other constraint
> 
> s/doesn't/don't/
> 
>> while accessing registers can use this feature to populate custom
>> read and write accessors. These custom accessors are used for both
>> standard register access and configuration space register access.
> 
> You can put the following sentence underneath a --- as it's not needed
> in the commit message (but may be helpful to reviewers).
> 
>> This is in preparation for adding PCIe support in TI's J721E SoC which
>> uses Cadence PCIe core.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/cadence/pcie-cadence.h | 99 +++++++++++++++++--
>>  1 file changed, 90 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index a2b28b912ca4..d0d91c69fa1d 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -223,6 +223,11 @@ enum cdns_pcie_msg_routing {
>>  	MSG_ROUTING_GATHER,
>>  };
>>  
>> +struct cdns_pcie_ops {
>> +	u32	(*read)(void __iomem *addr, int size);
>> +	void	(*write)(void __iomem *addr, int size, u32 value);
>> +};
>> +
>>  /**
>>   * struct cdns_pcie - private data for Cadence PCIe controller drivers
>>   * @reg_base: IO mapped register base
>> @@ -239,7 +244,7 @@ struct cdns_pcie {
>>  	int			phy_count;
>>  	struct phy		**phy;
>>  	struct device_link	**link;
>> -	const struct cdns_pcie_common_ops *ops;
> 
> What was cdns_pcie_common_ops? It's not defined in the current tree is it?

Yeah, it's spurious change that has got merged.
> 
>> +	const struct cdns_pcie_ops *ops;
>>  };
>>  
>>  /**
>> @@ -301,21 +306,47 @@ struct cdns_pcie_ep {
>>  /* Register access */
>>  static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
>>  {
>> +	void __iomem *addr = pcie->reg_base + reg;
>> +
>> +	if (pcie->ops && pcie->ops->write) {
>> +		pcie->ops->write(addr, 0x1, value);
>> +		return;
>> +	}
>> +
>>  	writeb(value, pcie->reg_base + reg);
> 
> Can you use 'addr' here instead of 'pcie->reg_base + reg'? (And similar for the
> rest of them).

Sure.

Thanks
Kishon
