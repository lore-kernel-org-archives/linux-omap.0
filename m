From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] ARM: OMAP2+: Add support for dm814x and dra62x usb
Date: Fri,  4 Dec 2015 15:31:05 -0800
Message-ID: <1449271869-7614-3-git-send-email-tony@atomide.com>
References: <1449271869-7614-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449271869-7614-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The usb phys are different on dm814x compared to dm816x so we need to
use the clkdcoldo output for usb.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 38 +++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 6ee5ba5..7118755 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -104,8 +104,8 @@
  * The default .clkctrl_offs field is offset from CM_DEFAULT, that's
  * TRM 18.7.6 CM_DEFAULT device register values minus 0x500
  */
-#define DM816X_CM_DEFAULT_OFFSET	0x500
-#define DM816X_CM_DEFAULT_USB_CLKCTRL	(0x558 - DM816X_CM_DEFAULT_OFFSET)
+#define DM81XX_CM_DEFAULT_OFFSET	0x500
+#define DM81XX_CM_DEFAULT_USB_CLKCTRL	(0x558 - DM81XX_CM_DEFAULT_OFFSET)
 
 /* L3 Interconnect entries clocked at 125, 250 and 500MHz */
 static struct omap_hwmod dm81xx_alwon_l3_slow_hwmod = {
@@ -557,22 +557,42 @@ static struct omap_hwmod_class dm81xx_usbotg_class = {
 	.sysc = &dm81xx_usbhsotg_sysc,
 };
 
-static struct omap_hwmod dm81xx_usbss_hwmod = {
+static struct omap_hwmod dm814x_usbss_hwmod = {
+	.name		= "usb_otg_hs",
+	.clkdm_name	= "default_l3_slow_clkdm",
+	.main_clk	= "481c5260.adpll.clkdcoldo",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM81XX_CM_DEFAULT_USB_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &dm81xx_usbotg_class,
+};
+
+static struct omap_hwmod_ocp_if dm814x_default_l3_slow__usbss = {
+	.master		= &dm81xx_default_l3_slow_hwmod,
+	.slave		= &dm814x_usbss_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod dm816x_usbss_hwmod = {
 	.name		= "usb_otg_hs",
 	.clkdm_name	= "default_l3_slow_clkdm",
 	.main_clk	= "sysclk6_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs = DM816X_CM_DEFAULT_USB_CLKCTRL,
+			.clkctrl_offs = DM81XX_CM_DEFAULT_USB_CLKCTRL,
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
 	.class		= &dm81xx_usbotg_class,
 };
 
-static struct omap_hwmod_ocp_if dm81xx_default_l3_slow__usbss = {
+static struct omap_hwmod_ocp_if dm816x_default_l3_slow__usbss = {
 	.master		= &dm81xx_default_l3_slow_hwmod,
-	.slave		= &dm81xx_usbss_hwmod,
+	.slave		= &dm816x_usbss_hwmod,
 	.clk		= "sysclk6_ck",
 	.user		= OCP_USER_MPU,
 };
@@ -1301,8 +1321,6 @@ static struct omap_hwmod_ocp_if dm81xx_tptc3__alwon_l3_fast = {
 /*
  * REVISIT: Test and enable the following once clocks work:
  * dm81xx_l4_ls__mailbox
- * dm81xx_alwon_l3_slow__gpmc
- * dm81xx_default_l3_slow__usbss
  *
  * Also note that some devices share a single clkctrl_offs..
  * For example, i2c1 and 3 share one, and i2c2 and 4 share one.
@@ -1337,6 +1355,8 @@ static struct omap_hwmod_ocp_if *dm814x_hwmod_ocp_ifs[] __initdata = {
 	&dm814x_l4_ls__timer2,
 	&dm814x_l4_hs__cpgmac0,
 	&dm814x_cpgmac0__mdio,
+	&dm81xx_alwon_l3_slow__gpmc,
+	&dm814x_default_l3_slow__usbss,
 	&dm814x_alwon_l3_med__mmc3,
 	NULL,
 };
@@ -1384,7 +1404,7 @@ static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	&dm81xx_tptc2__alwon_l3_fast,
 	&dm81xx_tptc3__alwon_l3_fast,
 	&dm81xx_alwon_l3_slow__gpmc,
-	&dm81xx_default_l3_slow__usbss,
+	&dm816x_default_l3_slow__usbss,
 	NULL,
 };
 
-- 
2.6.2
