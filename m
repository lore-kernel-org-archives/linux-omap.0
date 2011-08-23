From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 8/9] OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
Date: Tue, 23 Aug 2011 15:28:18 +0300
Message-ID: <1314102499-30407-9-git-send-email-tomi.valkeinen@ti.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51810 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754193Ab1HWM2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:28:53 -0400
Received: by mail-bw0-f48.google.com with SMTP id t2so56250bka.35
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:28:51 -0700 (PDT)
In-Reply-To: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP2/3 dss_core has a reset status flag in sysstatus register. Add
SYSS_HAS_RESET_STATUS flag to HWMOD data so it can be used.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index c451729..d78c132 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -43,7 +43,8 @@ static struct omap_hwmod_class_sysconfig omap2_dss_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-- 
1.7.4.1

