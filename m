From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/5] ARM: dts: omap5-evm: Update available memory to 2032 MB
Date: Fri, 18 Jan 2013 21:02:20 +0530
Message-ID: <1358523141-12295-5-git-send-email-santosh.shilimkar@ti.com>
References: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33137 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab3ARPbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 10:31:36 -0500
In-Reply-To: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

On OMAP5 to detect invalid/bad memory accesses, 16MB of DDR is used as a trap.
Hence available memory for linux OS is 2032 MB on boards popullated with 2 GB
memory.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 8722c15..b0e218a 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -16,7 +16,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x80000000 0x80000000>; /* 2 GB */
+		reg = <0x80000000 0x7F000000>; /* 2032 MB */
 	};
 
 	vmmcsd_fixed: fixedregulator-mmcsd {
-- 
1.7.9.5

