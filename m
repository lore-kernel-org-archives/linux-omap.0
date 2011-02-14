From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Mon, 14 Feb 2011 16:30:01 +0200
Message-ID: <20110214143001.GK2549@legolas.emea.dhcp.ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com>
 <1297693307.2951.25.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:36232 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755181Ab1BNOaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 09:30:06 -0500
Received: by mail-bw0-f42.google.com with SMTP id 13so5761294bwz.29
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 06:30:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297693307.2951.25.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit taneja <archit@ti.com>, linux-omap@vger.kernel.org

Hi,

On Mon, Feb 14, 2011 at 04:21:47PM +0200, Tomi Valkeinen wrote:
> On Wed, 2011-02-02 at 08:56 +0000, archit taneja wrote:
> > OMAP2 has an irq line dedicated for DISPC interrupts, there is no DSI
> > on omap2.
> > OMAP3 has a common irq line for DISPC and DSI interrupts.
> > OMAP4 has seperate irq lines for DISPC and DSI Interrupts.
> > 
> > Use dss_features to have a common DSS irq handler for all OMAP revisions.
> > 
> > Also, use a member of the global dss structure to store the irq number
> > as it is used in 2 functions.
> 
> It's good to remove the cpu_is_xxxx() calls, but I'm not quite sure
> about this patch...
> 
> Could we use shared interrupt handlers here, so that dss.c would handle
> only DISPC interrupts (or should it be even in dispc.c?) and dsi.c would
> handle DSI interrupts?
> 
> On OMAP3 both dss.c and dsi.c would register to the same interrupt, and
> they would need to check if the interrupt was really for them. On OMAP4
> the code could be the same, even though the check is unnecessary.
> 
> Also, as I mentioned in the email I sent some minutes ago, this patch
> fixes the free_irq call in dss_exit. Things like that should never be
> fixed silently, even if it's trivial like in this case.

does it make sense to install an irq_chip for that ? I mean, can you
mask/unmask dss and or dsi IRQs ? If you can, then it might make sense
to take a look into GENIRQ and install an irq_chip for that. Then both
dsi and dss would be able to use standard request_irq() API.

Take a look at drivers/mfd/twl*irq.c and drivers/cbus/retu.c (the last
one on linux-omap only) there are examples of how that should be
implemented. Actually twl*irq.c is wrong, as it bypasses the threaded
IRQ stuff. I have some patches for those, but I'm not sure they are
working correctly yet, needs more testing. My twl4030-irq patches are
available at [1] for reference.

[1] http://gitorious.org/usb/usb/commits/twlirq

-- 
balbi
