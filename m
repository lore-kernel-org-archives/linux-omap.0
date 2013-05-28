From: "Gupta, Pekon" <pekon@ti.com>
Subject: [PATCH v4,2/3] ARM: dts: AM33XX: update GPMC node
Date: Tue, 28 May 2013 17:11:24 +0530
Message-ID: <1369741285-1967-3-git-send-email-pekon@ti.com>
References: <1369741285-1967-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55872 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933051Ab3E1LmA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 May 2013 07:42:00 -0400
In-Reply-To: <1369741285-1967-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, "Gupta, Pekon" <pekon@ti.com>, "Philip, Avinash" <avinashphilip@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, hvaibhav@ti.com

From: "Gupta, Pekon" <pekon@ti.com>

add prefix to 'gpmc' specific properties

Signed-off-by: Gupta, Pekon <pekon@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0425af8..095f696 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -418,7 +418,7 @@
 			reg = <0x50000000 0x2000>;
 			interrupts = <100>;
 			num-cs = <7>;
-			num-waitpins = <2>;
+			gpmc,num-waitpins = <2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
 			status = "disabled";
-- 
1.8.1

