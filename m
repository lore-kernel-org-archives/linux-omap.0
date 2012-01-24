From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] ARM: OMAP2/3: HWMOD: Add missing flag for rfbi class
Date: Tue, 24 Jan 2012 12:45:19 +0200
Message-ID: <1327401920-5617-3-git-send-email-tomi.valkeinen@ti.com>
References: <1327401920-5617-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35853 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755784Ab2AXKpj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:45:39 -0500
In-Reply-To: <1327401920-5617-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

hwmod class for rfbi is missing SYSS_HAS_RESET_STATUS, which this patch
adds.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index f08e442..bae4afd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -65,7 +65,7 @@ static struct omap_hwmod_class_sysconfig omap2_rfbi_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
-- 
1.7.4.1

