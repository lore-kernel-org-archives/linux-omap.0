From: Janboe Ye <yuan-bo.ye@motorola.com>
Subject: [PATCH] fix omap3 sram virtual addres overlap vmalloc space after
 increasing vmalloc size
Date: Thu, 16 Jul 2009 17:47:57 -0500
Message-ID: <1247784477.25106.35.camel@debian-nb>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail55.messagelabs.com ([216.82.241.163]:39127 "EHLO
	mail55.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933480AbZGPWs1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 18:48:27 -0400
Received: from il27exr04.cig.mot.com (il27exr04.mot.com [10.17.196.73])
	by motgate4.mot.com (8.14.3/8.14.3) with ESMTP id n6GMmL80026551
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2009 15:48:21 -0700 (MST)
Received: from az10vts04.mot.com (il27vts04.cig.mot.com [10.17.196.88])
	by il27exr04.cig.mot.com (8.13.1/Vontu) with SMTP id n6GMmL3l018450
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2009 17:48:21 -0500 (CDT)
Received: from zmy16exm62.ds.mot.com (zmy16exm62.ap.mot.com [10.179.4.33])
	by il27exr04.cig.mot.com (8.13.1/8.13.0) with ESMTP id n6GMmJqc018442
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2009 17:48:20 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mans@mansr.com, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, hong-mei.li@motorola.com

resend for mini coding style fixing

commit e85c205ac1427f2405021a36f083280ff0d0a35e increase vmalloc size.
vmalloc space will overlap with OMAP3 sram virtual address.

Signed-off-by: Li Hong Mei <hong-mei.li@motorola.com>
Signed-off-by: Janboe Ye <yuan-bo.ye@motorola.com>
---
 arch/arm/plat-omap/sram.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a2e60e7..755ccaa 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -41,9 +41,9 @@
 #define OMAP2_SRAM_VA          0xe3000000
 #define OMAP2_SRAM_PUB_VA      (OMAP2_SRAM_VA + 0x800)
 #define OMAP3_SRAM_PA           0x40200000
-#define OMAP3_SRAM_VA           0xd7000000
+#define OMAP3_SRAM_VA           0xe3000000
 #define OMAP3_SRAM_PUB_PA       0x40208000
-#define OMAP3_SRAM_PUB_VA       0xd7008000
+#define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)

 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ     0x00

