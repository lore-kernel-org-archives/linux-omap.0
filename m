From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: hwmod: Don't leave the optional clocks in clk_prepare()ed state
Date: Wed, 23 Apr 2014 11:41:04 +0530
Message-ID: <1398233465-8845-3-git-send-email-rnayak@ti.com>
References: <1398233465-8845-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60829 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbaDWGM6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 02:12:58 -0400
In-Reply-To: <1398233465-8845-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <bcousson@baylibre.com>

At hwmod init, theres no reason why optional clocks should be left in
clk_prepare()ed state as these are actually directly controlled by the
drivers themselves. Let the drivers prepare/unprepare as well as enable/
disable them.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 1f33f5d..9e3afc9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -857,15 +857,6 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 			continue;
 		}
 		oc->_clk = c;
-		/*
-		 * HACK: This needs a re-visit once clk_prepare() is implemented
-		 * to do something meaningful. Today its just a no-op.
-		 * If clk_prepare() is used at some point to do things like
-		 * voltage scaling etc, then this would have to be moved to
-		 * some point where subsystems like i2c and pmic become
-		 * available.
-		 */
-		clk_prepare(oc->_clk);
 	}
 
 	return ret;
@@ -945,7 +936,7 @@ static void _enable_optional_clocks(struct omap_hwmod *oh)
 		if (oc->_clk) {
 			pr_debug("omap_hwmod: enable %s:%s\n", oc->role,
 				 __clk_get_name(oc->_clk));
-			clk_enable(oc->_clk);
+			clk_prepare_enable(oc->_clk);
 		}
 }
 
@@ -960,7 +951,7 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
 		if (oc->_clk) {
 			pr_debug("omap_hwmod: disable %s:%s\n", oc->role,
 				 __clk_get_name(oc->_clk));
-			clk_disable(oc->_clk);
+			clk_disable_unprepare(oc->_clk);
 		}
 }
 
-- 
1.7.9.5

