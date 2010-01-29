From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/3] OMAP4: Enable L2 Cache
Date: Fri, 29 Jan 2010 17:16:29 +0530
Message-ID: <1264765589-18353-3-git-send-email-santosh.shilimkar@ti.com>
References: <1264765589-18353-1-git-send-email-santosh.shilimkar@ti.com>
 <1264765589-18353-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52633 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756096Ab0A2Lqt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jan 2010 06:46:49 -0500
In-Reply-To: <1264765589-18353-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, rmk@arm.linux.org.uk, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch enables L2 cache and associated Errata on the OMAP4430
SDP.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 3de640a..781770f 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -242,6 +242,8 @@ CONFIG_CPU_CP15_MMU=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_HAS_TLS_REG=y
+CONFIG_OUTER_CACHE=y
+CONFIG_CACHE_L2X0=y
 CONFIG_ARM_L1_CACHE_SHIFT=5
 # CONFIG_ARM_ERRATA_430973 is not set
 # CONFIG_ARM_ERRATA_458693 is not set
-- 
1.6.0.4

