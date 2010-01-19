From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 11/18] OMAP2 clock: don't compile OMAP2430-only functions
	on non-2430 builds
Date: Tue, 19 Jan 2010 16:36:23 -0700
Message-ID: <20100119233619.26047.86133.stgit@localhost.localdomain>
References: <20100119232900.26047.98263.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58631 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab0ASXie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 18:38:34 -0500
In-Reply-To: <20100119232900.26047.98263.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

omap2430_clk_i2chs_find_idlest() doesn't need to be compiled in on
non-2430 builds, so skip it in those cases to save memory.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2xxx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index b59cb1d..e5b9851 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -50,6 +50,8 @@ struct clk *vclk, *sclk, *dclk;
  * Omap24xx specific clock functions
  *-------------------------------------------------------------------------*/
 
+#ifdef CONFIG_ARCH_OMAP2430
+
 /**
  * omap2430_clk_i2chs_find_idlest - return CM_IDLEST info for 2430 I2CHS
  * @clk: struct clk * being enabled
@@ -69,6 +71,10 @@ static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
 	*idlest_bit = clk->enable_bit;
 }
 
+#else
+#define omap2430_clk_i2chs_find_idlest	NULL
+#endif
+
 /* 2430 I2CHS has non-standard IDLEST register */
 const struct clkops clkops_omap2430_i2chs_wait = {
 	.enable		= omap2_dflt_clk_enable,


