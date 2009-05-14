From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/8] ARM: OMAP: Fix printing of reserved memory for frambuffer
Date: Thu, 14 May 2009 10:43:12 -0700
Message-ID: <20090514174312.12080.67286.stgit@localhost>
References: <20090514174100.12080.9736.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58260 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbZENRnT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:43:19 -0400
In-Reply-To: <20090514174100.12080.9736.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Print reserved memory only if it was actually reserved.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/fb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index ce6b4ba..3746222 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -206,9 +206,10 @@ void __init omapfb_reserve_sdram(void)
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

