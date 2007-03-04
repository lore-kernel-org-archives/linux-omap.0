From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] board_nokia770: add hwa742 platform data
Date: Sun, 04 Mar 2007 12:39:02 +0100
Message-ID: <85ejo5i6g9.fsf@orfeo.duckcorp.org>
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


The n800fb changes introduced some platform_data for the hwa742 and
needs now to be defined for getting it working.  This patch adds the
necessary bits needed for getting fb working again on n770.
This patch comes from the n800 kernel from maemo.org


Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=n770_add_hwa_clocks.patch

---
 arch/arm/mach-omap1/board-nokia770.c |   45 	45 +	0 -	0 !
 1 file changed, 45 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap1/board-nokia770.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap1/board-nokia770.c	2007-03-02 23:21:40.000000000 +0100
+++ linux-omap-2.6/arch/arm/mach-omap1/board-nokia770.c	2007-03-03 17:26:59.000000000 +0100
@@ -34,7 +34,9 @@
 #include <asm/arch/dsp_common.h>
 #include <asm/arch/aic23.h>
 #include <asm/arch/gpio.h>
+#include <asm/arch/omapfb.h>
 #include <asm/arch/lcd_mipid.h>
+#include <asm/arch/hwa742.h>
 
 #include "../plat-omap/dsp/dsp_common.h"
 
@@ -164,6 +166,48 @@ static struct spi_board_info nokia770_sp
 	},
 };
 
+static struct {
+	struct clk *sys_ck;
+} hwa742;
+
+static int hwa742_get_clocks(void)
+{
+	hwa742.sys_ck = clk_get(NULL, "bclk");
+	if (IS_ERR(hwa742.sys_ck)) {
+		printk(KERN_ERR "can't get HWA742 clock\n");
+		return PTR_ERR(hwa742.sys_ck);
+	}
+	return 0;
+}
+
+static unsigned long hwa742_get_clock_rate(struct device *dev)
+{
+	return clk_get_rate(hwa742.sys_ck);
+}
+
+static void hwa742_power_up(struct device *dev)
+{
+	clk_enable(hwa742.sys_ck);
+}
+
+static void hwa742_power_down(struct device *dev)
+{
+	clk_disable(hwa742.sys_ck);
+}
+
+static struct hwa742_platform_data nokia770_hwa742_platform_data = {
+	.get_clock_rate	= hwa742_get_clock_rate,
+	.power_up	= hwa742_power_up,
+	.power_down	= hwa742_power_down,
+	.te_connected	= 1,
+};
+
+static void hwa742_dev_init(void)
+{
+	hwa742_get_clocks();
+	omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
+}
+
 
 /* assume no Mini-AB port */
 
@@ -332,6 +376,7 @@ static void __init omap_nokia770_init(vo
 	omap_gpio_init();
 	omap_serial_init();
 	omap_dsp_init();
+	hwa742_dev_init();
 	lph8923_dev_init();
 	ads7846_dev_init();
 }

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
