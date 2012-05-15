From: Paul Walmsley <paul@pwsan.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Tue, 15 May 2012 11:55:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com>
References: <1336033721.14378.2.camel@deskari>  <WC20120503084938.900446@terrafix.co.uk>  <1336050442.14378.10.camel@deskari>  <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>  <1336140072.2552.6.camel@deskari>
 <WC20120504140943.7604D0@terrafix.co.uk>  <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>  <1336483598.5761.45.camel@deskari> <WC20120514073642.6306D7@terrafix.co.uk> <1336982138.2532.32.camel@lappyti>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60296 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757065Ab2EORzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 13:55:35 -0400
In-Reply-To: <1336982138.2532.32.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

Hello Tomi,

On Mon, 14 May 2012, Tomi Valkeinen wrote:

> I've been doing testing to understand the problem, but so far I don't
> have any idea why things go wrong. I haven't found out any logic in
> which configuration works and which doesn't. Looks to me that for some
> reason the PM prevents DSS from getting data fast enough with certain
> fifo thresholds.
> 
> I have two ways to avoid the problem, but I've been reluctant to make
> patches for those because I feel it's just hiding the problem. One way
> is to change DISPC SIDLEMODE or MIDLEMODE to disallow idle/standby. The
> other is to use certain fifo threshold values, which just seem to work
> for unknown reasons.
> 
> Considering that we already have a SIDLEMODE hack in DSS for omap3 when
> using DSI, I wonder if the omap3 PM + DSS combination is just plain
> broken, and we should disallow idle. I'm not quite sure what are the
> implications of that.
> 
> I'd appreciate comments from the PM people =).

This may be caused by one of the DPLLs going into autoidle.  This can 
involve a significant wakeup latency.  I'd suggest looking at DPLL3, which 
provides the DSS interface clock, and DPLL4, which can provide the DSS 
functional clock.

Could you try:

1. applying something like the patch at the bottom of this message and 
seeing if it makes any difference?

2. if #1 does not work, changing the "dpll3" in the patch to "dpll4" ?

3. if #2 does not work, disabling autoidle on both dpll3 and dpll4?


I regret that I haven't been able to focus more on DSS issues -

- Paul


Date: Wed, 14 Mar 2012 17:49:43 -0600 (MDT)
From: Paul Walmsley <paul@pwsan.com>
Subject: Patch that should disable DPLL3 autoidle


 Test patch to disable DPLL3 autoidle.

---
 arch/arm/plat-omap/clock.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 567e4b5..4b02b35 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -351,6 +351,13 @@ int omap_clk_enable_autoidle_all(void)
 		if (c->ops->allow_idle)
 			c->ops->allow_idle(c);
 
+	c = clk_get(NULL, "dpll3_ck");
+	if (c && c->ops->deny_idle)
+		c->ops->deny_idle(c);
+	else
+		WARN(1, "Cannot disable autoidle on DPLL3\n");
+	clk_put(c);
+
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return 0;
-- 
1.7.9.1

