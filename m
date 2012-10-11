From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 1/3] ARM: dts: omap5-evm: Fix size of memory defined for EVM
Date: Thu, 11 Oct 2012 18:17:47 +0530
Message-ID: <1349959669-16366-2-git-send-email-lokeshvutla@ti.com>
References: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39299 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756351Ab2JKMsB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 08:48:01 -0400
In-Reply-To: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, lokeshvutla@ti.com

Memory present for OMAP5-evm is 2GB. But in dts file
it is specified as 1GB. Correcting the same.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 9c41a3f..6f87e1a 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -15,7 +15,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x80000000 0x40000000>; /* 1 GB */
+		reg = <0x80000000 0x80000000>; /* 2 GB */
 	};
 
 	vmmcsd_fixed: fixedregulator-mmcsd {
-- 
1.7.10.4

