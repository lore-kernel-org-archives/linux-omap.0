From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/12] omap3evm: ehci: Update EHCI support on OMAP3EVM (Rev >=
	E)
Date: Mon, 16 Nov 2009 15:27:46 -0800
Message-ID: <20091116232746.24892.79074.stgit@localhost>
References: <20091116232435.24892.81547.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55823 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbZKPX1l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 18:27:41 -0500
In-Reply-To: <20091116232435.24892.81547.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Added runtime programming for the differences in EHCI interface between
OMAP3EVM revisions (Rev >= E) and (Rev < E).

Changes:
	- EHCI PHY reset GPIO pin is 21 on Rev >= E while Rev < E
	  uses GPIO pin 135.
	- Rev >= E uses EHCI Vbus enable GPIO22 line.
	- Rev >= E uses GPIO61 to select EHCI port either on main board or
	  on Mistral Daughter Card (MDC). OMAP3EVM Rev < E doesn't have
	  EHCI port on main board.
	- Currently GPIO61 it programmed to enable EHCI port on main
	  board only.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/configs/omap3_evm_defconfig  |   12 +++++++++---
 arch/arm/mach-omap2/board-omap3evm.c  |   29 ++++++++++++++++++++++++++---
 arch/arm/mach-omap2/mux.c             |    7 +++++++
 arch/arm/plat-omap/include/plat/mux.h |    5 +++++
 4 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index 180bf9f..da69732 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -676,13 +676,19 @@ CONFIG_INPUT_EVDEV=y
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
-# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
-# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_GPIO is not set
+# CONFIG_KEYBOARD_MATRIX is not set
+# CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
-# CONFIG_KEYBOARD_GPIO is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+CONFIG_KEYBOARD_TWL4030=y
+# CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 6bb9a37..64c1ae0 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -43,6 +43,8 @@
 #include "mmc-twl4030.h"
 
 #define OMAP3_EVM_TS_GPIO	175
+#define OMAP3_EVM_EHCI_VBUS	22
+#define OMAP3_EVM_EHCI_SELECT	61
 
 #define OMAP3EVM_ETHR_START	0x2c000000
 #define OMAP3EVM_ETHR_SIZE	1024
@@ -345,8 +347,9 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
 	.phy_reset  = true,
+	/* PHY reset GPIO will be runtime programmed based on EVM version */
 	.reset_gpio_port[0]  = -EINVAL,
-	.reset_gpio_port[1]  = 135,
+	.reset_gpio_port[1]  = -EINVAL,
 	.reset_gpio_port[2]  = -EINVAL
 };
 
@@ -366,9 +369,29 @@ static void __init omap3_evm_init(void)
 	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
 	usb_nop_xceiv_register();
 #endif
+	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
+		/* enable EHCI VBUS using GPIO22 */
+		omap_cfg_reg(AF9_34XX_GPIO22);
+		gpio_request(OMAP3_EVM_EHCI_VBUS, "enable EHCI VBUS");
+		gpio_direction_output(OMAP3_EVM_EHCI_VBUS, 0);
+		gpio_set_value(OMAP3_EVM_EHCI_VBUS, 1);
+
+		/* Select EHCI port on main board */
+		omap_cfg_reg(U3_34XX_GPIO61);
+		gpio_request(OMAP3_EVM_EHCI_SELECT, "select EHCI port");
+		gpio_direction_output(OMAP3_EVM_EHCI_SELECT, 0);
+		gpio_set_value(OMAP3_EVM_EHCI_SELECT, 0);
+
+		/* setup EHCI phy reset config */
+		omap_cfg_reg(AH14_34XX_GPIO21);
+		ehci_pdata.reset_gpio_port[1] = 21;
+
+	} else {
+		/* setup EHCI phy reset on MDC */
+		omap_cfg_reg(AF4_34XX_GPIO135_OUT);
+		ehci_pdata.reset_gpio_port[1] = 135;
+	}
 	usb_musb_init();
-	/* Setup EHCI phy reset padconfig */
-	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
 	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
 }
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 83256d3..c18a94e 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -559,6 +559,13 @@ MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2,
 MUX_CFG_34XX("AF26_34XX_SYS_NIRQ", 0x1E0,
 		OMAP3_WAKEUP_EN | OMAP34XX_PIN_INPUT_PULLUP |
 		OMAP34XX_MUX_MODE0)
+/* EHCI GPIO's on OMAP3EVM (Rev >= E) */
+MUX_CFG_34XX("AH14_34XX_GPIO21", 0x5ea,
+	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AF9_34XX_GPIO22", 0x5ec,
+	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("U3_34XX_GPIO61", 0x0c8,
+	OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index f74331d..ba77de6 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -849,6 +849,11 @@ enum omap34xx_index {
 
 	/* SYS_NIRQ T2 INT1 */
 	AF26_34XX_SYS_NIRQ,
+
+	/* EHCI GPIO's for OMAP3EVM (Rev >= E) */
+	AH14_34XX_GPIO21,
+	AF9_34XX_GPIO22,
+	U3_34XX_GPIO61,
 };
 
 struct omap_mux_cfg {

