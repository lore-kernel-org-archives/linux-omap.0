From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 5/7 v2] OMAP3: clocks: Update clock domain name for mcspi
     fck
Date: Wed, 1 Dec 2010 19:31:51 +0530 (IST)
Message-ID: <33288.10.24.255.18.1291212111.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44578 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975Ab0LAOCC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 09:02:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Update clock3xxx_data for mcspi1-4 with appropriate clock domain name.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d85ecd5..5c02baa 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1558,6 +1558,7 @@ static struct clk mcspi4_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk mcspi3_fck = {
@@ -1567,6 +1568,7 @@ static struct clk mcspi3_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk mcspi2_fck = {
@@ -1576,6 +1578,7 @@ static struct clk mcspi2_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk mcspi1_fck = {
@@ -1585,6 +1588,7 @@ static struct clk mcspi1_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
 	.recalc		= &followparent_recalc,
+	.clkdm_name	= "core_l4_clkdm",
 };

 static struct clk uart2_fck = {
-- 
1.7.1


