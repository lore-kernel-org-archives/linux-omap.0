From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 4/4] ARM: dts: cm-t54: setup omap_dwc3
Date: Tue, 16 Sep 2014 19:35:22 +0300
Message-ID: <1410885322-5928-5-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:55106 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754712AbaIPQfg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Sep 2014 12:35:36 -0400
In-Reply-To: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add "extcon" and "vbus-supply" properties of DWC3 node.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap5-cm-t54.dts |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 9cfcad5..855cb88a 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -631,6 +631,11 @@
 	phys = <0 &hsusb2_phy &hsusb3_phy>;
 };
 
+&usb3 {
+       extcon = <&extcon_usb3>;
+       vbus-supply = <&smps10_out1_reg>;
+};
+
 &cpu0 {
 	cpu0-supply = <&smps123_reg>;
 };
-- 
1.7.5.4

