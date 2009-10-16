From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/14] omap: Move SRAM map to claim more io space
Date: Fri, 16 Oct 2009 16:42:25 -0700
Message-ID: <20091016234224.2463.64043.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51277 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZJPXmV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 19:42:21 -0400
In-Reply-To: <20091016233624.2463.26653.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch moves SRAM map to free up more kernel address io space.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/sram.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 93bdbaf..4144f81 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -41,14 +41,14 @@
 #define OMAP1_SRAM_VA		VMALLOC_END
 #define OMAP2_SRAM_PA		0x40200000
 #define OMAP2_SRAM_PUB_PA	0x4020f800
-#define OMAP2_SRAM_VA		0xe3000000
+#define OMAP2_SRAM_VA		0xfe400000
 #define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
 #define OMAP3_SRAM_PA           0x40200000
-#define OMAP3_SRAM_VA           0xe3000000
+#define OMAP3_SRAM_VA           0xfe400000
 #define OMAP3_SRAM_PUB_PA       0x40208000
 #define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
 #define OMAP4_SRAM_PA		0x40200000		/*0x402f0000*/
-#define OMAP4_SRAM_VA		0xd7000000		/*0xd70f0000*/
+#define OMAP4_SRAM_VA		0xfe400000		/*0xfe4f0000*/
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00

