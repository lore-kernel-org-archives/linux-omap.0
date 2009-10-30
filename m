From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH] omap3evm: make HSMMC driver built-in.
Date: Fri, 30 Oct 2009 11:16:46 +0530
Message-ID: <1256881606-24545-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37413 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731AbZJ3Fqq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Oct 2009 01:46:46 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9U5kmDU010820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 00:46:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>

For ease of use it is preferrable to build in HSMMC driver
rather than build it as kernel module. This patches updates
default configuration for omap3evm to reflect this change.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
 arch/arm/configs/omap3_evm_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index d5ff477..36c99e0 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -1126,7 +1126,7 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 #
 # CONFIG_MMC_SDHCI is not set
 # CONFIG_MMC_OMAP is not set
-CONFIG_MMC_OMAP_HS=m
+CONFIG_MMC_OMAP_HS=y
 # CONFIG_MMC_SPI is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_ACCESSIBILITY is not set
-- 
1.6.2.4

