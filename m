From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/10] ARM: dts: Add smc91x GPMC configuration for 2430sdp
Date: Wed, 29 Oct 2014 17:29:01 -0700
Message-ID: <1414628948-30702-4-git-send-email-tony@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52205 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757285AbaJ3Aad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 20:30:33 -0400
In-Reply-To: <1414628948-30702-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>

Let's use the bootloader values except for the partially configured
wait-pin that does not seem to work.

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap2430-sdp.dts | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap2430-sdp.dts b/arch/arm/boot/dts/omap2430-sdp.dts
index 2c90d29..05eca2e 100644
--- a/arch/arm/boot/dts/omap2430-sdp.dts
+++ b/arch/arm/boot/dts/omap2430-sdp.dts
@@ -43,7 +43,31 @@
 		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;	/* gpio149 */
 		reg = <5 0x300 0xf>;
 		bank-width = <2>;
-		gpmc,mux-add-data;
-        };
+		gpmc,sync-clk-ps = <0>;
+		gpmc,mux-add-data = <2>;
+		gpmc,device-width = <1>;
+		gpmc,cycle2cycle-samecsen = <1>;
+		gpmc,cycle2cycle-diffcsen = <1>;
+		gpmc,cs-on-ns = <7>;
+		gpmc,cs-rd-off-ns = <233>;
+		gpmc,cs-wr-off-ns = <233>;
+		gpmc,adv-on-ns = <22>;
+		gpmc,adv-rd-off-ns = <60>;
+		gpmc,adv-wr-off-ns = <60>;
+		gpmc,oe-on-ns = <67>;
+		gpmc,oe-off-ns = <210>;
+		gpmc,we-on-ns = <67>;
+		gpmc,we-off-ns = <210>;
+		gpmc,rd-cycle-ns = <233>;
+		gpmc,wr-cycle-ns = <233>;
+		gpmc,access-ns = <233>;
+		gpmc,page-burst-access-ns = <30>;
+		gpmc,bus-turnaround-ns = <30>;
+		gpmc,cycle2cycle-delay-ns = <30>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		gpmc,wr-access-ns = <0>;
+	};
 };
 
-- 
2.1.1

