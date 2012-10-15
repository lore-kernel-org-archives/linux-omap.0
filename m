From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/5] ARM: OMAP2+: PRM: remove PRM weak functions
Date: Mon, 15 Oct 2012 17:05:41 -0600
Message-ID: <20121015230538.18306.93245.stgit@dusk.lan>
References: <20121015224455.18306.89030.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42500 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab2JOXG4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 19:06:56 -0400
In-Reply-To: <20121015224455.18306.89030.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Remove the now-unused PRM weak functions from prm_common.c.  These
were formerly used to ensure that some OMAP2/3 PRM code would build on
OMAP4, but none of those functions ever would have worked on OMAP4 due
to an incompatible PRM register layout.  Now all that has been cleaned
up and these can be removed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm_common.c |   62 --------------------------------------
 1 file changed, 62 deletions(-)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 6b4d332..0a100d9 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -318,65 +318,3 @@ err:
 	omap_prcm_irq_cleanup();
 	return -ENOMEM;
 }
-
-/*
- * Stubbed functions so that common files continue to build when
- * custom builds are used
- * XXX These are temporary and should be removed at the earliest possible
- * opportunity
- */
-u32 __weak omap2_prm_read_mod_reg(s16 module, u16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-void __weak omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-}
-
-u32 __weak omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits,
-		s16 module, s16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-u32 __weak omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-u32 __weak omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-u32 __weak omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-int __weak omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-int __weak omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-
-int __weak omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
-						u8 st_shift)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
-	return 0;
-}
-


