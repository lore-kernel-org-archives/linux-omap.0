From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/16] ARM: OMAP: Merge plat/multi.h into plat/cpu.h
Date: Thu, 04 Oct 2012 15:05:01 -0700
Message-ID: <20121004220501.26676.29335.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11263 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753428Ab2JDWFC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 18:05:02 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is private to cpu.h and no other places should
need to include it and we can drop the include
in mach-omap2/io.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c                |    1 
 arch/arm/plat-omap/include/plat/cpu.h   |   96 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/multi.h |  120 -------------------------------
 3 files changed, 95 insertions(+), 122 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/multi.h

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 1e81d54..614af76 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -29,7 +29,6 @@
 #include <plat/serial.h>
 #include <plat/omap-pm.h>
 #include "omap_hwmod.h"
-#include <plat/multi.h>
 #include <plat/dma.h>
 
 #include "../plat-omap/sram.h"
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 67da857..bfd9c5f 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -33,7 +33,101 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
-#include <plat/multi.h>
+
+/*
+ * Test if multicore OMAP support is needed
+ */
+#undef MULTI_OMAP1
+#undef MULTI_OMAP2
+#undef OMAP_NAME
+
+#ifdef CONFIG_ARCH_OMAP730
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP1
+#  define MULTI_OMAP1
+# else
+#  define OMAP_NAME omap730
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP850
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP1
+#  define MULTI_OMAP1
+# else
+#  define OMAP_NAME omap850
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP15XX
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP1
+#  define MULTI_OMAP1
+# else
+#  define OMAP_NAME omap1510
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP1
+#  define MULTI_OMAP1
+# else
+#  define OMAP_NAME omap16xx
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP2PLUS
+# if (defined(OMAP_NAME) || defined(MULTI_OMAP1))
+#  error "OMAP1 and OMAP2PLUS can't be selected at the same time"
+# endif
+#endif
+#ifdef CONFIG_SOC_OMAP2420
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap2420
+# endif
+#endif
+#ifdef CONFIG_SOC_OMAP2430
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap2430
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP3
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap3
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP4
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap4
+# endif
+#endif
+
+#ifdef CONFIG_SOC_OMAP5
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap5
+# endif
+#endif
+
+#ifdef CONFIG_SOC_AM33XX
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME am33xx
+# endif
+#endif
 
 /*
  * Omap device type i.e. EMU/HS/TST/GP/BAD
diff --git a/arch/arm/plat-omap/include/plat/multi.h b/arch/arm/plat-omap/include/plat/multi.h
deleted file mode 100644
index 324d31b..0000000
--- a/arch/arm/plat-omap/include/plat/multi.h
+++ /dev/null
@@ -1,120 +0,0 @@
-/*
- * Support for compiling in multiple OMAP processors
- *
- * Copyright (C) 2010 Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-
-#ifndef __PLAT_OMAP_MULTI_H
-#define __PLAT_OMAP_MULTI_H
-
-/*
- * Test if multicore OMAP support is needed
- */
-#undef MULTI_OMAP1
-#undef MULTI_OMAP2
-#undef OMAP_NAME
-
-#ifdef CONFIG_ARCH_OMAP730
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP1
-#  define MULTI_OMAP1
-# else
-#  define OMAP_NAME omap730
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP850
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP1
-#  define MULTI_OMAP1
-# else
-#  define OMAP_NAME omap850
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP1
-#  define MULTI_OMAP1
-# else
-#  define OMAP_NAME omap1510
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP1
-#  define MULTI_OMAP1
-# else
-#  define OMAP_NAME omap16xx
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-# if (defined(OMAP_NAME) || defined(MULTI_OMAP1))
-#  error "OMAP1 and OMAP2PLUS can't be selected at the same time"
-# endif
-#endif
-#ifdef CONFIG_SOC_OMAP2420
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap2420
-# endif
-#endif
-#ifdef CONFIG_SOC_OMAP2430
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap2430
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP3
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap3
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap4
-# endif
-#endif
-
-#ifdef CONFIG_SOC_OMAP5
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap5
-# endif
-#endif
-
-#ifdef CONFIG_SOC_AM33XX
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME am33xx
-# endif
-#endif
-
-#endif	/* __PLAT_OMAP_MULTI_H */

