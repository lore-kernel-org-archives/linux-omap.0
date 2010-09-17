From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 03/14] davinci: map sram using MT_MEMORY_NONCACHED instead of MT_DEVICE
Date: Fri, 17 Sep 2010 15:17:47 +0530
Message-ID: <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37168 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab0IQJsL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 05:48:11 -0400
In-Reply-To: <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Davinci SRAM is mapped as MT_DEVICE becasue of the section
mapping pre-requisite instead of intended MT_MEMORY_NONCACHED

Since the section mapping limitation gets fixed with first
patch in this series, the MT_MEMORY_NONCACHED can be used now.

Have not tested this, so somebody with Davinci hardware can
try this out

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dm355.c  |    3 +--
 arch/arm/mach-davinci/dm365.c  |    3 +--
 arch/arm/mach-davinci/dm644x.c |    3 +--
 arch/arm/mach-davinci/dm646x.c |    3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 3d996b6..9be261b 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -769,8 +769,7 @@ static struct map_desc dm355_io_desc[] = {
 		.virtual	= SRAM_VIRT,
 		.pfn		= __phys_to_pfn(0x00010000),
 		.length		= SZ_32K,
-		/* MT_MEMORY_NONCACHED requires supersection alignment */
-		.type		= MT_DEVICE,
+		.type		= MT_MEMORY_NONCACHED,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 6b6f4c6..7781e35 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -969,8 +969,7 @@ static struct map_desc dm365_io_desc[] = {
 		.virtual	= SRAM_VIRT,
 		.pfn		= __phys_to_pfn(0x00010000),
 		.length		= SZ_32K,
-		/* MT_MEMORY_NONCACHED requires supersection alignment */
-		.type		= MT_DEVICE,
+		.type		= MT_MEMORY_NONCACHED,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 40fec31..5e5b0a7 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -653,8 +653,7 @@ static struct map_desc dm644x_io_desc[] = {
 		.virtual	= SRAM_VIRT,
 		.pfn		= __phys_to_pfn(0x00008000),
 		.length		= SZ_16K,
-		/* MT_MEMORY_NONCACHED requires supersection alignment */
-		.type		= MT_DEVICE,
+		.type		= MT_MEMORY_NONCACHED,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index e4a3df1..26e8a9c 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -737,8 +737,7 @@ static struct map_desc dm646x_io_desc[] = {
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

