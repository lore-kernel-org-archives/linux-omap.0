From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 1/4] Revert "arm/dts: Add support for TI AM335x EVM board"
Date: Fri, 22 Jun 2012 15:10:47 +0530
Message-ID: <1340358050-29560-2-git-send-email-anilkumar@ti.com>
References: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55473 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761906Ab2FVJlB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 05:41:01 -0400
In-Reply-To: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, AnilKumar Ch <anilkumar@ti.com>

This reverts commit 6c54bbb42678c99685c8e7fd09267e1cb8c2ae40.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
Reviewed-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   39 --------------------------------------
 1 file changed, 39 deletions(-)
 delete mode 100644 arch/arm/boot/dts/am335x-evm.dts

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
deleted file mode 100644
index 8cc877f..0000000
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-/dts-v1/;
-
-/include/ "omap3.dtsi"
-
-/ {
-	model = "TI AM335x EVM";
-	compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3";
-
-	memory {
-		device_type = "memory";
-		reg = <0x80000000 0x10000000>; /* 256 MB */
-	};
-};
-
-&intc {
-	/*
-	 * AM33XX family of devices have 128 interrupts
-	 */
-	ti,intc-size = <128>;
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-};
-
-&i2c2 {
-	clock-frequency = <400000>;
-};
-
-&i2c3 {
-	clock-frequency = <400000>;
-};
-- 
1.7.9.5

