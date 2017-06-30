From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [linux-next][PATCH] usb: dwc3: omap: remove IRQ_NOAUTOEN used
 with shared irq
Date: Fri, 30 Jun 2017 14:34:34 -0500
Message-ID: <dac573e2-31e3-b431-8510-973d691fc0ed@ti.com>
References: <20170628233131.19114-1-grygorii.strashko@ti.com>
 <463ea19c-dc60-5926-56b4-0f10d2e23e94@ti.com>
 <20170629060353.GE3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170629060353.GE3730@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>
Cc: "GregKroah-Hartmangregkh@linuxfoundation.org" <GregKroah-Hartmangregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org



On 06/29/2017 01:03 AM, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [170628 21:21]:
>>
>>
>> On Thursday 29 June 2017 05:01 AM, Strashko, Grygorii wrote:
>>> IRQ_NOAUTOEN can't be used with shared IRQs and Kernel now will triggers
>>> warning if it happns, since commit 04c848d39879 ("genirq: Warn when
>>> IRQ_NOAUTOEN is used with shared interrupts"). And this is the case for
>>> OMAP DWC 3 driver.
>>>
>>> Hence, remove IRQ_NOAUTOEN flag and instead call disable_irq() before
>>> disabling PM runtime in probe error path handling.
>>
>> Or, how about requesting the irq at the end of probe after extcon
>> registration?
> 
> Hmm yeah, what prevents the issue that we tried to fix with commit
> 12a7f17fac5b ("usb: dwc3: omap: fix race of pm runtime with irq handler
> in probe")?

No, I think. There should be the disable_irq() call any way
before pm_runtime_put_sync(dev);| pm_runtime_disable(dev); -
once IRQ is requested driver can't know if IRQ handler is running now or not
unless it will call disable_irq()/free_irq().

But, I've also thought about moving request_irq() down (seems
it can be moved even after of_platform_populate()).
looks like it can be separate patch.


>>> Fixes: 12a7f17fac5b ("usb: dwc3: omap: fix race of pm runtime with...")
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> ---
>>>   drivers/usb/dwc3/dwc3-omap.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>>> index 9892650..cd9bef5 100644
>>> --- a/drivers/usb/dwc3/dwc3-omap.c
>>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>>> @@ -512,7 +512,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>>>   
>>>   	/* check the DMA Status */
>>>   	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
>>> -	irq_set_status_flags(omap->irq, IRQ_NOAUTOEN);
>>>   	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
>>>   					dwc3_omap_interrupt_thread, IRQF_SHARED,
>>>   					"dwc3-omap", omap);
>>> @@ -533,10 +532,10 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>>>   	}
>>>   
>>>   	dwc3_omap_enable_irqs(omap);
>>> -	enable_irq(omap->irq);
>>>   	return 0;
>>>   
>>>   err1:
>>> +	disable_irq(omap->irq);
>>>   	pm_runtime_put_sync(dev);
>>>   	pm_runtime_disable(dev);
>>>   

-- 
regards,
-grygorii
