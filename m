From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 10:23:53 +0200
Message-ID: <20110215082353.GF2570@legolas.emea.dhcp.ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com>
 <1297693307.2951.25.camel@deskari>
 <20110214143001.GK2549@legolas.emea.dhcp.ti.com>
 <4D5A00E8.4060701@ti.com>
 <20110215080555.GB2570@legolas.emea.dhcp.ti.com>
 <4D5A3761.2090103@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49585 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754297Ab1BOIX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:23:59 -0500
Received: by gxk25 with SMTP id 25so2950873gxk.23
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:23:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5A3761.2090103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit taneja <archit@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, Feb 15, 2011 at 01:50:49PM +0530, archit taneja wrote:
> >yes it is. Then it makes sense to have an irq_chip for those two irqs, I
> >think.
> >
> >/proc/interrupt will reflect how the hardware works (DSI and DISPC IRQs
> >being handled by DSS), both dsi and dispc can use normal request_irq()
> >without setting IRQF_SHARED, etc etc. All you need to do is:
> >
> >static struct irq_chip dss_irq_chip = {
> >	.name			= "DSS",
> >	.irq_bus_lock		= dss_bus_lock,
> >	.irq_bus_sync_unlock	= dss_bus_sync_unlock,
> >	.irq_mask		= dss_irq_mask,
> >	.irq_unmask		= dss_irq_unmask,
> >	.irq_ack		= dss_irq_ack,
> >};
> >
> >then, somewhere during probe() you have to:
> >
> >for (irq = irq_base; irq<  irq_end; irq++) {
> >#ifdef CONFIG_ARM
> >	set_irq_flags(irq, IRQF_VALID)
> >#else
> >	set_irq_noprobe(irq);
> >#endif
> >
> >	set_irq_data(irq, dss_device_structure_pointer);
> >	set_irq_chip_and_handler(irq,&dss_irq_chip,
> >		handle_simple_irq);
> >}
> >
> >and on exit() you just need to cleanup:
> >
> >for (irq = irq_base; irq<  irq_end; irq++) {
> >#ifdef CONFIG_ARM
> >	set_irq_flags(irq, 0)
> >#endif
> >
> >	set_irq_chip_and_handler(irq, NULL, NULL);
> >	set_irq_data(irq, NULL);
> >}
> >
> 
> Thanks for the info, but this seems to be suitable for the case
> when there are multiple irq events coming from the same interrupt
> line. On OMAP4 we have 4 different IRQ lines going to ARM, i.e 4
> lines defined in irqs-44xx.h.

do you have 4 lines for 4 different modules ? If so, what's the problem
here ? The irq_chip you're using is INTC

> We are looking for a common irq handler located somewhere centrally,
> and each module can hook their irq line to this handler.
> 
> Does irq_chip do this? what does irq_base and irq_end signify?

I guess it can't do that, no. irq_base is the starting number for this
irq_chip's IRQ and irq_end is irq_base + number_of_irqs.

-- 
balbi
