From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [RFC PATCH v2 02/11] ARM: OMAP: expose control.h to mach area
Date: Mon, 18 Jun 2012 15:32:16 +0400
Message-ID: <4FDF11C0.4090908@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48597 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750828Ab2FRLcS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 07:32:18 -0400
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

This patch exposes the definitions under control.h to
drivers outside the machine code.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/mach-omap2/am35xx-emac.c                |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c              |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c              |    2 +-
 arch/arm/mach-omap2/board-am3517crane.c          |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c            |    2 +-
 arch/arm/mach-omap2/board-apollon.c              |    2 +-
 arch/arm/mach-omap2/board-cm-t3517.c             |    2 +-
 arch/arm/mach-omap2/board-h4.c                   |    2 +-
 arch/arm/mach-omap2/board-igep0020.c             |    2 +-
 arch/arm/mach-omap2/board-ldp.c                  |    2 +-
 arch/arm/mach-omap2/board-omap3logic.c           |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c           |    2 +-
 arch/arm/mach-omap2/board-omap4pcm049.c          |    2 +-
 arch/arm/mach-omap2/clock2420_data.c             |    2 +-
 arch/arm/mach-omap2/clock2430_data.c             |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c             |    2 +-
 arch/arm/mach-omap2/clock44xx_data.c             |    2 +-
 arch/arm/mach-omap2/common.c                     |    2 +-
 arch/arm/mach-omap2/control.c                    |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c                |    2 +-
 arch/arm/mach-omap2/devices.c                    |    2 +-
 arch/arm/mach-omap2/display.c                    |    2 +-
 arch/arm/mach-omap2/hsmmc.c                      |    2 +-
 arch/arm/mach-omap2/id.c                         |    2 +-
 arch/arm/mach-omap2/{ => include/mach}/control.h |    2 +-
 arch/arm/mach-omap2/mcbsp.c                      |    2 +-
 arch/arm/mach-omap2/mux.c                        |    2 +-
 arch/arm/mach-omap2/omap_phy_internal.c          |    2 +-
 arch/arm/mach-omap2/opp3xxx_data.c               |    2 +-
 arch/arm/mach-omap2/opp4xxx_data.c               |    2 +-
 arch/arm/mach-omap2/pm24xx.c                     |    2 +-
 arch/arm/mach-omap2/pm34xx.c                     |    2 +-
 arch/arm/mach-omap2/prcm.c                       |    2 +-
 arch/arm/mach-omap2/serial.c                     |    2 +-
 arch/arm/mach-omap2/sleep34xx.S                  |    2 +-
 arch/arm/mach-omap2/sr_device.c                  |    2 +-
 arch/arm/mach-omap2/usb-fs.c                     |    2 +-
 arch/arm/mach-omap2/voltage.c                    |    2 +-
 38 files changed, 38 insertions(+), 38 deletions(-)
 rename arch/arm/mach-omap2/{ => include/mach}/control.h (99%)

diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index 447682c..c3da28a 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -21,7 +21,7 @@
 #include <plat/irqs.h>
 #include <mach/am35xx.h>
 
-#include "control.h"
+#include <mach/control.h>
 
 static struct mdio_platform_data am35xx_emac_mdio_pdata;
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 37abb0d..ad1132b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -46,7 +46,7 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
 #include "pm.h"
-#include "control.h"
+#include <mach/control.h>
 #include "common-board-devices.h"
 
 #define CONFIG_DISABLE_HFCLK 1
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 94af6cd..8f7f76b 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -47,7 +47,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
-#include "control.h"
+#include <mach/control.h>
 #include "common-board-devices.h"
 
 #define ETH_KS8851_IRQ			34
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 3b8a53c..2ad514d 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -32,7 +32,7 @@
 
 #include "am35xx-emac.h"
 #include "mux.h"
-#include "control.h"
+#include <mach/control.h>
 
 #define GPIO_USB_POWER		35
 #define GPIO_USB_NRESET		38
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 99790eb..bef6586 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -41,7 +41,7 @@
 
 #include "am35xx-emac.h"
 #include "mux.h"
-#include "control.h"
+#include <mach/control.h>
 #include "hsmmc.h"
 
 #define LCD_PANEL_PWR		176
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 768ece2..bd04fe2 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -44,7 +44,7 @@
 #include <video/omap-panel-generic-dpi.h>
 
 #include "mux.h"
-#include "control.h"
+#include <mach/control.h>
 
 /* LED & Switch macros */
 #define LED0_GPIO13		13
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 9e66e16..1d2b7a3 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -47,7 +47,7 @@
 #include <mach/am35xx.h>
 
 #include "mux.h"
-#include "control.h"
+#include <mach/control.h>
 #include "common-board-devices.h"
 #include "am35xx-emac.h"
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 0bbbabe..623a231 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -43,7 +43,7 @@
 #include <video/omap-panel-generic-dpi.h>
 
 #include "mux.h"
-#include "control.h"
+#include <mach/control.h>
 
 #define H4_FLASH_CS	0
 #define H4_SMC91X_CS	1
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 7a27409..ebef044 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -42,7 +42,7 @@
 #include "sdram-numonyx-m65kxxxxam.h"
 #include "common-board-devices.h"
 #include "board-flash.h"
-#include "control.h"
+#include <mach/control.h>
 
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 1b60495..6383a76 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -50,7 +50,7 @@
 #include "board-flash.h"
 #include "mux.h"
 #include "hsmmc.h"
-#include "control.h"
+#include <mach/control.h>
 #include "common-board-devices.h"
 
 #define LDP_SMSC911X_CS		1
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index c008bf8..ca3e075 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -37,7 +37,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
-#include "control.h"
+#include <mach/control.h>
 #include "common-board-devices.h"
 
 #include <plat/mux.h>
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 847a857..b1c8517 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -45,7 +45,7 @@
 #include <video/omap-panel-tfp410.h>
 
 #include "hsmmc.h"
-#include "control.h"
+#include <mach/control.h>
 #include "mux.h"
 #include "common-board-devices.h"
 
diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
index a95f426..101e984 100644
--- a/arch/arm/mach-omap2/board-omap4pcm049.c
+++ b/arch/arm/mach-omap2/board-omap4pcm049.c
@@ -48,7 +48,7 @@
 
 #include "common.h"
 #include "hsmmc.h"
-#include "control.h"
+#include <mach/control.h>
 #include "mux.h"
 #include "common-board-devices.h"
 
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index bace930..f350e96 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -30,7 +30,7 @@
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
-#include "control.h"
+#include <mach/control.h>
 
 #define OMAP_CM_REGADDR                 OMAP2420_CM_REGADDR
 
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 3b4d09a..dd08bcb 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -29,7 +29,7 @@
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
-#include "control.h"
+#include <mach/control.h>
 
 #define OMAP_CM_REGADDR			OMAP2430_CM_REGADDR
 
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 4e1a3b0..694625f 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -34,7 +34,7 @@
 #include "cm-regbits-34xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
-#include "control.h"
+#include <mach/control.h>
 
 /*
  * clocks
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2172f66..ce11ee4 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -39,7 +39,7 @@
 #include "cm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
-#include "control.h"
+#include <mach/control.h>
 #include "scrm44xx.h"
 
 /* OMAP4 modulemode control */
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 8a6953a..3dc94d0 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -25,7 +25,7 @@
 #include "iomap.h"
 #include "common.h"
 #include "sdrc.h"
-#include "control.h"
+#include <mach/control.h>
 
 /* Global address base setup code */
 
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 08e674b..92e35bf 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -26,7 +26,7 @@
 #include "cm2xxx_3xxx.h"
 #include "sdrc.h"
 #include "pm.h"
-#include "control.h"
+#include <mach/control.h>
 
 /* Used by omap3_ctrl_save_padconf() */
 #define START_PADCONF_SAVE		0x2
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 207bc1c..7d82c6bb 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -33,7 +33,7 @@
 #include "clockdomain.h"
 
 #include "pm.h"
-#include "control.h"
+#include <mach/control.h>
 #include "common.h"
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7b4b932..152c266 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -34,7 +34,7 @@
 #include <plat/omap4-keypad.h>
 
 #include "mux.h"
-#include "control.h"
+#include <mach/control.h>
 #include "devices.h"
 
 #define L3_MODULES_MAX_LEN 12
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index db5a88a..0681407 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -32,7 +32,7 @@
 
 #include "iomap.h"
 #include "mux.h"
-#include "control.h"
+#include <mach/control.h>
 #include "display.h"
 
 #define DISPC_CONTROL		0x0040
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index be697d4..33b3d62 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -22,7 +22,7 @@
 
 #include "mux.h"
 #include "hsmmc.h"
-#include "control.h"
+#include <mach/control.h>
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 0389b32..5bb9746 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -26,7 +26,7 @@
 
 #include <mach/id.h>
 
-#include "control.h"
+#include <mach/control.h>
 
 static unsigned int omap_revision;
 static const char *cpu_rev;
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/include/mach/control.h
similarity index 99%
rename from arch/arm/mach-omap2/control.h
rename to arch/arm/mach-omap2/include/mach/control.h
index dad2903..cf42764 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/include/mach/control.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-omap2/control.h
+ * arch/arm/mach-omap2/include/mach/control.h
  *
  * OMAP2/3/4 System Control Module definitions
  *
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 577cb77..0367035 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -25,7 +25,7 @@
 #include <plat/omap_device.h>
 #include <linux/pm_runtime.h>
 
-#include "control.h"
+#include <mach/control.h>
 
 /*
  * FIXME: Find a mechanism to enable/disable runtime the McBSP ICLK autoidle.
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 3268ee2..f23e6618 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -38,7 +38,7 @@
 
 #include <plat/omap_hwmod.h>
 
-#include "control.h"
+#include <mach/control.h>
 #include "mux.h"
 #include "prm.h"
 
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 4c90477..b2c9253 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -29,7 +29,7 @@
 #include <linux/usb.h>
 
 #include <plat/usb.h>
-#include "control.h"
+#include <mach/control.h>
 
 /* OMAP control module register for UTMI PHY */
 #define CONTROL_DEV_CONF		0x300
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index d95f3f9..6dafdbb 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -21,7 +21,7 @@
 
 #include <plat/cpu.h>
 
-#include "control.h"
+#include <mach/control.h>
 #include "omap_opp_data.h"
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 2293ba2..27f823c 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -22,7 +22,7 @@
 
 #include <plat/cpu.h>
 
-#include "control.h"
+#include <mach/control.h>
 #include "omap_opp_data.h"
 #include "pm.h"
 
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index facfffc..7ebca30 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -49,7 +49,7 @@
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
 #include "pm.h"
-#include "control.h"
+#include <mach/control.h>
 #include "powerdomain.h"
 #include "clockdomain.h"
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8b43aef..1d2a51c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -49,7 +49,7 @@
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
 #include "sdrc.h"
-#include "control.h"
+#include <mach/control.h>
 
 /* pm34xx errata defined in pm.h */
 u16 pm34xx_errata;
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 480f40a..fff0b09 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -37,7 +37,7 @@
 #include "prminst44xx.h"
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-44xx.h"
-#include "control.h"
+#include <mach/control.h>
 
 void __iomem *prm_base;
 void __iomem *cm_base;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 678dd1d..97b09da5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -39,7 +39,7 @@
 #include "pm.h"
 #include "cm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
-#include "control.h"
+#include <mach/control.h>
 #include "mux.h"
 
 /*
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 1f62f23..b3f6bfc 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -33,7 +33,7 @@
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
 #include "sdrc.h"
-#include "control.h"
+#include <mach/control.h>
 
 /*
  * Registers access definitions
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index a503e1e..48a01f6 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -26,7 +26,7 @@
 
 #include "smartreflex.h"
 #include "voltage.h"
-#include "control.h"
+#include <mach/control.h>
 #include "pm.h"
 
 static bool sr_enable_on_init;
diff --git a/arch/arm/mach-omap2/usb-fs.c b/arch/arm/mach-omap2/usb-fs.c
index 1481078..94d471c 100644
--- a/arch/arm/mach-omap2/usb-fs.c
+++ b/arch/arm/mach-omap2/usb-fs.c
@@ -32,7 +32,7 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 
-#include "control.h"
+#include <mach/control.h>
 #include "mux.h"
 
 #define INT_USB_IRQ_GEN		INT_24XX_USB_IRQ_GEN
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 4dc60e8..d2f0644 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -34,7 +34,7 @@
 #include "prm44xx.h"
 #include "prcm44xx.h"
 #include "prminst44xx.h"
-#include "control.h"
+#include <mach/control.h>
 
 #include "voltage.h"
 #include "powerdomain.h"
-- 1.7.7.1.488.ge8e1c


