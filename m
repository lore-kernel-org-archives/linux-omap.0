From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Make dummy wrapper if the OMAP_GPIO_SWITCH is
	not set
Date: Thu, 29 Nov 2007 17:01:37 +0900
Message-ID: <20071129080137.GA1395@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

OMAP_GPIO_SIWTCH is optional, so omap_reister_gpio_switches will be null.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/include/asm-arm/arch-omap/gpio-switch.h b/include/asm-arm/arch-omap/gpio-switch.h
index 10da0e0..a143253 100644
--- a/include/asm-arm/arch-omap/gpio-switch.h
+++ b/include/asm-arm/arch-omap/gpio-switch.h
@@ -48,7 +48,11 @@ struct omap_gpio_switch {
 };
 
 /* Call at init time only */
+#ifdef CONFIG_OMAP_GPIO_SWITCH
 extern void omap_register_gpio_switches(const struct omap_gpio_switch *tbl,
 					int count);
+#else
+#define omap_register_gpio_switches(tbl, count)	do { } while (0)
+#endif
 
 #endif
