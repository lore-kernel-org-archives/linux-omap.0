From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] OMAPFB: fix printing of reserved memory
Date: Fri, 12 Sep 2008 13:27:16 +0300
Message-ID: <20080912102716.23245.73291.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38573 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbYILK1r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 06:27:47 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8CARhEh028973
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 13:27:45 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Print reserved memory only if it was actually reserved.
---

 arch/arm/plat-omap/fb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index f9927a7..63c82ef 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -207,9 +207,10 @@ void __init omapfb_reserve_sdram(void)
 			config_invalid = 1;
 			return;
 		}
-		if (rg.paddr)
+		if (rg.paddr) {
 			reserve_bootmem(rg.paddr, rg.size, BOOTMEM_DEFAULT);
-		reserved += rg.size;
+			reserved += rg.size;
+		}
 		omapfb_config.mem_desc.region[i] = rg;
 		configured_regions++;
 	}

