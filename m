From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/19] OMAP2/3: PRCM: fix misc. compiler warnings
Date: Mon, 15 Feb 2010 18:24:53 -0700
Message-ID: <20100216012451.1101.9783.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57425 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496Ab0BPB07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:59 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

- missing return in omap_prcm_get_reset_sources()
- potential use of uninitialized variable in omap_prcm_arch_reset()

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 0f87fdc..356a020 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -127,13 +127,15 @@ u32 omap_prcm_get_reset_sources(void)
 		return prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
 	if (cpu_is_omap44xx())
 		return prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
+
+	return 0;
 }
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 
 /* Resets clock rates and reboots the system. Only called from system.h */
 void omap_prcm_arch_reset(char mode)
 {
-	s16 prcm_offs;
+	s16 prcm_offs = 0;
 
 	if (cpu_is_omap24xx()) {
 		omap2xxx_clk_prepare_for_reboot();


