From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC 2/2] arm: mach-omap2: setup iclk autoidle according to flags
Date: Thu,  4 Oct 2018 07:51:47 +0200
Message-ID: <20181004055147.23048-3-andreas@kemnade.info>
References: <20181004055147.23048-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004055147.23048-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
that makes hwmods working properly which cannot handle
autoidle properly in lower power states.
Affected is e. g. the omap_hdq.
It also disables CM_AUTOIDLE_DSS. Need to check if
that is wanted or not.
Note: Autoidle is not enabled explicitly because there
might be clocks which do not support that operation and
it is enabled afterwards in arm/mach-omap2/pm.c anyways.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap2/omap_hwmod.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bb641e6c93d0..6f9687a4f421 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -131,6 +131,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clk/ti.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -2410,9 +2411,12 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 			continue;
 
 		if (os->flags & OCPIF_SWSUP_IDLE) {
-			/* XXX omap_iclk_deny_idle(c); */
+			omap2_clk_deny_idle(os->_clk);
 		} else {
-			/* XXX omap_iclk_allow_idle(c); */
+			/*
+			 * no allow_idle here since there is
+			 * later an allow idle in pm.c
+			 */
 			clk_enable(os->_clk);
 		}
 	}
-- 
2.11.0
