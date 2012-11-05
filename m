From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 3/4] ARM: dts: AM33XX: Set pmic-shutdown-controller for BeagleBone
Date: Mon, 5 Nov 2012 15:12:28 +0530
Message-ID: <1352108549-9341-4-git-send-email-anilkumar@ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60477 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab2KEJnH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 04:43:07 -0500
In-Reply-To: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Set ti,pmic-shutdown-controller for BeagleBone in am335x-bone.dts
file, this flag is used by the driver to set tps65217 PMIC status
to OFF when PWR_EN toggle.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 91eee97..40ea3c7 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -44,6 +44,8 @@
 /include/ "tps65217.dtsi"
 
 &tps {
+	ti,pmic-shutdown-controller;
+
 	regulators {
 		dcdc1_reg: regulator@0 {
 			regulator-always-on;
-- 
1.7.9.5

