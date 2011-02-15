From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 10:37:37 +0200
Message-ID: <1297759057.2289.40.camel@deskari>
References: <1296636990-24775-1-git-send-email-archit@ti.com>
	 <1297693307.2951.25.camel@deskari>
	 <20110214143001.GK2549@legolas.emea.dhcp.ti.com>  <4D5A00E8.4060701@ti.com>
	 <1297754826.2289.9.camel@deskari>  <4D5A39AE.3030006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47821 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754469Ab1BOIhl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:37:41 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1F8beqx024389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 02:37:40 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1F8bel1001186
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 02:37:40 -0600 (CST)
In-Reply-To: <4D5A39AE.3030006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-02-15 at 02:30 -0600, Taneja, Archit wrote:
> Hi,
> 
> On Tuesday 15 February 2011 12:57 PM, Valkeinen, Tomi wrote:
> 
> <snip>
> 
> > I meant something like this:
> >
> > dispc.c:
> >
> > dispc_init()
> > {
> > 	/* did we have a pdev for dispc? if not, this needs to be dss.pdev */
> > 	request_irq(platform_get_irq(dispc.pdev, 0), irq_handler, IRQF_SHARED, "dispc irq", foo);
> > }
> >
> > irq_handler()
> > {
> > 	if (irq_can_be_shared) {
> > 		check if the irq is for us. exit if not;
> > 	}
> >
> > 	handle;
> > }
> >
> > dsi.c:
> >
> > dsi_init()
> > {
> > 	request_irq(platform_get_irq(dsi.pdev, 0), irq_handler, IRQF_SHARED, "dsi irq", foo);
> > }
> >
> > irq_handler()
> > {
> > 	if (irq_can_be_shared) {
> > 		check if the irq is for us. exit if not;
> > 	}
> >
> > 	handle;
> > }
> >
> 
> This approach looks clean, but isn't IRQF_SHARED used the other way 
> around. One irq line and multiple handlers?

That is the case here, isn't it (on omap3)? One interrupt line (the DSS
irq, the same returned both from dsi.pdev and dispc.pdev), and two
handlers, one in dispc and one in dsi? Or what do you mean?

On omap2 there's no dsi code ran, so dispc is the only one requesting
the irq, and thus IRQF_SHARED is extra. In omap4 there are separate irq
lines (dsi.pdev and dispc.pdev return different irqs), and so
IRQF_SHARED is again extra. But I don't see any harm in IRQF_SHARED even
in omap2/4.

 Tomi


