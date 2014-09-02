From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 5/6] ARM: OMAP2+: gpmc: Don't complain if wait pin is used without r/w monitoring
Date: Tue, 2 Sep 2014 16:57:06 +0300
Message-ID: <1409666227-20622-6-git-send-email-rogerq@ti.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49570 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbaIBN5W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2014 09:57:22 -0400
In-Reply-To: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

For NAND read & write wait pin monitoring must be kept disabled as the
wait pin is only used to indicate NAND device ready status and not to
extend each read/write cycle.

So don't print a warning if wait pin is specified while read/write
monitoring is not in the device tree.

Sanity check wait pin number irrespective if read/write monitoring is
set or not.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/gpmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 9f42d54..2f97228 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1207,8 +1207,7 @@ int gpmc_cs_program_settings(int cs, struct gpmc_settings *p)
 		}
 	}
 
-	if ((p->wait_on_read || p->wait_on_write) &&
-	    (p->wait_pin > gpmc_nr_waitpins)) {
+	if (p->wait_pin > gpmc_nr_waitpins) {
 		pr_err("%s: invalid wait-pin (%d)\n", __func__, p->wait_pin);
 		return -EINVAL;
 	}
@@ -1288,8 +1287,8 @@ void gpmc_read_settings_dt(struct device_node *np, struct gpmc_settings *p)
 		p->wait_on_write = of_property_read_bool(np,
 							 "gpmc,wait-on-write");
 		if (!p->wait_on_read && !p->wait_on_write)
-			pr_warn("%s: read/write wait monitoring not enabled!\n",
-				__func__);
+			pr_debug("%s: rd/wr wait monitoring not enabled!\n",
+				 __func__);
 	}
 }
 
-- 
1.8.3.2

