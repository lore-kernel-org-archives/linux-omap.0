From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] ARM: dts: dra7x-evm: Don't use dcan1_rx.gpio1_15 in DCAN pinctrl
Date: Thu, 5 Mar 2015 15:32:42 +0200
Message-ID: <1425562363-19338-2-git-send-email-rogerq@ti.com>
References: <1425562363-19338-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36634 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324AbbCENcu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Mar 2015 08:32:50 -0500
In-Reply-To: <1425562363-19338-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Rev.F onwards ball G19 (dcan1_rx) is used as a GPIO for some other
function so don't include it in DCAN pinctrl node.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts  | 2 --
 arch/arm/boot/dts/dra72-evm.dts | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 3290a96..ddef593 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -264,7 +264,6 @@
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
 			0x3d0   (PIN_OUTPUT | MUX_MODE0) /* dcan1_tx */
-			0x3d4   (MUX_MODE15)		/* dcan1_rx.off */
 			0x418   (PULL_DIS | MUX_MODE1) /* wakeup0.dcan1_rx */
 		>;
 	};
@@ -272,7 +271,6 @@
 	dcan1_pins_sleep: dcan1_pins_sleep {
 		pinctrl-single,pins = <
 			0x3d0   (MUX_MODE15)	/* dcan1_tx.off */
-			0x3d4   (MUX_MODE15)	/* dcan1_rx.off */
 			0x418   (MUX_MODE15)	/* wakeup0.off */
 		>;
 	};
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index e0264d0..42ee09a 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -120,7 +120,6 @@
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
 			0x3d0   (PIN_OUTPUT | MUX_MODE0) /* dcan1_tx */
-			0x3d4   (MUX_MODE15)		/* dcan1_rx.off */
 			0x418   (PULL_DIS | MUX_MODE1) /* wakeup0.dcan1_rx */
 		>;
 	};
@@ -128,7 +127,6 @@
 	dcan1_pins_sleep: dcan1_pins_sleep {
 		pinctrl-single,pins = <
 			0x3d0   (MUX_MODE15)	/* dcan1_tx.off */
-			0x3d4   (MUX_MODE15)	/* dcan1_rx.off */
 			0x418   (MUX_MODE15)	/* wakeup0.off */
 		>;
 	};
-- 
2.1.0

