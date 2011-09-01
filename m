From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 07/13] arm/dts: omap4-sdp: Set clock freq for i2c controllers
Date: Thu, 1 Sep 2011 19:21:23 +0200
Message-ID: <1314897689-17791-8-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35318 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285Ab1IARWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 13:22:39 -0400
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

Update DTS file with required clock frequencies
for the i2c client devices existing on sdp4430.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 066e28c..ed85b35 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -26,4 +26,22 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+
+
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
 };
-- 
1.7.0.4

