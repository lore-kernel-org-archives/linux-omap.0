From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 08/11] omap4: panda: Pass fixed regulator data from DT
Date: Thu, 15 Sep 2011 16:52:04 +0530
Message-ID: <1316085727-15023-9-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <1316085727-15023-5-git-send-email-rnayak@ti.com>
 <1316085727-15023-6-git-send-email-rnayak@ti.com>
 <1316085727-15023-7-git-send-email-rnayak@ti.com>
 <1316085727-15023-8-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59752 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933301Ab1IOLWh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 07:22:37 -0400
In-Reply-To: <1316085727-15023-8-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Pass the fixed voltage regulator information for
omap4panda board from device tree.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 0a83e3f..9c34c7f 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -52,6 +52,16 @@
 			interrupts = <11>;
 			reg = <0>;
 		};
+
+		vwl1271-fixedregulator {
+			compatible = "regulator-fixed","ti,twl-reg";
+			supply-name = "vwl1271";
+			microvolts = <1800000>;
+			gpio = <43>;
+			startup-delay = <70000>;
+			enable-high;
+			enabled-at-boot;
+		};
 	};
 };
 
-- 
1.7.1

