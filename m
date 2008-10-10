From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Git tree updated to v2.6.27, some issues remain
Date: Sat, 11 Oct 2008 03:45:14 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870239624A46@dbde02.ent.ti.com>
References: <20081010120427.GZ3044@atomide.com>
	 <200810100843.47808.david-b@pacbell.net>
 <5e088bd90810100857p2cea5429s810c9810f05bd341@mail.gmail.com>
 <FCCFB4CDC6E5564B9182F639FC3560870239624A2E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49177 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbYJJWP3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 18:15:29 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870239624A2E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

>Sent: Friday, October 10, 2008 3:50 PM
>To: Steve Sakoman; David Brownell; linux-omap@vger.kernel.org List
>Subject: RE: Git tree updated to v2.6.27, some issues remain
>
>>Sent: Friday, October 10, 2008 10:58 AM
>>To: David Brownell; linux-omap@vger.kernel.org List
>>Subject: Re: Git tree updated to v2.6.27, some issues remain
>>
>>On Fri, Oct 10, 2008 at 8:43 AM, David Brownell <david-b@pacbell.net> wrote:
>>> On Friday 10 October 2008, Tony Lindgren wrote:
>>>> Anything else not working right now?
>>>
>>> MUSB on Overo...
>>
>>Indeed.  Any theories?
>
>My theory -
>
>In: drivers/mfd/twl4030-core.c
>	struct resource r = {
>      	  .start = TWL4030_PWRIRQ_USB_PRES,
>	        .flags = IORESOURCE_IRQ,
>	};
>	status = platform_device_add_resources(pdev, &r, 1);
>
>where value of TWL4030_PWRIRQ_USB_PRES = 378
>
>
>In: drivers/i2c/chips/twl4030-usb.c
>       status = request_irq(twl->irq ^(378)^ , twl4030_usb_irq, 0, "twl4030_usb", twl);
>fails because 378 > NR_IRQS


Theory changed. NR_IRQS is 402. so above is not the issue.

Theory 2: 
When I debug on LDP board, I can see the failure happening in request_irq()

In T2-probe: 
	request_irq( ... )
		... 
		if (irq_desc[irq].status & IRQ_NOREQUEST)  
			return -EINVAL;	>>>> code returns from here !!! 
		...

>
>
>
>>
>>I am trying a second build with EHCI enabled to see if it still dies on boot.
>>
>>Steve
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

