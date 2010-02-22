From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/2] AM35x: Enable OMAP_MUX in defconfig
Date: Mon, 22 Feb 2010 15:51:13 +0530
Message-ID: <1266834073-7670-2-git-send-email-ajay.gupta@ti.com>
References: <1266834073-7670-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56222 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab0BVKVS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Feb 2010 05:21:18 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1MALFGm006981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 22 Feb 2010 04:21:17 -0600
In-Reply-To: <1266834073-7670-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>

Enabling OMAP_MUX in defconfig as it is required for EHCI to work.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/configs/am3517_evm_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index abe9966..edae1c2 100644
--- a/arch/arm/configs/am3517_evm_defconfig
+++ b/arch/arm/configs/am3517_evm_defconfig
@@ -201,7 +201,7 @@ CONFIG_ARCH_OMAP3=y
 # CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
 # CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
 CONFIG_OMAP_RESET_CLOCKS=y
-# CONFIG_OMAP_MUX is not set
+CONFIG_OMAP_MUX=y
 # CONFIG_OMAP_MCBSP is not set
 # CONFIG_OMAP_MBOX_FWK is not set
 # CONFIG_OMAP_MPU_TIMER is not set
-- 
1.6.2.4

