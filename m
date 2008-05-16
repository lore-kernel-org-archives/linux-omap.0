From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] ARM: OMAP: Remove __REG access for multi-omap
Date: Fri, 16 May 2008 14:07:56 -0700
Message-ID: <1210972076-23911-6-git-send-email-tony@atomide.com>
References: <1210972076-23911-1-git-send-email-tony@atomide.com>
 <1210972076-23911-2-git-send-email-tony@atomide.com>
 <1210972076-23911-3-git-send-email-tony@atomide.com>
 <1210972076-23911-4-git-send-email-tony@atomide.com>
 <1210972076-23911-5-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:57571 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757881AbYEPVIG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 17:08:06 -0400
In-Reply-To: <1210972076-23911-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: david-b@pacbell.net, felipe.balbi@nokia.com, Tony Lindgren <tony@atomide.com>

This does not play nicely with multi-omap as it cannot be replaced
by a function in io.c for omaps with different IO bases.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 include/asm-arm/arch-omap/io.h |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/include/asm-arm/arch-omap/io.h b/include/asm-arm/arch-omap/io.h
index 160578e..e1fb7ec 100644
--- a/include/asm-arm/arch-omap/io.h
+++ b/include/asm-arm/arch-omap/io.h
@@ -183,35 +183,12 @@
 #define omap_writew(v,a)	(*(volatile unsigned short *)IO_ADDRESS(a) = (v))
 #define omap_writel(v,a)	(*(volatile unsigned int   *)IO_ADDRESS(a) = (v))
 
-/* 16 bit uses LDRH/STRH, base +/- offset_8 */
-typedef struct { volatile u16 offset[256]; } __regbase16;
-#define __REGV16(vaddr)		((__regbase16 *)((vaddr)&~0xff)) \
-					->offset[((vaddr)&0xff)>>1]
-#define __REG16(paddr)          __REGV16(io_p2v(paddr))
-
-/* 8/32 bit uses LDR/STR, base +/- offset_12 */
-typedef struct { volatile u8 offset[4096]; } __regbase8;
-#define __REGV8(vaddr)		((__regbase8  *)((vaddr)&~4095)) \
-					->offset[((vaddr)&4095)>>0]
-#define __REG8(paddr)		__REGV8(io_p2v(paddr))
-
-typedef struct { volatile u32 offset[4096]; } __regbase32;
-#define __REGV32(vaddr)		((__regbase32 *)((vaddr)&~4095)) \
-					->offset[((vaddr)&4095)>>2]
-#define __REG32(paddr)		__REGV32(io_p2v(paddr))
-
 extern void omap1_map_common_io(void);
 extern void omap1_init_common_hw(void);
 
 extern void omap2_map_common_io(void);
 extern void omap2_init_common_hw(void);
 
-#else
-
-#define __REG8(paddr)		io_p2v(paddr)
-#define __REG16(paddr)		io_p2v(paddr)
-#define __REG32(paddr)		io_p2v(paddr)
-
 #endif
 
 #endif
-- 
1.5.3.6

