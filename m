From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2 2/2] omap4: SRAM start address correction
Date: Sun, 11 Jul 2010 01:41:54 -0500
Message-ID: <1278830514-27734-2-git-send-email-vikram.pandita@ti.com>
References: <1278830514-27734-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35338 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab0GKGkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Jul 2010 02:40:33 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6B6eWnP000826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 11 Jul 2010 01:40:32 -0500
In-Reply-To: <1278830514-27734-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

On OMAP4 there is no need to have SRAM_BOOTLOADER_SZ provision

Hence put this macro under CONFIG_ARCH_OMAP2PLUS check

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/sram.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 2eb5a27..a72b391 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -53,7 +53,7 @@
 #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
 #define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2PLUS)
 #define SRAM_BOOTLOADER_SZ	0x00
 #else
 #define SRAM_BOOTLOADER_SZ	0x80
-- 
1.6.6.1

