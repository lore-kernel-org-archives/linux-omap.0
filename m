From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/2] arm/dts: Mark vcxio, v2v1 and v1v8 regulators as always on
Date: Mon, 30 Jul 2012 18:42:19 +0530
Message-ID: <1343653940-16614-2-git-send-email-rnayak@ti.com>
References: <1343653940-16614-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56725 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984Ab2G3NMs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 09:12:48 -0400
In-Reply-To: <1343653940-16614-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

vcxio, v2v1 and v1v8 are expected to be always on, update the dtsi
for twl6030 to reflect this.

commit '86f5fc' regulator: core: Mark all DT based boards as having
full constraints) caused these to be disabled at late boot causing
OMAP4 boards (using twl6030) to lockup.

Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
Reported-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Rajendra nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/twl6030.dtsi |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 3b2f351..d351b27 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -66,6 +66,7 @@
 
 	vcxio: regulator@8 {
 		compatible = "ti,twl6030-vcxio";
+		regulator-always-on;
 	};
 
 	vusb: regulator@9 {
@@ -74,10 +75,12 @@
 
 	v1v8: regulator@10 {
 		compatible = "ti,twl6030-v1v8";
+		regulator-always-on;
 	};
 
 	v2v1: regulator@11 {
 		compatible = "ti,twl6030-v2v1";
+		regulator-always-on;
 	};
 
 	clk32kg: regulator@12 {
-- 
1.7.1

