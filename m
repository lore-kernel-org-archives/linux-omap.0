From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: omapfb: fix build for n770
Date: Fri, 16 Feb 2007 11:19:31 +0100
Message-ID: <85odnu2ymk.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=

This patch fix the build breakage introduced by the n800 fb update. It
has not been tested but at least the kernel is building now.
The change from sossi_extif to omap1_ext_if has been suggested by the
os2007on770 project
(http://maemo.org/maemowiki/Os2007On770?highlight=%28os2007%29).

[ Checking that the n770 defconfig is still building after adding a n800
update would be nice. It's known that the n800 2.6.18 kernel has some
not-n770-friendly changes ]

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=fix_n800fb_breakage.patch

---
 drivers/video/omap/sossi.c       |    3 	2 +	1 -	0 !
 include/asm-arm/arch-omap/irqs.h |    1 	1 +	0 -	0 !
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/include/asm-arm/arch-omap/irqs.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/irqs.h	2007-02-16 09:37:44.000000000 +0100
+++ linux-omap-2.6/include/asm-arm/arch-omap/irqs.h	2007-02-16 11:01:42.000000000 +0100
@@ -125,6 +125,7 @@
 #define INT_UART2		(15 + IH2_BASE)
 #define INT_BT_MCSI1TX		(16 + IH2_BASE)
 #define INT_BT_MCSI1RX		(17 + IH2_BASE)
+#define INT_SOSSI_MATCH		(19 + IH2_BASE)
 #define INT_USB_W2FC		(20 + IH2_BASE)
 #define INT_1WIRE		(21 + IH2_BASE)
 #define INT_OS_TIMER		(22 + IH2_BASE)
Index: linux-omap-2.6/drivers/video/omap/sossi.c
===================================================================
--- linux-omap-2.6.orig/drivers/video/omap/sossi.c	2007-02-16 09:45:32.000000000 +0100
+++ linux-omap-2.6/drivers/video/omap/sossi.c	2007-02-16 09:52:09.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/clk.h>
+#include <linux/irq.h>
 
 #include <asm/io.h>
 
@@ -661,7 +662,7 @@ static void sossi_cleanup(void)
 	clk_put(sossi.fck);
 }
 
-struct lcd_ctrl_extif sossi_extif = {
+struct lcd_ctrl_extif omap1_ext_if = {
 	.init			= sossi_init,
 	.cleanup		= sossi_cleanup,
 	.get_clk_info		= sossi_get_clk_info,

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
