From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/4] OMAP4: Enable L2 Cache
Date: Thu, 10 Dec 2009 00:13:53 +0530
Message-ID: <1260384233-2278-4-git-send-email-santosh.shilimkar@ti.com>
References: <1260384233-2278-1-git-send-email-santosh.shilimkar@ti.com>
 <1260384233-2278-2-git-send-email-santosh.shilimkar@ti.com>
 <1260384233-2278-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53930 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756994AbZLISoO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 13:44:14 -0500
In-Reply-To: <1260384233-2278-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch enables L2 cache and associated Errata on the OMAP4430
SDP.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 49df3ad..2a8d555 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -243,10 +243,13 @@ CONFIG_CPU_CP15_MMU=y
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

