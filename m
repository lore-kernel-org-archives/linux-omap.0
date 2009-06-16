From: Jean Pihet <jpihet@mvista.com>
Subject: [PATCH 2/2] OMAP3: Setup MUX settings for SDRC CKE signals
Date: Tue, 16 Jun 2009 10:16:08 +0200
Message-ID: <200906161016.08641.jpihet@mvista.com>
References: <200906161011.33725.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IT1NKWVD0SKmW3t"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:13515 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbZFPIQI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 04:16:08 -0400
In-Reply-To: <200906161011.33725.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

--Boundary-00=_IT1NKWVD0SKmW3t
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


This patches ensures the MUX settings are correct for the SDRC
CKE signals to SDRAM. This allows the self-refresh to work when
2 chip-selects are in use.

A warning is thrown away in case the initial muxing is incorrect,
in order to track faulty or old-dated bootloaders.
Note: The CONFIG_OMAP_MUX and CONFIG_OMAP_MUX_WARNINGS options
must be enabled for the mux code to have effect.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c  |    4 ++++
 arch/arm/mach-omap2/board-omap3pandora.c |    5 +++++
 arch/arm/mach-omap2/board-overo.c        |    5 +++++
 arch/arm/mach-omap2/board-rx51.c         |    4 ++++
 arch/arm/mach-omap2/mux.c                |    6 ++++++
 arch/arm/plat-omap/include/mach/mux.h    |    4 ++++
 6 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c 
b/arch/arm/mach-omap2/board-omap3beagle.c
index 37cd4b7..922e8ab 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -410,6 +410,10 @@ static void __init omap3_beagle_init(void)
 	usb_musb_init();
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 	omap3beagle_flash_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
 
 static void __init omap3_beagle_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c 
b/arch/arm/mach-omap2/board-omap3pandora.c
index b19cc7b..ef77c20 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -40,6 +40,7 @@
 #include <mach/mcspi.h>
 #include <mach/usb.h>
 #include <mach/keypad.h>
+#include <mach/mux.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
@@ -399,6 +400,10 @@ static void __init omap3pandora_init(void)
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, 16, -EINVAL);
 	pandora_keys_gpio_init();
 	usb_musb_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
 
 static void __init omap3pandora_map_io(void)
diff --git a/arch/arm/mach-omap2/board-overo.c 
b/arch/arm/mach-omap2/board-overo.c
index 5932ff1..a44771d 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -44,6 +44,7 @@
 #include <mach/gpmc.h>
 #include <mach/hardware.h>
 #include <mach/nand.h>
+#include <mach/mux.h>
 #include <mach/usb.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -397,6 +398,10 @@ static void __init overo_init(void)
 	overo_ads7846_init();
 	overo_init_smsc911x();
 
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&
 	    (gpio_direction_output(OVERO_GPIO_W2W_NRESET, 1) == 0)) {
diff --git a/arch/arm/mach-omap2/board-rx51.c 
b/arch/arm/mach-omap2/board-rx51.c
index 591ae8a..1c9e07f 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -75,6 +75,10 @@ static void __init rx51_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	rx51_peripherals_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
 
 static void __init rx51_map_io(void)
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 026c4fc..43d6b92 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -486,6 +486,12 @@ MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+
+/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
+MUX_CFG_34XX("H16_34XX_SDRC_CKE0", 0x262,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("H17_34XX_SDRC_CKE1", 0x264,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/mux.h 
b/arch/arm/plat-omap/include/mach/mux.h
index 85a6217..80281c4 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -853,6 +853,10 @@ enum omap34xx_index {
 	AE5_34XX_GPIO143,
 	H19_34XX_GPIO164_OUT,
 	J25_34XX_GPIO170,
+
+	/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
+	H16_34XX_SDRC_CKE0,
+	H17_34XX_SDRC_CKE1,
 };
 
 struct omap_mux_cfg {
-- 
1.6.2.5.168.g3823


--Boundary-00=_IT1NKWVD0SKmW3t
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0002-OMAP3-Setup-MUX-settings-for-SDRC-CKE-signals.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-OMAP3-Setup-MUX-settings-for-SDRC-CKE-signals.patch"

=46rom 4bdb5b858d1d441d0cbf0f82016aaa6d4fec0b39 Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Tue, 16 Jun 2009 09:58:58 +0200
Subject: [PATCH 2/2] OMAP3: Setup MUX settings for SDRC CKE signals

This patches ensures the MUX settings are correct for the SDRC
CKE signals to SDRAM. This allows the self-refresh to work when
2 chip-selects are in use.

A warning is thrown away in case the initial muxing is incorrect,
in order to track faulty or old-dated bootloaders.
Note: The CONFIG_OMAP_MUX and CONFIG_OMAP_MUX_WARNINGS options
must be enabled for the mux code to have effect.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 arch/arm/mach-omap2/board-omap3beagle.c  |    4 ++++
 arch/arm/mach-omap2/board-omap3pandora.c |    5 +++++
 arch/arm/mach-omap2/board-overo.c        |    5 +++++
 arch/arm/mach-omap2/board-rx51.c         |    4 ++++
 arch/arm/mach-omap2/mux.c                |    6 ++++++
 arch/arm/plat-omap/include/mach/mux.h    |    4 ++++
 6 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/=
board-omap3beagle.c
index 37cd4b7..922e8ab 100644
=2D-- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -410,6 +410,10 @@ static void __init omap3_beagle_init(void)
 	usb_musb_init();
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 	omap3beagle_flash_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
=20
 static void __init omap3_beagle_map_io(void)
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2=
/board-omap3pandora.c
index b19cc7b..ef77c20 100644
=2D-- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -40,6 +40,7 @@
 #include <mach/mcspi.h>
 #include <mach/usb.h>
 #include <mach/keypad.h>
+#include <mach/mux.h>
=20
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
@@ -399,6 +400,10 @@ static void __init omap3pandora_init(void)
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, 16, -EINVAL);
 	pandora_keys_gpio_init();
 	usb_musb_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
=20
 static void __init omap3pandora_map_io(void)
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-=
overo.c
index 5932ff1..a44771d 100644
=2D-- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -44,6 +44,7 @@
 #include <mach/gpmc.h>
 #include <mach/hardware.h>
 #include <mach/nand.h>
+#include <mach/mux.h>
 #include <mach/usb.h>
=20
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -397,6 +398,10 @@ static void __init overo_init(void)
 	overo_ads7846_init();
 	overo_init_smsc911x();
=20
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
+
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") =3D=3D 0) &&
 	    (gpio_direction_output(OVERO_GPIO_W2W_NRESET, 1) =3D=3D 0)) {
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-r=
x51.c
index 591ae8a..1c9e07f 100644
=2D-- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -75,6 +75,10 @@ static void __init rx51_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	rx51_peripherals_init();
+
+	/* Ensure SDRC pins are mux'd for self-refresh */
+	omap_cfg_reg(H16_34XX_SDRC_CKE0);
+	omap_cfg_reg(H17_34XX_SDRC_CKE1);
 }
=20
 static void __init rx51_map_io(void)
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 026c4fc..43d6b92 100644
=2D-- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -486,6 +486,12 @@ MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+
+/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
+MUX_CFG_34XX("H16_34XX_SDRC_CKE0", 0x262,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("H17_34XX_SDRC_CKE1", 0x264,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
 };
=20
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/inc=
lude/mach/mux.h
index 85a6217..80281c4 100644
=2D-- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -853,6 +853,10 @@ enum omap34xx_index {
 	AE5_34XX_GPIO143,
 	H19_34XX_GPIO164_OUT,
 	J25_34XX_GPIO170,
+
+	/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
+	H16_34XX_SDRC_CKE0,
+	H17_34XX_SDRC_CKE1,
 };
=20
 struct omap_mux_cfg {
=2D-=20
1.6.2.5.168.g3823


--Boundary-00=_IT1NKWVD0SKmW3t--
