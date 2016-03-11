From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: OMAP2: Fix up interconnect barrier initialization for DRA7
Date: Fri, 11 Mar 2016 10:12:28 -0600
Message-ID: <1457712748-1408-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

The following commits:
commit 3fa609755c11 ("ARM: omap2: restore OMAP4 barrier behaviour")
commit f746929ffdc8 ("Revert "ARM: OMAP4: remove dead kconfig option OMAP4_ERRATA_I688"")
and
commit ea827ad5ffbb ("ARM: DRA7: Provide proper IO map table")
came in around the same time, unfortunately this seem to have missed
initializing the barrier for DRA7 platforms - omap5_map_io was reused
for dra7 till it was split out by the last patch. barrier_init
needs to be hence carried forward as it is valid for DRA7 family of
processors as they are for OMAP5.

Fixes: ea827ad5ffbb7 ("ARM: DRA7: Provide proper IO map table")
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Original thread of report: http://www.spinics.net/lists/dri-devel/msg101246.html

 arch/arm/mach-omap2/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3c87e40650cf..9821be6dfd5e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -368,6 +368,7 @@ void __init omap5_map_io(void)
 void __init dra7xx_map_io(void)
 {
 	iotable_init(dra7xx_io_desc, ARRAY_SIZE(dra7xx_io_desc));
+	omap_barriers_init();
 }
 #endif
 /*
-- 
2.7.0
