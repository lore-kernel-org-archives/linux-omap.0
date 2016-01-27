From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Wed, 27 Jan 2016 12:16:17 -0600
Message-ID: <56A90971.4020409@ti.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-4-git-send-email-kishon@ti.com>
 <20160127173104.GQ19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160127173104.GQ19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 01/27/2016 11:31 AM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [160114 06:12]:
>> Use assert/deassert callbacks populated in the platform data to
>> to perform reset of PCIe.
>>
>> Use these callbacks until a reset controller driver is
>> is available in the kernel to reset PCIe.
> ...
> 
>> --- a/drivers/pci/host/pci-dra7xx.c
>> +++ b/drivers/pci/host/pci-dra7xx.c
>> @@ -347,6 +404,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>  	enum of_gpio_flags flags;
>>  	unsigned long gpio_flags;
>>  
>> +	ret = dra7xx_pcie_reset(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>>  	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
>>  	if (!dra7xx)
>>  		return -ENOMEM;
> 
> With the hwmod data properly configured the reset already happens
> for the device by the bus driver, the hwmod code in this case?
> 
>> @@ -457,6 +518,7 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
>>  	struct pcie_port *pp = &dra7xx->pp;
>>  	struct device *dev = &pdev->dev;
>>  	int count = dra7xx->phy_count;
>> +	int ret;
>>  
>>  	if (pp->irq_domain)
>>  		irq_domain_remove(pp->irq_domain);
>> @@ -467,6 +529,10 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
>>  		phy_exit(dra7xx->phy[count]);
>>  	}
>>  
>> +	ret = dra7xx_pcie_assert_reset(pdev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>  	return 0;
>>  }
> 
> Why do you need another reset here? Can't you just implement PM runtime
> in the driver and do the usual pm_runtime_put_sync followed by
> pm_runtime_disable?

The omap_hwmod_enable/disable code does not deal with hardresets (PRCM
reset lines) and so the pm_runtime_get_sync/put_sync only end up dealing
with clocks, and we need to invoke the reset functions separately.
Modules with softresets in SYSCONFIG are ok, as they are dealt with
properly.

> Basically I'm wondering how come we need these platform data callbacks
> at all.

The hardresets are controlled through the
omap_device_assert(deassert)_hardreset functions, and since these are
limited to mach-omap2, we are invoking them through platform data callbacks.


regards
Suman
