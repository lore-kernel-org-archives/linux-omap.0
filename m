From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 09:45:11 +0200
Message-ID: <1297755911.2289.28.camel@deskari>
References: <1296636990-24775-1-git-send-email-archit@ti.com>
	 <1297693307.2951.25.camel@deskari>
	 <20110214143001.GK2549@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42100 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab1BOHpP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 02:45:15 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1F7jE87024503
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 01:45:14 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1F7jEfA015065
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 01:45:14 -0600 (CST)
In-Reply-To: <20110214143001.GK2549@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-02-14 at 08:30 -0600, Balbi, Felipe wrote:
> Hi,
> 
> On Mon, Feb 14, 2011 at 04:21:47PM +0200, Tomi Valkeinen wrote:
> > On Wed, 2011-02-02 at 08:56 +0000, archit taneja wrote:
> > > OMAP2 has an irq line dedicated for DISPC interrupts, there is no DSI
> > > on omap2.
> > > OMAP3 has a common irq line for DISPC and DSI interrupts.
> > > OMAP4 has seperate irq lines for DISPC and DSI Interrupts.
> > > 
> > > Use dss_features to have a common DSS irq handler for all OMAP revisions.
> > > 
> > > Also, use a member of the global dss structure to store the irq number
> > > as it is used in 2 functions.
> > 
> > It's good to remove the cpu_is_xxxx() calls, but I'm not quite sure
> > about this patch...
> > 
> > Could we use shared interrupt handlers here, so that dss.c would handle
> > only DISPC interrupts (or should it be even in dispc.c?) and dsi.c would
> > handle DSI interrupts?
> > 
> > On OMAP3 both dss.c and dsi.c would register to the same interrupt, and
> > they would need to check if the interrupt was really for them. On OMAP4
> > the code could be the same, even though the check is unnecessary.
> > 
> > Also, as I mentioned in the email I sent some minutes ago, this patch
> > fixes the free_irq call in dss_exit. Things like that should never be
> > fixed silently, even if it's trivial like in this case.
> 
> does it make sense to install an irq_chip for that ? I mean, can you
> mask/unmask dss and or dsi IRQs ? If you can, then it might make sense
> to take a look into GENIRQ and install an irq_chip for that. Then both
> dsi and dss would be able to use standard request_irq() API.
> 
> Take a look at drivers/mfd/twl*irq.c and drivers/cbus/retu.c (the last
> one on linux-omap only) there are examples of how that should be
> implemented. Actually twl*irq.c is wrong, as it bypasses the threaded
> IRQ stuff. I have some patches for those, but I'm not sure they are
> working correctly yet, needs more testing. My twl4030-irq patches are
> available at [1] for reference.

I'm not familiar with genirq/irq_chip. But yes, as Archit said, we can
mask/unmask DSS interrupts. I mean, there's only one interrupt line, but
DSS has irqstatus and irqenable registers that can be used.

If I understood correctly, irq_chip could be used to manage DSS and DSI
interrupts, but I don't know right away what that would mean in
practice, and would it make things easier or not. But this could be
something that needs more study, as there's a custom isr handling system
in DSS, and it would be nice if that could be replaced with genirq.

But I guess the main problem still remains with genirqs also: we have
one interrupt line on omap3, used by two separate modules. And one irq
on omap2, used by one module, and two irqs on omap4, used by two
modules.

 Tomi


