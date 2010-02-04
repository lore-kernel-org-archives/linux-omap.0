From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/5] OMAP4: Enable L2 Cache
Date: Thu,  4 Feb 2010 19:55:47 +0530
Message-ID: <1265293547-18960-5-git-send-email-santosh.shilimkar@ti.com>
References: <1265293547-18960-1-git-send-email-santosh.shilimkar@ti.com>
 <1265293547-18960-2-git-send-email-santosh.shilimkar@ti.com>
 <1265293547-18960-3-git-send-email-santosh.shilimkar@ti.com>
 <1265293547-18960-4-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34743 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219Ab0BDO0Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 09:26:24 -0500
In-Reply-To: <1265293547-18960-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, rmk@arm.linux.org.uk, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

This patch enables L2 cache and associated Errata on the OMAP4430
SDP.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/configs/omap_4430sdp_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 3de640a..c48d7b8 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -242,10 +242,13 @@ CONFIG_CPU_CP15_MMU=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_HAS_TLS_REG=y
+CONFIG_OUTER_CACHE=y
+CONFIG_CACHE_L2X0=y
 CONFIG_ARM_L1_CACHE_SHIFT=5
 # CONFIG_ARM_ERRATA_430973 is not set
 # CONFIG_ARM_ERRATA_458693 is not set
 # CONFIG_ARM_ERRATA_460075 is not set
+CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_GIC=y
 
 #
-- 
1.6.0.4

