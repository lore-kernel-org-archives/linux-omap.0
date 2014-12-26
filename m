From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/5] arm: boot: dts: am437x-sk: add power button binding
Date: Fri, 26 Dec 2014 13:28:23 -0600
Message-ID: <1419622104-25812-5-git-send-email-balbi@ti.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44590 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbaLZT3S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Dec 2014 14:29:18 -0500
In-Reply-To: <1419622104-25812-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Let this board report KEY_POWER so upper layers
can decide what to do when power button is pressed.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 53bbfc9..c53840c 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -386,6 +386,11 @@
 			regulator-always-on;
 		};
 
+		power-button {
+			compatible = "ti,tps65218-pwrbutton";
+			status = "okay";
+			interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+		};
 	};
 
 	at24@50 {
-- 
2.2.0

