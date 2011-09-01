From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 08/13] arm/dts: omap4-panda: Set clock freq for i2c controllers
Date: Thu, 1 Sep 2011 19:21:24 +0200
Message-ID: <1314897689-17791-9-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40245 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755285Ab1IARWm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 13:22:42 -0400
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

From: G, Manjunath Kondaiah <manjugk@ti.com>

Update pandaboard dts file with required clock frequencies
for the i2c client devices existing on pandaboard.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
[b-cousson@ti.com: Fix the wrong use of reference and
wrong clock value]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index c702657..63ecf34 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -27,3 +27,19 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 };
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
+	clock-frequency = <100000>;
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+};
-- 
1.7.0.4

