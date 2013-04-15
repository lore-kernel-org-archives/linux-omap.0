From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
Date: Mon, 15 Apr 2013 14:20:08 +0300
Message-ID: <1366024808-4691-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Beagle xM Rev. Ax/Bx, the USB power enable GPIO logic is
reversed when compared to other revisions i.e. it is
active high instead of active low.

Use the beagle_config.usb_pwr_level flag correctly so that
the power regulator can be configured at runtime.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 5382215..21136b2 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -112,13 +112,13 @@ static u8 omap3_beagle_version;
  */
 static struct {
 	int mmc1_gpio_wp;
-	int usb_pwr_level;
+	bool usb_pwr_level;	/* 0 - Active Low, 1 - Active High */
 	int dvi_pd_gpio;
 	int usr_button_gpio;
 	int mmc_caps;
 } beagle_config = {
 	.mmc1_gpio_wp = -EINVAL,
-	.usb_pwr_level = GPIOF_OUT_INIT_LOW,
+	.usb_pwr_level = 0,
 	.dvi_pd_gpio = -EINVAL,
 	.usr_button_gpio = 4,
 	.mmc_caps = MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
@@ -178,7 +178,7 @@ static void __init omap3_beagle_init_rev(void)
 	case 0:
 		printk(KERN_INFO "OMAP3 Beagle Rev: xM Ax/Bx\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
-		beagle_config.usb_pwr_level = GPIOF_OUT_INIT_HIGH;
+		beagle_config.usb_pwr_level = 1;
 		beagle_config.mmc_caps &= ~MMC_CAP_8_BIT_DATA;
 		break;
 	case 2:
-- 
1.7.4.1
