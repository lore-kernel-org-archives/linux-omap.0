From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/12] ARM: OMAP2xxx: powerdomain: add previous power state
 tracking
Date: Sun, 09 Dec 2012 13:03:31 -0700
Message-ID: <20121209200330.3196.10124.stgit@dusk.lan>
References: <20121209200108.3196.12452.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40214 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758920Ab2LIUFL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 15:05:11 -0500
In-Reply-To: <20121209200108.3196.12452.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The OMAP2xxx PRM does support a form of powerdomain previous-power-state
tracking; so add it.  This allows the power state tracking and debugging
code to do something useful on this platform.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm2xxx.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index e4cdb69..2d3c905 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -180,10 +180,22 @@ static int omap2xxx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 	return omap2xxx_pwrst_to_common_pwrst(omap2xxx_pwrst);
 }
 
+static int omap2xxx_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
+{
+	u8 omap2xxx_pwrst;
+
+	omap2xxx_pwrst = omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+						       OMAP2_PM_PWSTST,
+						       OMAP24XX_LASTSTATEENTERED_MASK);
+
+	return omap2xxx_pwrst_to_common_pwrst(omap2xxx_pwrst);
+}
+
 struct pwrdm_ops omap2_pwrdm_operations = {
 	.pwrdm_set_next_pwrst	= omap2xxx_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst	= omap2xxx_pwrdm_read_next_pwrst,
 	.pwrdm_read_pwrst	= omap2xxx_pwrdm_read_pwrst,
+	.pwrdm_read_prev_pwrst	= omap2xxx_pwrdm_read_prev_pwrst,
 	.pwrdm_set_logic_retst	= omap2_pwrdm_set_logic_retst,
 	.pwrdm_set_mem_onst	= omap2_pwrdm_set_mem_onst,
 	.pwrdm_set_mem_retst	= omap2_pwrdm_set_mem_retst,


