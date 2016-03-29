From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 5/5] ARM: dts: omap4-kc1: Power off support
Date: Tue, 29 Mar 2016 21:28:27 +0200
Message-ID: <1459279707-17611-7-git-send-email-contact@paulk.fr>
References: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459279707-17611-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-omap@vger.kernel.org

This adds support for turning off the main power supply via the TWL6030 on the
Kindle Fire (first generation).

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/omap4-kc1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-kc1.dts b/arch/arm/boot/dts/omap4-kc1.dts
index 3681414..2251bd5 100644
--- a/arch/arm/boot/dts/omap4-kc1.dts
+++ b/arch/arm/boot/dts/omap4-kc1.dts
@@ -115,6 +115,11 @@
 		reg = <0x48>;
 		/* IRQ# = 7 */
 		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
+
+		twl_power: power {
+			compatible = "ti,twl6030-power";
+			ti,system-power-controller;
+		};
 	};
 };
 
-- 
2.7.4
