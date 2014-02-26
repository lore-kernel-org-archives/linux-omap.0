From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v3 2/2] ARM: DTS: OMAP4/5: Use l3_ick for the gpmc node
Date: Wed, 26 Feb 2014 11:38:09 +0100
Message-ID: <1393411089-9550-3-git-send-email-florian.vaussard@epfl.ch>
References: <1393411089-9550-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:57671 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbaBZKiZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 05:38:25 -0500
In-Reply-To: <1393411089-9550-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

The GPMC clock is derived from l3_ick. The simplest solution is
to reference directly l3_ick to provide the GPMC fck in order to
get correct timings. The real management of the clock is left to
hwmod.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap4.dtsi | 2 ++
 arch/arm/boot/dts/omap5.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 756cd34..381c0cc 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -275,6 +275,8 @@
 			gpmc,num-waitpins = <4>;
 			ti,hwmods = "gpmc";
 			ti,no-idle-on-init;
+			clocks = <&l3_div_ck>;
+			clock-names = "fck";
 		};
 
 		uart1: serial@4806a000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a72813a..7a16647 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -302,6 +302,8 @@
 			gpmc,num-cs = <8>;
 			gpmc,num-waitpins = <4>;
 			ti,hwmods = "gpmc";
+			clocks = <&l3_iclk_div>;
+			clock-names = "fck";
 		};
 
 		i2c1: i2c@48070000 {
-- 
1.8.1.2

