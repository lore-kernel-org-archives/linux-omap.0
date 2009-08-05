From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] OMAP3: Fix omap3 sram virtual addres overlap vmalloc
	space after increasing vmalloc size
Date: Wed, 05 Aug 2009 17:15:51 +0300
Message-ID: <20090805141551.1964.35564.stgit@localhost>
References: <20090805141051.1964.74687.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56215 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934373AbZHEOQB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:16:01 -0400
In-Reply-To: <20090805141051.1964.74687.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Janboe Ye <yuan-bo.ye@motorola.com>, Li Hong Mei <hong-mei.li@motorola.com>

From: Janboe Ye <yuan-bo.ye@motorola.com>

commit e85c205ac1427f2405021a36f083280ff0d0a35e increase vmalloc size.
vmalloc space will overlap with OMAP3 sram virtual address.

Signed-off-by: Li Hong Mei <hong-mei.li@motorola.com>
Signed-off-by: Janboe Ye <yuan-bo.ye@motorola.com>
Reviewed-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/sram.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 4ea7380..2890b11 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -44,9 +44,9 @@
 #define OMAP2_SRAM_VA		0xe3000000
 #define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
 #define OMAP3_SRAM_PA           0x40200000
-#define OMAP3_SRAM_VA           0xd7000000
+#define OMAP3_SRAM_VA           0xe3000000
 #define OMAP3_SRAM_PUB_PA       0x40208000
-#define OMAP3_SRAM_PUB_VA       0xd7008000
+#define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
 #define OMAP4_SRAM_PA		0x40200000		/*0x402f0000*/
 #define OMAP4_SRAM_VA		0xd7000000		/*0xd70f0000*/
 

