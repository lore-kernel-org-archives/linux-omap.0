From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
Date: Sat, 20 Aug 2011 23:42:41 -0600
Message-ID: <20110821054240.20198.21168.stgit@dusk>
References: <20110821053355.20198.23847.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49134 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab1HUFnx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Aug 2011 01:43:53 -0400
In-Reply-To: <20110821053355.20198.23847.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

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
 


