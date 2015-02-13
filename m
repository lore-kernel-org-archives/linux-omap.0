From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 27/33] ARM: dts: omap24xx: add syscon support to scrm node
Date: Fri, 13 Feb 2015 18:12:46 +0200
Message-ID: <1423843973-6050-25-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44920 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778AbbBMQOa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:30 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Control module will be converted to use syscon, thus add compatible
string for this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi |    2 +-
 arch/arm/boot/dts/omap2430.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index e2b2e93..f6aa8cf 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -28,7 +28,7 @@
 		};
 
 		scrm: scrm@48000000 {
-			compatible = "ti,omap2-scrm";
+			compatible = "ti,omap2-scrm", "syscon";
 			reg = <0x48000000 0x1000>;
 
 			scrm_clocks: clocks {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 0dc8de2..77a7956 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -28,7 +28,7 @@
 		};
 
 		scrm: scrm@49002000 {
-			compatible = "ti,omap2-scrm";
+			compatible = "ti,omap2-scrm", "syscon";
 			reg = <0x49002000 0x1000>;
 
 			scrm_clocks: clocks {
-- 
1.7.9.5

