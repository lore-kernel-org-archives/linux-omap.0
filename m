From: Paul Walmsley <paul@pwsan.com>
Subject: Re: clk_disable_unused() is bugged
Date: Wed, 24 Sep 2008 08:09:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0809240807450.15312@utopia.booyaka.com>
References: <B71CE868F2BC2847B3F23C5A8EE39430890B53@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40435 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbYIXOJw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:09:52 -0400
In-Reply-To: <B71CE868F2BC2847B3F23C5A8EE39430890B53@vaebe110.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

Hello Tero (and anyone else),

On Wed, 24 Sep 2008, Tero.Kristo@nokia.com wrote:

> clk_disable_unused (in plat-omap/clock.c) is bugged in latest kernel. It
> checks whether ck->enable_reg is zero, and in most cases this happens to
> be so (CM_FCLKEN = 0.) Seems to be caused by some late change to
> clocktree where enable_reg fields are defined as module offsets, not
> register addresses. This bug causes several clocks to remain enabled
> after boot, and at least on OMAP3 it prevents retention.
> 
> Paul, you got a fix coming for this?

Yes, here's something that should at least fix the clk_disable_unused() 
problem.  It seems to work on 2430SDP and 3430SDP here.  

Any other help testing from anyone else is appreciated -


- Paul


Author: Paul Walmsley <paul@pwsan.com>
Date:   Wed Sep 24 04:48:05 2008 -0600

    OMAP2/3 clock: fix CONFIG_OMAP_RESET_CLOCKS
    
    plat-omap/clock.c was skipping clocks with enable_reg == 0.  This no longer
    works now that we use enable_reg as an offset from a PRCM module.
    
    Problem found and traced by Tero Kristo <tero.kristo@nokia.com> -
    thanks Tero.
    
    Signed-off-by: Paul Walmsley <paul@pwsan.com>

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 197974d..7bbfba2 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -384,8 +384,11 @@ static int __init clk_disable_unused(void)
 	unsigned long flags;
 
 	list_for_each_entry(ck, &clocks, node) {
-		if (ck->usecount > 0 || (ck->flags & ALWAYS_ENABLED) ||
-			ck->enable_reg == 0)
+		if (ck->usecount > 0 ||
+		    (ck->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK)))
+			continue;
+
+		if (cpu_class_is_omap1() && ck->enable_reg == 0)
 			continue;
 
 		spin_lock_irqsave(&clockfw_lock, flags);
