From: Thomas Weber <weber@corscience.de>
Subject: [PATCHv2 03/11] OMAP2: Devkit8000: Enable DVI-D output
Date: Wed,  2 Jun 2010 13:37:43 +0200
Message-ID: <1275478671-24563-4-git-send-email-weber@corscience.de>
References: <1275478671-24563-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1275478671-24563-1-git-send-email-weber@corscience.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Kan-Ru Chen <kanru@0xlab.org>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Kan-Ru Chen <kanru@0xlab.org>

This patch corrects the DVI-D output setup of Devkit8000

Devkit8000 has different DVI reset pin with the BeagleBoard.
On Devkit8000 the TWL4030 GPIO_7 is assigned to do the job.

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
---
 arch/arm/mach-omap2/board-devkit8000.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 3bde0e6..17a2517 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -140,13 +140,18 @@ static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 }
+
 static int devkit8000_panel_enable_dvi(struct omap_dss_device *dssdev)
 {
+	if (dssdev->reset_gpio != -EINVAL)
+		gpio_set_value(dssdev->reset_gpio, 1);
 	return 0;
 }
 
 static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
 {
+	if (dssdev->reset_gpio != -EINVAL)
+		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
 static int devkit8000_panel_enable_tv(struct omap_dss_device *dssdev)
@@ -186,6 +191,7 @@ static struct omap_dss_device devkit8000_dvi_device = {
 	.driver_name            = "generic_panel",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines     = 24,
+	.reset_gpio             = -EINVAL, /* will be replaced */
 	.platform_enable        = devkit8000_panel_enable_dvi,
 	.platform_disable       = devkit8000_panel_disable_dvi,
 };
@@ -272,6 +278,15 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	devkit8000_vmmc1_supply.dev = mmc[0].dev;
 	devkit8000_vsim_supply.dev = mmc[0].dev;
 
+	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
+	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
+
+	/* gpio + 7 is "DVI_PD" (out, active low) */
+	devkit8000_dvi_device.reset_gpio = gpio + 7;
+	gpio_request(devkit8000_dvi_device.reset_gpio, "DVI PowerDown");
+	/* Disable until needed */
+	gpio_direction_output(devkit8000_dvi_device.reset_gpio, 0);
+
 	return 0;
 }
 
-- 
1.7.1
