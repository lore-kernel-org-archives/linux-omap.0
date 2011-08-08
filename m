From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 4/5] OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
Date: Mon,  8 Aug 2011 12:15:13 +0300
Message-ID: <1312794914-22894-5-git-send-email-tomi.valkeinen@ti.com>
References: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:60957 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490Ab1HHJPe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Aug 2011 05:15:34 -0400
Received: by mail-fx0-f47.google.com with SMTP id 11so4485967fxg.6
        for <linux-omap@vger.kernel.org>; Mon, 08 Aug 2011 02:15:32 -0700 (PDT)
In-Reply-To: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP2/3 dss_core has a reset status flag in sysstatus register. Add
SYSS_HAS_RESET_STATUS flag to HWMOD data so it can be used.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
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

