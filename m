From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH] ARM: io: Fix namespace conflicts.
Date: Wed, 13 Oct 2010 16:22:01 +0530
Message-ID: <1286967121-5888-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42239 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab0JMKwZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Oct 2010 06:52:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, Sourav Poddar <sourav.poddar@ti.com>, Charulatha V <charu@ti.com>

From: Sourav Poddar <sourav.poddar@ti.com>

Having __v as the variable name for the definition of different macros leads to
the namespace pollution. For example,
readl(p)
unrolls to:
({ u32 __v = ({ u32 __v = (( __u32)(__le32)(( __le32) ((void)0,
*(volatile unsigned int *)((p))))); __v; }); __asm__ __volatile__ ("mcr
p15,
, %0, c7, c10, 5" : : "r" (0) : "memory"); __v; });

({ u32 __v = ({ u32 __v
causes sparse warning: "warning: symbol '__v' shadows an earlier one"

Using variable names which use the function name prefix across the
various macros avoids the namespace pollution.

With this change, ~200 sparse warnings in omap2plus_defconfig build are
fixed.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Reviewed by: Nishanth Menon <nm@ti.com>
---
 Links related to the previous discussions are as follows:
 
 http://www.spinics.net/lists/linux-omap/msg38569.html
 http://marc.info/?t=128506336700011&r=1&w=2

 arch/arm/include/asm/io.h |   32 +++++++++++++++++++++-----------
 1 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 1261b1f..01e4a7b 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -131,11 +131,11 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 #define outl(v,p)		__raw_writel((__force __u32) \
 					cpu_to_le32(v),__io(p))
 
-#define inb(p)	({ __u8 __v = __raw_readb(__io(p)); __v; })
-#define inw(p)	({ __u16 __v = le16_to_cpu((__force __le16) \
-			__raw_readw(__io(p))); __v; })
-#define inl(p)	({ __u32 __v = le32_to_cpu((__force __le32) \
-			__raw_readl(__io(p))); __v; })
+#define inb(p)	({ __u8 __inbv = __raw_readb(__io(p)); __inbv; })
+#define inw(p)	({ __u16 __inwv = le16_to_cpu((__force __le16) \
+			__raw_readw(__io(p))); __inwv; })
+#define inl(p)	({ __u32 __inlv = le32_to_cpu((__force __le32) \
+			__raw_readl(__io(p))); __inlv; })
 
 #define outsb(p,d,l)		__raw_writesb(__io(p),d,l)
 #define outsw(p,d,l)		__raw_writesw(__io(p),d,l)
@@ -200,9 +200,12 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define __iowmb()		do { } while (0)
 #endif
 
-#define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
-#define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
-#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(); __v; })
+#define readb(c)		({ u8  __readbv = readb_relaxed(c); \
+					 __iormb(); __readbv; })
+#define readw(c)		({ u16 __readwv = readw_relaxed(c); \
+					 __iormb(); __readwv; })
+#define readl(c)		({ u32 __readlv = readl_relaxed(c);\
+					 __iormb(); __readlv; })
 
 #define writeb(v,c)		({ __iowmb(); writeb_relaxed(v,c); })
 #define writew(v,c)		({ __iowmb(); writew_relaxed(v,c); })
@@ -258,9 +261,16 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  * io{read,write}{8,16,32} macros
  */
 #ifndef ioread8
-#define ioread8(p)	({ unsigned int __v = __raw_readb(p); __iormb(); __v; })
-#define ioread16(p)	({ unsigned int __v = le16_to_cpu((__force __le16)__raw_readw(p)); __iormb(); __v; })
-#define ioread32(p)	({ unsigned int __v = le32_to_cpu((__force __le32)__raw_readl(p)); __iormb(); __v; })
+#define ioread8(p)	({ unsigned int __ioread8v = __raw_readb(p); \
+					 __iormb(); __ioread8v; })
+#define ioread16(p)	({ unsigned int __ioread16v = \
+					 le16_to_cpu((__force __le16) \
+					__raw_readw(p)); __iormb(); \
+					 __ioread16v; })
+#define ioread32(p)	({ unsigned int __ioread32v = \
+					 le32_to_cpu((__force __le32) \
+					__raw_readl(p)); __iormb(); \
+					 __ioread32v; })
 
 #define iowrite8(v,p)	({ __iowmb(); (void)__raw_writeb(v, p); })
 #define iowrite16(v,p)	({ __iowmb(); (void)__raw_writew((__force __u16)cpu_to_le16(v), p); })
-- 
1.7.0.4

