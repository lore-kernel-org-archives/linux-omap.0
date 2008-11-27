From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] OMAP3 SDP: example use of OMAP VRAM
Date: Thu, 27 Nov 2008 12:36:55 +0200
Message-ID: <1227782215-9325-4-git-send-email-tomi.valkeinen@nokia.com>
References: <1227782215-9325-1-git-send-email-tomi.valkeinen@nokia.com>
 <1227782215-9325-2-git-send-email-tomi.valkeinen@nokia.com>
 <1227782215-9325-3-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57220 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823AbYK0Kh0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 05:37:26 -0500
In-Reply-To: <1227782215-9325-3-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index e2eed49..f3bb647 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -44,6 +44,7 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <mach/control.h>
+#include <mach/omapfb.h>
 
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
@@ -484,9 +485,18 @@ static void __init omap_3430sdp_init(void)
 	hsmmc_init(mmc);
 }
 
+static struct omap_fbmem_config omap_3430sdp_fbmem_config[] = {
+	{
+		.size = 640 * 480 * 2 * 3,
+		.start = OMAPFB_MEMTYPE_SDRAM,
+	},
+};
+
 static void __init omap_3430sdp_map_io(void)
 {
 	omap2_set_globals_343x();
+	omapfb_set_vram_config(omap_3430sdp_fbmem_config,
+			ARRAY_SIZE(omap_3430sdp_fbmem_config));
 	omap2_map_common_io();
 }
 
-- 
1.6.0.3

