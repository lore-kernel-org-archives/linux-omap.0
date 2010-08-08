From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/3] davinci: Map sram using MT_MEMORY_NONCACHED instead of MT_DEVICE
Date: Sun,  8 Aug 2010 15:48:22 +0530
Message-ID: <1281262702-27732-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39592 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645Ab0HHKSe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Aug 2010 06:18:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Kevin Hilman <khilman@deeprootsystems.com>

On Davinci SRAM is mapped as MT_DEVICE becasue of the section
mapping pre-requisite instead of intended MT_MEMORY_NONCACHED

Since the section mapping limitation gets fixed with first
patch in this series, the MT_MEMORY_NONCACHED can be used now.

Have not tested this, so somebody with Davinci hardware can
try this out

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dm355.c  |    3 +--
 arch/arm/mach-davinci/dm365.c  |    3 +--
 arch/arm/mach-davinci/dm644x.c |    3 +--
 arch/arm/mach-davinci/dm646x.c |    3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 3834781..e7bd2ad 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -767,8 +767,7 @@ static struct map_desc dm355_io_desc[] = {
 		.virtual	= SRAM_VIRT,
 		.pfn		= __phys_to_pfn(0x00010000),
 		.length		= SZ_32K,
-		/* MT_MEMORY_NONCACHED requires supersection alignment */
-		.type		= MT_DEVICE,
+		.type		= MT_MEMORY_NONCACHED,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index a146849..5dee032 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -967,8 +967,7 @@ static struct map_desc dm365_io_desc[] = {
 		.virtual	= SRAM_VIRT,
 		.pfn		= __phys_to_pfn(0x00010000),
 		.length		= SZ_32K,
-		/* MT_MEMORY_NONCACHED requires supersection alignment */
-		.type		= MT_DEVICE,
+		.type		= MT_MEMORY_NONCACHED,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 7ad1520..5112d51 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -651,8 +651,7 @@ static struct map_desc dm644x_io_desc[] = {
 		.virtual	= SRAM_VIRT,
 		.pfn		= __phys_to_pfn(0x00008000),
 		.length		= SZ_16K,
-		/* MT_MEMORY_NONCACHED requires supersection alignment */
-		.type		= MT_DEVICE,
+		.type		= MT_MEMORY_NONCACHED,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 9404565..97078f4 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -735,8 +735,7 @@ static struct map_desc dm646x_io_desc[] = {
 		.virtual	= SRAM_VIRT,
 		.pfn		= __phys_to_pfn(0x00010000),
 		.length		= SZ_32K,
-		/* MT_MEMORY_NONCACHED requires supersection alignment */
-		.type		= MT_DEVICE,
+		.type		= MT_MEMORY_NONCACHED,
 	},
 };
 
-- 
1.6.0.4

