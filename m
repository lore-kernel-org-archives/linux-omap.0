From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 11/12] ARM: OMAP4: hwmod_data: add context lose information for l4_abe hwmod
Date: Thu, 19 Jul 2012 16:26:31 +0300
Message-ID: <1342704392-23657-12-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56323 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615Ab2GSN1W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 09:27:22 -0400
In-Reply-To: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org

'l4_abe' hwmod uses the LOSTMEM_AESSMEM bit of RM_ABE_AESS_CONTEXT register,
as l4_abe doesn't have its own dedicated register for this purpose. This
register is shared with 'aess' hwmod, thus both hwmods must also specify
which bits of the register are used for them.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 8b60377..48431cb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -204,7 +204,8 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
-			.context_offs = USHRT_MAX,
+			.context_offs = OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
+			.lostcontext_mask = OMAP4430_LOSTMEM_AESSMEM_MASK,
 		},
 	},
 };
@@ -350,6 +351,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
+			.lostcontext_mask = OMAP4430_LOSTCONTEXT_DFF_MASK,
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-- 
1.7.4.1

