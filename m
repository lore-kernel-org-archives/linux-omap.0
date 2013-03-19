From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 01/11] ARM: dts: omap5-evm: Update available memory to 2032 MB
Date: Tue, 19 Mar 2013 19:00:47 +0530
Message-ID: <1363699857-5505-2-git-send-email-santosh.shilimkar@ti.com>
References: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57859 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808Ab3CSN3e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 09:29:34 -0400
In-Reply-To: <1363699857-5505-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP5 to detect invalid/bad memory accesses, 16MB of DDR is used as a trap.
Hence available memory for linux OS is 2032 MB on boards popullated with 2 GB
memory.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 64edd51..982acd1 100644
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

