From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: twl4030: make power_companion_init static
Date: Tue, 31 Jul 2007 11:18:37 -0700
Message-ID: <20070731181837.518602875@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is not used outside twl4030, make it static.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 drivers/i2c/chips/twl4030_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.21/drivers/i2c/chips/twl4030_core.c
===================================================================
--- linux-2.6.21.orig/drivers/i2c/chips/twl4030_core.c
+++ linux-2.6.21/drivers/i2c/chips/twl4030_core.c
@@ -669,7 +669,7 @@ static int unprotect_pm_master(void)
 	return e;
 }
 
-int power_companion_init(void)
+static int power_companion_init(void)
 {
 	struct clk *osc;
 	u32 rate, ctrl = HFCLK_FREQ_26_MHZ;
--
