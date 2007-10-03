From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in gpio.c
Date: Wed, 03 Oct 2007 09:09:37 +0200
Message-ID: <47034031.7010004@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030204040809030004050505"
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

This is a multi-part message in MIME format.
--------------030204040809030004050505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warning

arch/arm/plat-omap/gpio.c: In function '_omap_gpio_init':
arch/arm/plat-omap/gpio.c:1299: warning: unused variable 'clk_name'
arch/arm/plat-omap/gpio.c: At top level:
arch/arm/plat-omap/gpio.c:1282: warning: 'gpio_fck' defined but not used

for OMAP1.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------030204040809030004050505
Content-Type: text/plain;
 name="gpio_warning_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gpio_warning_fix.txt"

Index: linux-osk/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/gpio.c
+++ linux-osk/arch/arm/plat-omap/gpio.c
@@ -1277,8 +1277,11 @@ static inline void mpuio_init(void) {}
 /*---------------------------------------------------------------------*/
 
 static int initialized;
-#if !defined(CONFIG_ARCH_OMAP34XX)
+#if !defined(CONFIG_ARCH_OMAP3)
 static struct clk * gpio_ick;
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2)
 static struct clk * gpio_fck;
 #endif
 
@@ -1296,7 +1299,9 @@ static int __init _omap_gpio_init(void)
 {
 	int i;
 	struct gpio_bank *bank;
+#if defined(CONFIG_ARCH_OMAP3)
 	char clk_name[11];
+#endif
 
 	initialized = 1;
 

--------------030204040809030004050505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030204040809030004050505--
