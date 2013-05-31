From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH v5, 2/3] dts: am33xx: Correct properties on gpmc node
Date: Fri, 31 May 2013 13:19:04 +0530
Message-ID: <1369986545-29204-3-git-send-email-pekon@ti.com>
References: <1369986545-29204-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49816 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab3EaHt2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 03:49:28 -0400
In-Reply-To: <1369986545-29204-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Lars Poeschel <poeschel@lemonage.de>, "Philip, Avinash" <avinashphilip@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, jacmet@sunsite.dk, zonque@gmail.com, Jon Hunter <jgchunter@gmail.com>

From: Lars Poeschel <poeschel@lemonage.de>

The gpmc driver is actually looking for "gpmc,num-cs" and
"gpmc,num-waitpins" properties in DT. The binding doc also states
this.
Correct the properties in the dts to provide the right values for the
gpmc driver.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
Acked-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0425af8..5f80f84 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -417,8 +417,8 @@
 			ti,hwmods = "gpmc";
 			reg = <0x50000000 0x2000>;
 			interrupts = <100>;
-			num-cs = <7>;
-			num-waitpins = <2>;
+			gpmc,num-cs = <7>;
+			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
 			status = "disabled";
-- 
1.8.1

