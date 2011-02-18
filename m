From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: Have separate irq handlers for DISPC and
 DSI
Date: Fri, 18 Feb 2011 12:00:23 +0200
Message-ID: <1298023223.24062.24.camel@deskari>
References: <1297952702-13419-1-git-send-email-archit@ti.com>
	 <91F20383AC6A5F4DB94C692112281213B4C15EBB91@dlee07.ent.ti.com>
	 <4D5E3D35.9000902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38729 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab1BRKA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 05:00:27 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1IA0Q1Z007851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 04:00:26 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1IA0QxK003703
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 04:00:26 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1IA0QM6027203
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 04:00:26 -0600 (CST)
In-Reply-To: <4D5E3D35.9000902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, 2011-02-18 at 03:34 -0600, Taneja, Archit wrote:
> Hi,
> 
> On Friday 18 February 2011 02:40 PM, Valkeinen, Tomi wrote:
> > Hi,
> >
> > On Thu, 2011-02-17 at 08:25 -0600, Taneja, Archit wrote:
> >> Currently, the core DSS platform device requests for an irq line for OMAP2 and
> >> OMAP3. Make DISPC and DSI platform devices request for a shared IRQ line.
> >>
> >> On OMAP3, the logical OR of DSI and DISPC interrupt lines goes to the MPU. There
> >> is a register DSS_IRQSTATUS which tells if the interrupt came from DISPC or DSI.
> >>
> >> On OMAP2, there is no DSI, only DISPC interrupts goto the MPU. There is no
> >> DSS_IRQSTATUS register.
> >>
> >> Hence, it makes more sense to have separate irq handlers corresponding to the
> >> DSS sub modules instead of having a common handler.
> >>
> >> Since on OMAP3 the logical OR of the lines goes to MPU, the irq line is shared
> >> among the IRQ handlers.
> >>
> >> The hwmod irq info has been removed for DSS to DISPC and DSI for OMAP2 and OMAP3
> >> hwmod databases. The Probes of DISPC and DSI now request for irq handlers. A dss
> >> feature is also added to tell whether the irq lines is shared between DISPC and
> >> DSI or not.
> >
> > Yes, I think this looks much cleaner.
> >
> > However, I'm not sure if it's necessary to check the DSS_IRQSTATUS. It
> > depends a bit on how DSS_IRQSTATUS works. If it just mirrors the
> > DISPC/DSI_IRQSTATUS (ie, if there's any bit up in DSI_IRQSTATUS, the DSI
> > bit in DSS_IRQSTATUS is up), we can do without it.
> >
> > For example let's say we haven't enabled any interrupts in DSI, so
> > preferably we want to spend as little time in the dsi irq handler as
> > possible.
> >
> > Now, if DSI_IRQSTATUS is all zeroes, and thus DSS_IRQSTATUS.DSI is also
> > zero, we can skip the DSI handler by checking DSS_IRQSTATUS.DSI as you
> > do in this patch. But we could as well check DSI_IRQSTATUS, and exit if
> > it's all zeroes.
> >
> > If, on the other hand, DSI_IRQSTATUS has any bit up, then also
> > DSS_IRQSTATUS.DSI is up, and we have to check the DSI interrupts anyway.
> >
> > So in both cases the end result is the same, and we can do with less
> > code by not using DSS_IRQSTATUS.
> >
> > However, I'm not 100% sure DSS_IRQSTATUS works like that, but it would
> > sound logical and I don't know how could it work otherwise.
> 
> I can give it a try.
> 
> There is a figure in the OMAP3 TRM titled "DISPC and DSS Interrupts 
> tree" which shows its logical OR. How the bits are set in DSS_IRQSTATUS 
> is not mentioned anywhere though

Well, if DSS_IRQSTATUS doesn't work as I described above, in the worst
case we will just run a few more lines of code in the irq handler, as we
check for registered interrupts. But that would only happen if either
DISPC or DSI has no interrupts enabled, which is... never?

So I think it should work fine anyway.

 Tomi


