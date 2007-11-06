From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] Register the L4 io bus to boot OMAP2
Date: Wed, 7 Nov 2007 08:14:42 +0900
Message-ID: <20071106231442.GA8599@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756787AbXKFXST@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch enables the OMAP2 boot

It is already fixed in OMAP tree. It syncs the mainline tree too.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5a4091f..69c8174 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -42,6 +42,12 @@ static struct map_desc omap2_io_desc[] __initdata = {
 		.length		= L3_24XX_SIZE,
 		.type		= MT_DEVICE
 	},
+	{
+		.virtual        = L4_24XX_VIRT,
+		.pfn            = __phys_to_pfn(L4_24XX_PHYS),
+		.length         = L4_24XX_SIZE,
+		.type           = MT_DEVICE
+	},
 #ifdef CONFIG_ARCH_OMAP2430
 	{
 		.virtual	= L4_WK_243X_VIRT,
