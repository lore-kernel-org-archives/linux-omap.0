From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/2] ARM: dts: OMAP3: Add GPMC controller
Date: Mon, 28 Jan 2013 18:54:07 +0100
Message-ID: <1359395648-2137-2-git-send-email-florian.vaussard@epfl.ch>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:40358 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757339Ab3A1RyP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Jan 2013 12:54:15 -0500
In-Reply-To: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Add device-tree support for the GPMC controller on the OMAP3.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 6c63118..2ddae38 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -403,5 +403,16 @@
 			ti,timer-alwon;
 			ti,timer-secure;
 		};
+
+		gpmc: gpmc@6e000000 {
+			compatible = "ti,omap3430-gpmc";
+			ti,hwmods = "gpmc";
+			reg = <0x6e000000 0x1000000>;
+			interrupts = <20>;
+			gpmc,num-cs = <8>;
+			gpmc,num-waitpins = <4>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
 	};
 };
-- 
1.7.5.4

