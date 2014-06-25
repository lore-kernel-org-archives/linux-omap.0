From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/9] ARM: dts: OMAP4: Add mailbox node
Date: Tue, 24 Jun 2014 20:04:47 -0500
Message-ID: <1403658295-54766-2-git-send-email-s-anna@ti.com>
References: <1403658295-54766-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34764 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbaFYBFo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 21:05:44 -0400
In-Reply-To: <1403658295-54766-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

The mailbox DT node data has been added for OMAP44xx
devices.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 7e26d22..55bec30 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -649,6 +649,13 @@
 			};
 		};
 
+		mailbox: mailbox@4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4a0f4000 0x200>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mailbox";
+		};
+
 		timer1: timer@4a318000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x4a318000 0x80>;
-- 
2.0.0

