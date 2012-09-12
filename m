From: R Sricharan <r.sricharan@ti.com>
Subject: [RFC PATCH] ARM: mm: ADD descriptor string to CONFIG_DMA_ADDR_64BIT_T
Date: Wed, 12 Sep 2012 11:20:06 +0530
Message-ID: <1347429006-10879-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32837 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125Ab2ILFuY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 01:50:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: r.sricharan@ti.com, santosh.shilimkar@ti.com, Catalin Marinas <catalin.marinas@arm.com>

Even if CONFIG_DMA_ADDR_64BIT_T is enabled by the defconfig,
the feature is not getting selected.
Adding a string description in the Kconfig resolves this.

But not sure if this is the right way to fix this.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 101b968..90c5ea4 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -601,7 +601,7 @@ config ARCH_PHYS_ADDR_T_64BIT
 	def_bool ARM_LPAE
 
 config ARCH_DMA_ADDR_T_64BIT
-	bool
+	bool "64bit capable DMA device"
 
 config ARM_THUMB
 	bool "Support Thumb user binaries"
-- 
1.7.9.5

