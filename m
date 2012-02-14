From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 1/4] arm/dts: OMAP4: Update DTS file with new GIC bindings
Date: Tue, 14 Feb 2012 18:56:09 +0100
Message-ID: <1329242172-4214-2-git-send-email-b-cousson@ti.com>
References: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53472 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab2BNR4q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 12:56:46 -0500
In-Reply-To: <1329242172-4214-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, rob.herring@calxeda.com
Cc: grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

The GIC binding was updated in 3.2 and expects 3 interrupt-cells.
- Update the #interrupt-cells

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap4.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index e8fe75f..70a44f6 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -99,7 +99,7 @@
 		gic: interrupt-controller@48241000 {
 			compatible = "arm,cortex-a9-gic";
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <3>;
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
-- 
1.7.0.4

