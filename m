From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCHv6 1/2] drivers: spi: Add qspi flash controller
Date: Tue, 30 Jul 2013 13:04:28 +0530
Message-ID: <51F76C84.8080601@ti.com>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com> <1375082550-30544-2-git-send-email-sourav.poddar@ti.com> <20130729093128.GE23710@radagast> <51F63FF3.5070304@ti.com> <20130729102038.GK23710@radagast> <51F64C49.4080606@ti.com> <20130729110902.GE24801@radagast> <51F64EB6.5020807@ti.com> <20130729123515.GJ24801@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55132 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757643Ab3G3Hen (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 03:34:43 -0400
In-Reply-To: <20130729123515.GJ24801@radagast>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com

Hi Felipe,
On Monday 29 July 2013 06:05 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Jul 29, 2013 at 04:45:02PM +0530, Sourav Poddar wrote:
>>>>>>>> +	irq = platform_get_irq(pdev, 0);
>>>>>>>> +	if (irq<     0) {
>>>>>>>> +		dev_err(&pdev->dev, "no irq resource?\n");
>>>>>>>> +		return irq;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	spin_lock_init(&qspi->lock);
>>>>>>>> +
>>>>>>>> +	qspi->base = devm_ioremap_resource(&pdev->dev, r);
>>>>>>>> +	if (IS_ERR(qspi->base)) {
>>>>>>>> +		ret = PTR_ERR(qspi->base);
>>>>>>>> +		goto free_master;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	ret = devm_request_threaded_irq(&pdev->dev, irq, ti_qspi_isr,
>>>>>>>> +			ti_qspi_threaded_isr, IRQF_NO_SUSPEND | IRQF_ONESHOT,
>>>>>>> why do you need IRQF_NO_SUSPEND ?
>>>>>>>
>>>>>> I should get away with this.
>>>>> why ? Do you need or do you *not* need it ? And in either case, why ?
>>>>>
>>>> I was thinking, this will keep the irqs up even when we are
>>>> hitting suspend, we will not be prepared to handle it. ?
>>> won't be prepared in what way ?
>>>
>> Our driver will be down, so the irq might go un-serviced.
> only if you wrote the driver that way. IRQ subsystem doesn't know the
> state of the device, all it knows is that in case an IRQ fires, it needs
> to call the registered IRQ handler.
>
> Now the thing is:
>
> Initially you had the flag setup, so I asked why you needed it. I
> expected you to tell me why you think QSPI's IRQ shouldn't be disabled
> during suspend and the implications of disabling it.
>
> Instead you just changed your mind and decided to remove the flag.
>
> Because you changed your mind with no explanation, that tells me you
> haven't fully grasped how that flag works and what it means to set (or
> not set) it.
>
> My question now is simply: why don't you need that flag ? What are the
> implications of setting that flag ? How would your driver behave if an
> IRQ fired while your driver was suspended ? Unless you understand what
> it does, how can you understand the behavior or the driver ?
>
> cheers
>
We dont need IRQF_NO_SUSPEND flag in our qspi controller.

Qspi driver need to be prevented from receiving interrupts during system 
wide suspend/hibernation.
"suspend_device_irqs" in kernel/irq/pm.c marks interrupt line in use and 
sets IRQS_SUSPENDED
for them.
If we use "IRQF_NO_SUSPEND", we will bypass setting this IRQS_SUSPENDED 
flag, which is not.
desired


For this, interrupt lines need to
  and this function is provided for this purpose.
  * It marks all interrupt lines in use, except for the timer ones, as 
disabled
  * and sets the IRQS_SUSPENDED flag for each of them.

This flag gets used in __disable_irq api(kernel/irq/manage.c) which


