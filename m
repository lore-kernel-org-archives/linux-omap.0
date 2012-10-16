From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] ARM: OMAP2+: hwmod data: Fix wrong lostcontext_mask for OMAP4
 l4_abe
Date: Tue, 16 Oct 2012 10:55:14 +0200
Message-ID: <507D20F2.9060007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32861 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698Ab2JPIzV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Oct 2012 04:55:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: "Guiriec, Sebastien" <s-guiriec@ti.com>, Tero Kristo <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

The following commit added the support for the lostcontext_mask
along with the usage of the flag for l4_abe.

 commit ce80979aedfce937926a8dd40a1f92fd4bc2fd53
 Author: Tero Kristo <t-kristo@ti.com>
 Date:   Sun Sep 23 17:28:19 2012 -0600

    ARM: OMAP4: hwmod data: add support for lostcontext_mask

Unfortunately, the l4_abe does not contain this memory and thus
cannot contain that flag.

Remove the flag from the l4_abe hwmod.

Change as well the mask for omap44xx_aess_hwmod to avoid missing
the status in case LOSTMEM_AESSMEM is set. The AESS logic does
not support retention and thus only the memory state is useful.
It is even mandatory to avoid a crash in the case of the AESS
resume.

TBD: Ideally each hwmod should contain an extra entry for memory
context attached to it. The AESS does contain only one, but some
IP like the IVAHD does have three memories with dedicated status.
The granularity is never used, but at least one global information
for all the memory banks is useful.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 652d028..c820de2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -203,9 +203,7 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
-			.lostcontext_mask = OMAP4430_LOSTMEM_AESSMEM_MASK,
-			.flags	      = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
 };
@@ -351,7 +349,7 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
-			.lostcontext_mask = OMAP4430_LOSTCONTEXT_DFF_MASK,
+			.lostcontext_mask = OMAP4430_LOSTMEM_AESSMEM_MASK,
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-- 
1.7.0.4
