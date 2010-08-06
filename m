From: Charulatha V <charu@ti.com>
Subject: [PATCH] OMAP4: HWMOD: Do omap_hwmod_late_init for OMAP4
Date: Fri,  6 Aug 2010 18:01:13 +0530
Message-ID: <1281097873-24094-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41635 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668Ab0HFM2h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 08:28:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, rnayak@ti.com, Charulatha V <charu@ti.com>, "Basak, Partha" <p-basak2@ti.com>

This patch includes "cpu_is" check for omap44xx cpu inorder to do
omap_hwmod_late_init() without which hwmods initialization does not
happen for omap4.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap2/io.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b89e678..9b15f46 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -345,7 +345,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 #ifndef CONFIG_PM_RUNTIME
 	skip_setup_idle = 1;
 #endif
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
+	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
 		omap_hwmod_late_init(skip_setup_idle);
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-- 
1.6.3.3

