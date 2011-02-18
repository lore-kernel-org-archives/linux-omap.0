From: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: Have separate irq handlers for DISPC and DSI
Date: Fri, 18 Feb 2011 03:10:26 -0600
Message-ID: <91F20383AC6A5F4DB94C692112281213B4C15EBB91@dlee07.ent.ti.com>
References: <1297952702-13419-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34221 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757819Ab1BRJKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 04:10:41 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1I9Ae4E026829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 03:10:40 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1I9Ael3018306
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 03:10:40 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1I9Ae8O009688
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 03:10:40 -0600 (CST)
In-Reply-To: <1297952702-13419-1-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Thu, 2011-02-17 at 08:25 -0600, Taneja, Archit wrote:
> Currently, the core DSS platform device requests for an irq line for OMAP2 and
> OMAP3. Make DISPC and DSI platform devices request for a shared IRQ line.
> 
> On OMAP3, the logical OR of DSI and DISPC interrupt lines goes to the MPU. There
> is a register DSS_IRQSTATUS which tells if the interrupt came from DISPC or DSI.
> 
> On OMAP2, there is no DSI, only DISPC interrupts goto the MPU. There is no
> DSS_IRQSTATUS register.
> 
> Hence, it makes more sense to have separate irq handlers corresponding to the
> DSS sub modules instead of having a common handler.
> 
> Since on OMAP3 the logical OR of the lines goes to MPU, the irq line is shared
> among the IRQ handlers.
> 
> The hwmod irq info has been removed for DSS to DISPC and DSI for OMAP2 and OMAP3
> hwmod databases. The Probes of DISPC and DSI now request for irq handlers. A dss
> feature is also added to tell whether the irq lines is shared between DISPC and
> DSI or not.

Yes, I think this looks much cleaner.

However, I'm not sure if it's necessary to check the DSS_IRQSTATUS. It
depends a bit on how DSS_IRQSTATUS works. If it just mirrors the
DISPC/DSI_IRQSTATUS (ie, if there's any bit up in DSI_IRQSTATUS, the DSI
bit in DSS_IRQSTATUS is up), we can do without it.

For example let's say we haven't enabled any interrupts in DSI, so
preferably we want to spend as little time in the dsi irq handler as
possible.

Now, if DSI_IRQSTATUS is all zeroes, and thus DSS_IRQSTATUS.DSI is also
zero, we can skip the DSI handler by checking DSS_IRQSTATUS.DSI as you
do in this patch. But we could as well check DSI_IRQSTATUS, and exit if
it's all zeroes.

If, on the other hand, DSI_IRQSTATUS has any bit up, then also
DSS_IRQSTATUS.DSI is up, and we have to check the DSI interrupts anyway.

So in both cases the end result is the same, and we can do with less
code by not using DSS_IRQSTATUS.

However, I'm not 100% sure DSS_IRQSTATUS works like that, but it would
sound logical and I don't know how could it work otherwise.

 Tomi

