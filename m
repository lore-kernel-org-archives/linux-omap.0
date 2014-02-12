From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] ARM: OMAP2+: Remove legacy macros for zoom platforms
Date: Wed, 12 Feb 2014 10:45:52 +0100
Message-ID: <1392198352.23759.10.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Richard Weinberger <richard@nod.at>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Commit 97411608fd5f ("ARM: OMAP2+: Remove legacy support for zoom
platforms") removed the Kconfig symbols MACH_OMAP_ZOOM2 and
MACH_OMAP_ZOOM3. Remove the last usage of the related macros too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested, but should have zero impact.

 arch/arm/mach-omap2/io.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index d408b15..af432b1 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -179,15 +179,6 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
 		.length		= L4_EMU_34XX_SIZE,
 		.type		= MT_DEVICE
 	},
-#if defined(CONFIG_DEBUG_LL) &&							\
-	(defined(CONFIG_MACH_OMAP_ZOOM2) || defined(CONFIG_MACH_OMAP_ZOOM3))
-	{
-		.virtual	= ZOOM_UART_VIRT,
-		.pfn		= __phys_to_pfn(ZOOM_UART_BASE),
-		.length		= SZ_1M,
-		.type		= MT_DEVICE
-	},
-#endif
 };
 #endif
 
-- 
1.8.5.3
