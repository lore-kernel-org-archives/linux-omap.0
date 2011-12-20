From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 1/5] arm/dts: OMAP4: Update DTS file with new GIC bindings
Date: Tue, 20 Dec 2011 14:39:54 +0100
Message-ID: <1324388398-2683-2-git-send-email-b-cousson@ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36265 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab1LTNkb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 08:40:31 -0500
In-Reply-To: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

The GIC binding was updated in 3.2 and expect 3 interrupt-cells.
- Update the #interrupt-cells
- interrupt-parent seems to be needed as well for the top level GIC

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap4.dtsi |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4c61c82..bede009 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -95,7 +95,8 @@
 		gic: interrupt-controller@48241000 {
 			compatible = "arm,cortex-a9-gic";
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			interrupt-parent;
+			#interrupt-cells = <3>;
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
-- 
1.7.0.4

