From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 12:57:49 +0200
Message-ID: <20110215105749.GL2570@legolas.emea.dhcp.ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com>
 <1297693307.2951.25.camel@deskari>
 <20110214143001.GK2549@legolas.emea.dhcp.ti.com>
 <4D5A00E8.4060701@ti.com>
 <1297754826.2289.9.camel@deskari>
 <4D5A39AE.3030006@ti.com>
 <1297759057.2289.40.camel@deskari>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:59666 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393Ab1BOK54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 05:57:56 -0500
Received: by yia28 with SMTP id 28so11450yia.29
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 02:57:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297759057.2289.40.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, Feb 15, 2011 at 10:37:37AM +0200, Tomi Valkeinen wrote:
> > This approach looks clean, but isn't IRQF_SHARED used the other way 
> > around. One irq line and multiple handlers?
> 
> That is the case here, isn't it (on omap3)? One interrupt line (the DSS
> irq, the same returned both from dsi.pdev and dispc.pdev), and two
> handlers, one in dispc and one in dsi? Or what do you mean?

IMO, for omap3 it would be better to have irq_chip there. Then you can
keep e.g. DISPC IRQ disabled until dispc.c calls request_irq(). What
happens today if you have IRQ enabled but dispc isn't ready to act on
those ?

> On omap2 there's no dsi code ran, so dispc is the only one requesting
> the irq, and thus IRQF_SHARED is extra. In omap4 there are separate irq
> lines (dsi.pdev and dispc.pdev return different irqs), and so
> IRQF_SHARED is again extra. But I don't see any harm in IRQF_SHARED even
> in omap2/4.

What if another HW requests the wrong IRQ number and it ends up being
your dispc IRQ line ?

-- 
balbi
