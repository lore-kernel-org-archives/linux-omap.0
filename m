From: archit taneja <archit@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 13:50:49 +0530
Message-ID: <4D5A3761.2090103@ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com> <1297693307.2951.25.camel@deskari> <20110214143001.GK2549@legolas.emea.dhcp.ti.com> <4D5A00E8.4060701@ti.com> <20110215080555.GB2570@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156Ab1BOIT6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 03:19:58 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1F8Jsgg028480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 02:19:57 -0600
In-Reply-To: <20110215080555.GB2570@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 15 February 2011 01:35 PM, Balbi, Felipe wrote:
> Hi,
>
> On Tue, Feb 15, 2011 at 09:58:24AM +0530, archit taneja wrote:
>>> does it make sense to install an irq_chip for that ? I mean, can you
>>> mask/unmask dss and or dsi IRQs ? If you can, then it might make sense
>>> to take a look into GENIRQ and install an irq_chip for that. Then both
>>> dsi and dss would be able to use standard request_irq() API.
>>>
>>
>> We could disable dsi IRQs by masking all the possible interrupt
>> events in DSI_IRQSTATUS. The same goes for dispc. Is this what you
>> meant by masking/unmasking irqs?
>
> yes it is. Then it makes sense to have an irq_chip for those two irqs, I
> think.
>
> /proc/interrupt will reflect how the hardware works (DSI and DISPC IRQs
> being handled by DSS), both dsi and dispc can use normal request_irq()
> without setting IRQF_SHARED, etc etc. All you need to do is:
>
> static struct irq_chip dss_irq_chip = {
> 	.name			= "DSS",
> 	.irq_bus_lock		= dss_bus_lock,
> 	.irq_bus_sync_unlock	= dss_bus_sync_unlock,
> 	.irq_mask		= dss_irq_mask,
> 	.irq_unmask		= dss_irq_unmask,
> 	.irq_ack		= dss_irq_ack,
> };
>
> then, somewhere during probe() you have to:
>
> for (irq = irq_base; irq<  irq_end; irq++) {
> #ifdef CONFIG_ARM
> 	set_irq_flags(irq, IRQF_VALID)
> #else
> 	set_irq_noprobe(irq);
> #endif
>
> 	set_irq_data(irq, dss_device_structure_pointer);
> 	set_irq_chip_and_handler(irq,&dss_irq_chip,
> 		handle_simple_irq);
> }
>
> and on exit() you just need to cleanup:
>
> for (irq = irq_base; irq<  irq_end; irq++) {
> #ifdef CONFIG_ARM
> 	set_irq_flags(irq, 0)
> #endif
>
> 	set_irq_chip_and_handler(irq, NULL, NULL);
> 	set_irq_data(irq, NULL);
> }
>

Thanks for the info, but this seems to be suitable for the case
when there are multiple irq events coming from the same interrupt line. 
On OMAP4 we have 4 different IRQ lines going to ARM, i.e 4 lines defined 
in irqs-44xx.h.

We are looking for a common irq handler located somewhere centrally, and 
each module can hook their irq line to this handler.

Does irq_chip do this? what does irq_base and irq_end signify?

Regards,
Archit
