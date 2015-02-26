From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 4/8] ARM OMAP2+ GPMC: fix debug output alignment
Date: Thu, 26 Feb 2015 15:45:51 +0100
Message-ID: <1424961956-29353-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

GPMC debug output is aligned to 10 characters for field names.
However, some fields have bigger names, screwing up the alignment.
Consequently, alignment was changed to longest field name (17 chars) for now.

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 drivers/memory/omap-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 74a8c52..dbb6753 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -482,7 +482,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	l = gpmc_cs_read_reg(cs, reg);
 #ifdef DEBUG
 	printk(KERN_INFO
-		"GPMC CS%d: %-10s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
+		"GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
 	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
 			(l >> st_bit) & mask, time);
 #endif
-- 
2.3.0
