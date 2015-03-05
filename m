From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] ARM: dts: dra7x-evm: avoid possible contention while muxing on CAN lines
Date: Thu, 5 Mar 2015 15:32:43 +0200
Message-ID: <1425562363-19338-3-git-send-email-rogerq@ti.com>
References: <1425562363-19338-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42256 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324AbbCENcw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 08:32:52 -0500
In-Reply-To: <1425562363-19338-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

DCAN1 RX and TX lines are internally pulled high according to [1].
While muxing between DCAN mode and SAFE mode we make sure
that the same pull direction is set to minimize opposite
pull contention during the switching window.

[1] in DRA7 data manual, Ball characteristics table 4-2, DSIS colum shows
the state driven to the peripheral input while in the deselcted mode.
DSIS - De-Selected Input State.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts  | 8 ++++----
 arch/arm/boot/dts/dra72-evm.dts | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index ddef593..7563d7c 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -263,15 +263,15 @@
 
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
-			0x3d0   (PIN_OUTPUT | MUX_MODE0) /* dcan1_tx */
-			0x418   (PULL_DIS | MUX_MODE1) /* wakeup0.dcan1_rx */
+			0x3d0   (PIN_OUTPUT_PULLUP | MUX_MODE0) /* dcan1_tx */
+			0x418   (PULL_UP | MUX_MODE1) /* wakeup0.dcan1_rx */
 		>;
 	};
 
 	dcan1_pins_sleep: dcan1_pins_sleep {
 		pinctrl-single,pins = <
-			0x3d0   (MUX_MODE15)	/* dcan1_tx.off */
-			0x418   (MUX_MODE15)	/* wakeup0.off */
+			0x3d0   (MUX_MODE15 | PULL_UP)	/* dcan1_tx.off */
+			0x418   (MUX_MODE15 | PULL_UP)	/* wakeup0.off */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 42ee09a..40ed539 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -119,15 +119,15 @@
 
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
-			0x3d0   (PIN_OUTPUT | MUX_MODE0) /* dcan1_tx */
-			0x418   (PULL_DIS | MUX_MODE1) /* wakeup0.dcan1_rx */
+			0x3d0   (PIN_OUTPUT_PULLUP | MUX_MODE0) /* dcan1_tx */
+			0x418   (PULL_UP | MUX_MODE1)	/* wakeup0.dcan1_rx */
 		>;
 	};
 
 	dcan1_pins_sleep: dcan1_pins_sleep {
 		pinctrl-single,pins = <
-			0x3d0   (MUX_MODE15)	/* dcan1_tx.off */
-			0x418   (MUX_MODE15)	/* wakeup0.off */
+			0x3d0   (MUX_MODE15 | PULL_UP)	/* dcan1_tx.off */
+			0x418   (MUX_MODE15 | PULL_UP)	/* wakeup0.off */
 		>;
 	};
 
-- 
2.1.0

