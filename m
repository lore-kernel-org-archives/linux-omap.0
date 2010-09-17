From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 09/14] omap4: sram: Fix start address
Date: Fri, 17 Sep 2010 15:17:53 +0530
Message-ID: <1284716878-27667-10-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-5-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-7-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37171 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab0IQJsL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 05:48:11 -0400
In-Reply-To: <1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

On OMAP4 there is no need to have SRAM_BOOTLOADER_SZ provision

Hence put this macro under CONFIG_ARCH_OMAP2PLUS check

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/sram.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 1faaa6e..33ee6b8 100644
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
1.6.0.4

