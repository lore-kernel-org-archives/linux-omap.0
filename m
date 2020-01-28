From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH] arm: dts: dra76x: Fix mmc3 max-frequency
Date: Tue, 28 Jan 2020 19:17:59 +0530
Message-ID: <20200128134759.21134-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44534 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgA1Nq2 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jan 2020 08:46:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: vigneshr@ti.com, j-keerthy@ti.com, lokeshvutla@ti.com, mark.rutland@arm.com, robh+dt@kernel.org, tony@atomide.com, bcousson@baylibre.com

dra76x is not affected by i887 which requires mmc3 node to be limited to
a max frequency of 64 MHz. Fix this by overwriting the correct value in
the the dra76 specific dtsi.

Fixes: 895bd4b3e5ec ("ARM: dts: Add support for dra76-evm")
Cc: stable@vger.kernel.org
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index cdcba3f561c4..9f6fbe4c1fee 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -86,3 +86,8 @@
 &usb4_tm {
 	status = "disabled";
 };
+
+&mmc3 {
+	/* dra76x is not affected by i887 */
+	max-frequency = <96000000>;
+};
-- 
2.19.2
