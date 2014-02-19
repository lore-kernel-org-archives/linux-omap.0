From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 2/2] ARM: DTS: OMAP4: Use l3_ick for the gpmc node
Date: Wed, 19 Feb 2014 10:15:05 +0100
Message-ID: <1392801305-1698-3-git-send-email-florian.vaussard@epfl.ch>
References: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:47887 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbaBSJPa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Feb 2014 04:15:30 -0500
In-Reply-To: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

The GPMC clock is derived from l3_ick. The simplest solution is
to reference directly l3_ick to provide the GPMC fck in order to
get correct timings. The real management of the clock is left to
hwmod.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..69409f7 100644
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
-- 
1.8.1.2

