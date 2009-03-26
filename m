From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 1/3] ARM:OMAP3: Enable SDRC workaround for ES3.1
Date: Thu, 26 Mar 2009 15:58:59 +0200
Message-ID: <1238075941-24931-2-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1238075941-24931-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:7710 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754733AbZCZOQE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Mar 2009 10:16:04 -0400
In-Reply-To: <1238075941-24931-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Enable a workaround to manually restart the SDRC
auto-refresh after wake-up from off mode also on
ES3.1 silicon revision chips.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/control.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 31284c6..a0429fe 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -209,7 +209,8 @@ void omap3_save_scratchpad_contents(void)
 
 	/* Populate the Scratchpad contents */
 	scratchpad_contents.boot_config_ptr = 0x0;
-	if (omap_rev() != OMAP3430_REV_ES3_0)
+	if (omap_rev() != OMAP3430_REV_ES3_0 &&
+					omap_rev() != OMAP3430_REV_ES3_1)
 		scratchpad_contents.public_restore_ptr =
 			virt_to_phys(get_restore_pointer());
 	else
-- 
1.5.4.3

