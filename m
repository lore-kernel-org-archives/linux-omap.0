From: Nishanth Menon <nm@ti.com>
Subject: [pm_wip/voltdm_nm][PATCH v2 3/3] OMAP4: PM: VC: make omap_vc_i2c_init static
Date: Sun, 29 May 2011 16:19:40 -0700
Message-ID: <1306711180-8631-4-git-send-email-nm@ti.com>
References: <1306711180-8631-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:40808 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752911Ab1E2XTw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 May 2011 19:19:52 -0400
Received: by gwb17 with SMTP id 17so1516940gwb.29
        for <linux-omap@vger.kernel.org>; Sun, 29 May 2011 16:19:51 -0700 (PDT)
In-Reply-To: <1306711180-8631-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

The only user of omap_vc_i2c_init is vc.c itself, makes
no reason for us to expose it out.

This also fixes the sparse warning:
arch/arm/mach-omap2/vc.c:207:13: warning: symbol 'omap_vc_i2c_init' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 42c77a8..d0b52cc 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -204,7 +204,7 @@ static void __init omap4_vc_init_channel(struct voltagedomain *voltdm)
  * channel registers.  All other VC channels will use the
  * same configuration.
  */
-void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
+static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
 	static bool initialized;
-- 
1.7.1

