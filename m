From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/29] ARM: OMAP2+: Make omap-secure.h local
Date: Wed, 19 Sep 2012 14:06:11 -0700
Message-ID: <20120919210611.28074.39845.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43537 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072Ab2ISVGN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:06:13 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap-secure.c              |    2 +-
 arch/arm/mach-omap2/omap-secure.h              |    0 
 arch/arm/mach-omap2/omap-smp.c                 |    2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c           |    2 +-
 arch/arm/mach-omap2/sleep44xx.S                |    2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/mach-omap2/{include/mach/omap-secure.h => omap-secure.h} (100%)

diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index d9ae4a5..a004cb9 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -19,7 +19,7 @@
 #include <asm/memblock.h>
 
 #include <plat/omap-secure.h>
-#include <mach/omap-secure.h>
+#include "omap-secure.h"
 
 static phys_addr_t omap_secure_memblock_base;
 
diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
similarity index 100%
rename from arch/arm/mach-omap2/include/mach/omap-secure.h
rename to arch/arm/mach-omap2/omap-secure.h
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 19cc5f5..cf2b32e 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -24,7 +24,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 
-#include <mach/omap-secure.h>
+#include "omap-secure.h"
 #include <mach/omap-wakeupgen.h>
 #include <asm/cputype.h>
 
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 5fb3112..1729823 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -28,7 +28,7 @@
 #include <asm/hardware/gic.h>
 
 #include <mach/omap-wakeupgen.h>
-#include <mach/omap-secure.h>
+#include "omap-secure.h"
 
 #include "soc.h"
 #include "omap4-sar-layout.h"
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index b7d8ead..88ff83a 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -14,7 +14,7 @@
 #include <asm/memory.h>
 #include <asm/hardware/cache-l2x0.h>
 
-#include <mach/omap-secure.h>
+#include "omap-secure.h"
 
 #include "common.h"
 #include "omap44xx.h"

