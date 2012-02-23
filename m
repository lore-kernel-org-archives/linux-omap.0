From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Set Kconfig dependencies for PROC_DEVICETREE
Date: Thu, 23 Feb 2012 14:19:45 -0800
Message-ID: <20120223221944.GC18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35236 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab2BWWTs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 17:19:48 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

Otherwise we get:

warning: (ARCH_OMAP2PLUS) selects PROC_DEVICETREE which has
unmet direct dependencies (OF && PROC_FS && !SPARC)

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Looks like this is needed for what we have queued in the
omap dt branch.

--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -26,7 +26,7 @@ config ARCH_OMAP2PLUS
 	select GENERIC_IRQ_CHIP
 	select OMAP_DM_TIMER
 	select USE_OF
-	select PROC_DEVICETREE
+	select PROC_DEVICETREE if PROC_FS
 	help
 	  "Systems based on OMAP2, OMAP3 or OMAP4"
 
