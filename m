From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 4/7] ARM: OMAP2+: Remove unnecessary message when no SHA IP is present
Date: Fri, 19 Oct 2012 14:53:57 -0700
Message-ID: <1350683640-15044-5-git-send-email-mgreer@animalcreek.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:45895 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972Ab2JSVyn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 17:54:43 -0400
In-Reply-To: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, Paul Walmsley <paul@pwsan.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Remove the error message that prints when there is no SHA IP
present to make it consistent with all the other IPs.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/devices.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 40211de..8784812 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -472,8 +472,6 @@ static void __init omap_init_sham(void)
 		pdev = omap_device_build("omap-sham", -1, oh, NULL, 0, NULL,
 					 0, 0);
 		WARN(IS_ERR(pdev), "Can't build omap_device for omap-sham\n");
-	} else {
-		pr_err("%s: platform not supported\n", __func__);
 	}
 }
 
-- 
1.7.12

