From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 02/26] PCI: keystone: Cleanup error_irq configuration
Date: Mon, 15 Apr 2019 10:58:12 +0530
Message-ID: <dce994be-ec08-8966-9338-226bba1f5102@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-3-kishon@ti.com> <20190413140343.GC126710@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190413140343.GC126710@google.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: devicetree@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Minghuan Lian <minghuan.Lian@nxp.com>, Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@axis.com, Jingoo Han <jingoohan1@gmail.com>, Mingkai Hu <mingkai.hu@nxp.com>, linux-omap@vger.kernel.org, Roy Zang <roy.zang@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Bjorn,

On 13/04/19 7:33 PM, Bjorn Helgaas wrote:
> Hi Kishon,
> 
> On Mon, Mar 25, 2019 at 03:09:23PM +0530, Kishon Vijay Abraham I wrote:
>> pci-keystone driver uses irq_of_parse_and_map to get irq number of
>> error_irq. Use platform_get_irq instead and move platform_get_irq()
>> and request_irq() of error_irq from ks_pcie_add_pcie_port to ks_pcie_probe
>> since error_irq is common to both RC mode and EP mode.
> 
> Does this have any DT implications?

No. platform_get_irq() uses of_irq_get(), which in-turn uses of_irq_parse_one()
and irq_create_of_mapping() while irq_of_parse_and_map() directly uses
of_irq_parse_one() and irq_create_of_mapping().

The only difference is platform_get_irq() falls back to using
platform_get_resource() if of_irq_get fails.

I thought it's better to use platform_get_irq() for platform devices.

Thanks
Kishon

> 
> It's not obvious that platform_get_irq() and irq_of_parse_and_map() work
> similarly or that they get the same result from DT.
> 
> I'm sure they *do*, but it would be nice to have some hints in the commit
> log about why that's the case.
> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 43 +++++++++--------------
>>  1 file changed, 17 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 07f55b355d75..e50f8773e768 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -98,8 +98,6 @@ struct keystone_pcie {
>>  	struct irq_domain	*legacy_irq_domain;
>>  	struct device_node	*np;
>>  
>> -	int error_irq;
>> -
>>  	/* Application register space */
>>  	void __iomem		*va_app_base;	/* DT 1st resource */
>>  	struct resource		app;
>> @@ -743,12 +741,6 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>>  	return ret;
>>  }
>>  
>> -static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
>> -{
>> -	if (ks_pcie->error_irq > 0)
>> -		ks_pcie_enable_error_irq(ks_pcie);
>> -}
>> -
>>  /*
>>   * When a PCI device does not exist during config cycles, keystone host gets a
>>   * bus error instead of returning 0xffffffff. This handler always returns 0
>> @@ -810,7 +802,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
>>  
>>  	ks_pcie_stop_link(pci);
>>  	ks_pcie_setup_rc_app_regs(ks_pcie);
>> -	ks_pcie_setup_interrupts(ks_pcie);
>>  	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
>>  			pci->dbi_base + PCI_IO_BASE);
>>  
>> @@ -854,23 +845,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
>>  	struct device *dev = &pdev->dev;
>>  	int ret;
>>  
>> -	/*
>> -	 * Index 0 is the platform interrupt for error interrupt
>> -	 * from RC.  This is optional.
>> -	 */
>> -	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
>> -	if (ks_pcie->error_irq <= 0)
>> -		dev_info(dev, "no error IRQ defined\n");
>> -	else {
>> -		ret = request_irq(ks_pcie->error_irq, ks_pcie_err_irq_handler,
>> -				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
>> -		if (ret < 0) {
>> -			dev_err(dev, "failed to request error IRQ %d\n",
>> -				ks_pcie->error_irq);
>> -			return ret;
>> -		}
>> -	}
>> -
>>  	pp->ops = &ks_pcie_host_ops;
>>  	ret = ks_pcie_dw_host_init(ks_pcie);
>>  	if (ret) {
>> @@ -946,6 +920,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>  	u32 num_lanes;
>>  	char name[10];
>>  	int ret;
>> +	int irq;
>>  	int i;
>>  
>>  	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
>> @@ -965,6 +940,20 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(dev, "missing IRQ resource: %d\n", irq);
>> +		return irq;
>> +	}
>> +
>> +	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
>> +			  "ks-pcie-error-irq", ks_pcie);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to request error IRQ %d\n",
>> +			irq);
>> +		return ret;
>> +	}
>> +
>>  	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
>>  	if (ret)
>>  		num_lanes = 1;
>> @@ -1020,6 +1009,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>  	if (ret < 0)
>>  		goto err_get_sync;
>>  
>> +	ks_pcie_enable_error_irq(ks_pcie);
>> +
>>  	return 0;
>>  
>>  err_get_sync:
>> -- 
>> 2.17.1
>>
