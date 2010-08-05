From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 08/12] omap3: sr: cleanup pr_xxx
Date: Thu,  5 Aug 2010 17:24:08 -0500
Message-ID: <1281047052-21346-9-git-send-email-nm@ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57513 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760828Ab0HEWYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Aug 2010 18:24:20 -0400
In-Reply-To: <1281047052-21346-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

pr_xxx family is not informative for debug unless one decides
to grep the code, instead print the function to help debug
easier on the field.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 57fc9b2..d63691b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -804,8 +804,9 @@ static int omap_sr_params_store(void *data, u64 val)
 		u32 *option = data;
 		*option = val;
 	} else {
-		pr_notice("DEBUG option not enabled!\n	\
-			echo 1 > pm_debug/enable_sr_vp_debug - to enable\n");
+		pr_notice("%s: DEBUG option not enabled! "
+			"echo 1 > pm_debug/enable_sr_vp_debug to enable\n",
+			__func__);
 	}
 	return 0;
 }
-- 
1.6.3.3

