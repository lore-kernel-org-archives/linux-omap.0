From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 13:42:33 +0200
Message-ID: <20110215114232.GO2570@legolas.emea.dhcp.ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com>
 <1297693307.2951.25.camel@deskari>
 <20110214143001.GK2549@legolas.emea.dhcp.ti.com>
 <4D5A00E8.4060701@ti.com>
 <1297754826.2289.9.camel@deskari>
 <4D5A39AE.3030006@ti.com>
 <1297759057.2289.40.camel@deskari>
 <20110215105749.GL2570@legolas.emea.dhcp.ti.com>
 <1297769134.5628.8.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33776 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753787Ab1BOLmj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 06:42:39 -0500
Received: by mail-gy0-f182.google.com with SMTP id 15so24911gyc.27
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 03:42:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297769134.5628.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Taneja, Archit" <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, Feb 15, 2011 at 01:25:34PM +0200, Tomi Valkeinen wrote:
> > On Tue, Feb 15, 2011 at 10:37:37AM +0200, Tomi Valkeinen wrote:
> > > > This approach looks clean, but isn't IRQF_SHARED used the other way 
> > > > around. One irq line and multiple handlers?
> > > 
> > > That is the case here, isn't it (on omap3)? One interrupt line (the DSS
> > > irq, the same returned both from dsi.pdev and dispc.pdev), and two
> > > handlers, one in dispc and one in dsi? Or what do you mean?
> > 
> > IMO, for omap3 it would be better to have irq_chip there. Then you can
> > keep e.g. DISPC IRQ disabled until dispc.c calls request_irq(). What
> > happens today if you have IRQ enabled but dispc isn't ready to act on
> > those ?
> 
> Currently we have a single interrupt handler, which then calls either
> dispc and/or dsi handler. Dispc and dsi are always ready to handle
> those.

Exactly the kind of thing irq_chip would help you :-)

> I don't think it would be a good solution if irq_chip would be used only
> for omap3. Then we'd have totally different solutions for different omap
> versions. But if irq_chip can be easily used for all omap versions, then
> perhaps.

But the HW is different anyway. On OMAP3 you're connect to a DSS irq
demuxer, on OMAP4 you have dedicated lines straight from OMAP's INTC.

> > > On omap2 there's no dsi code ran, so dispc is the only one requesting
> > > the irq, and thus IRQF_SHARED is extra. In omap4 there are separate irq
> > > lines (dsi.pdev and dispc.pdev return different irqs), and so
> > > IRQF_SHARED is again extra. But I don't see any harm in IRQF_SHARED even
> > > in omap2/4.
> > 
> > What if another HW requests the wrong IRQ number and it ends up being
> > your dispc IRQ line ?
> 
> Are you asking what happens if we have a bug in kernel code? Anything
> can happen =). But I don't see that as a reason not to use IRQF_SHARED.

ok, I have to agree. :-) But you will be allowing for that to happen. If
you don't IRQF_SHARED, request_irq() will fail on the second call with
-EBUSY I believe.

-- 
balbi
