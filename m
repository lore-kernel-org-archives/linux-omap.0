From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 13:25:34 +0200
Message-ID: <1297769134.5628.8.camel@deskari>
References: <1296636990-24775-1-git-send-email-archit@ti.com>
	 <1297693307.2951.25.camel@deskari>
	 <20110214143001.GK2549@legolas.emea.dhcp.ti.com> <4D5A00E8.4060701@ti.com>
	 <1297754826.2289.9.camel@deskari> <4D5A39AE.3030006@ti.com>
	 <1297759057.2289.40.camel@deskari>
	 <20110215105749.GL2570@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56194 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515Ab1BOLZj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 06:25:39 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1FBPcva018033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 05:25:38 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1FBPclp006896
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 05:25:38 -0600 (CST)
In-Reply-To: <20110215105749.GL2570@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-02-15 at 04:57 -0600, Balbi, Felipe wrote:
> Hi,
> 
> On Tue, Feb 15, 2011 at 10:37:37AM +0200, Tomi Valkeinen wrote:
> > > This approach looks clean, but isn't IRQF_SHARED used the other way 
> > > around. One irq line and multiple handlers?
> > 
> > That is the case here, isn't it (on omap3)? One interrupt line (the DSS
> > irq, the same returned both from dsi.pdev and dispc.pdev), and two
> > handlers, one in dispc and one in dsi? Or what do you mean?
> 
> IMO, for omap3 it would be better to have irq_chip there. Then you can
> keep e.g. DISPC IRQ disabled until dispc.c calls request_irq(). What
> happens today if you have IRQ enabled but dispc isn't ready to act on
> those ?

Currently we have a single interrupt handler, which then calls either
dispc and/or dsi handler. Dispc and dsi are always ready to handle
those.

I don't think it would be a good solution if irq_chip would be used only
for omap3. Then we'd have totally different solutions for different omap
versions. But if irq_chip can be easily used for all omap versions, then
perhaps.

But then again, using IRQF_SHARED should (I think) solve the problem
quite easily without big changes to the code. irq_chip sounds like a
bigger change.

> > On omap2 there's no dsi code ran, so dispc is the only one requesting
> > the irq, and thus IRQF_SHARED is extra. In omap4 there are separate irq
> > lines (dsi.pdev and dispc.pdev return different irqs), and so
> > IRQF_SHARED is again extra. But I don't see any harm in IRQF_SHARED even
> > in omap2/4.
> 
> What if another HW requests the wrong IRQ number and it ends up being
> your dispc IRQ line ?

Are you asking what happens if we have a bug in kernel code? Anything
can happen =). But I don't see that as a reason not to use IRQF_SHARED.

 Tomi


