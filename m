From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 3/7] ARM: OMAP4: hwmod: flag hwmods/modules not supporting module level context status
Date: Mon, 11 Jun 2012 18:26:23 +0300
Message-ID: <1339428387-4800-4-git-send-email-t-kristo@ti.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34279 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab2FKP0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 11:26:46 -0400
In-Reply-To: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

On OMAP4 most modules/hwmods support module level context status. On
OMAP3 and earlier, we relied on the power domain level context status.
Identify all modules that don't support 'context_offs' by marking the
offset as USHRT_MAX. Rest have a valid 'context_offs' populated in
.prcm structure already.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 86fc513..828e7b8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -208,6 +208,7 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
+			.context_offs = USHRT_MAX,
 		},
 	},
 };
-- 
1.7.4.1

