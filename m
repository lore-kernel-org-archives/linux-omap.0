From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH v5, 1/3] ARM: dts: AM33XX: Add ELM node
Date: Fri, 31 May 2013 13:19:03 +0530
Message-ID: <1369986545-29204-2-git-send-email-pekon@ti.com>
References: <1369986545-29204-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49978 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab3EaHtY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 03:49:24 -0400
In-Reply-To: <1369986545-29204-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: "Philip, Avinash" <avinashphilip@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, jacmet@sunsite.dk, zonque@gmail.com, Jon Hunter <jgchunter@gmail.com>, Pekon Gupta <pekon@ti.com>

From: "Philip, Avinash" <avinashphilip@ti.com>

ELM hardware engine is used for locating bit-flips in NAND data
This patch is required for working of hardware based NAND ECC schemes
with DT support.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 1460d9b..0425af8 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -404,6 +404,14 @@
 			ti,hwmods = "wkup_m3";
 		};
 
+		elm: elm@48080000 {
+			compatible = "ti,am3352-elm";
+			reg = <0x48080000 0x2000>;
+			interrupts = <4>;
+			ti,hwmods = "elm";
+			status = "disabled";
+		};
+
 		gpmc: gpmc@50000000 {
 			compatible = "ti,am3352-gpmc";
 			ti,hwmods = "gpmc";
-- 
1.8.1

