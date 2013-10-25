From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 29/43] ARM: dts: DRA7: link in clock DT data
Date: Fri, 25 Oct 2013 18:57:23 +0300
Message-ID: <1382716658-6964-30-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41025 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab3JYQAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 12:00:10 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Clock tree DT data is now included from base dra7.dtsi file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d0df4c4..bf7797e 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -104,6 +104,8 @@
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
+		/include/ "dra7xx-clocks.dtsi"
+
 		counter32k: counter@4ae04000 {
 			compatible = "ti,omap-counter32k";
 			reg = <0x4ae04000 0x40>;
-- 
1.7.9.5

