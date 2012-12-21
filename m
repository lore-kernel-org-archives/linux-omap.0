From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 05/15] ARM: OMAP2+: Only manually add hwmod data when DT not used.
Date: Fri, 21 Dec 2012 09:28:05 -0700
Message-ID: <1356107295-11121-6-git-send-email-mgreer@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:38857 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab2LUQ2f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 11:28:35 -0500
In-Reply-To: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

The omap_init_sham() routine in devices.c only needs to be
called when there is no device tree present.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 598ab1e..c8f878a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -672,10 +672,10 @@ static int __init omap2_init_devices(void)
 		omap_init_dmic();
 		omap_init_mcpdm();
 		omap_init_mcspi();
+		omap_init_sham();
 	}
 	omap_init_sti();
 	omap_init_rng();
-	omap_init_sham();
 	omap_init_aes();
 	omap_init_vout();
 	omap_init_ocp2scp();
-- 
1.7.12

