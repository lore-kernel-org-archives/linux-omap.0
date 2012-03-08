From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/12] ARM: OMAP3: hwmod data: add IVA hard reset lines,
 main clock, clockdomain
Date: Wed, 07 Mar 2012 19:38:40 -0700
Message-ID: <20120308023839.8205.19425.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45810 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab2CHCmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 21:42:11 -0500
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The IVA hwmod data is missing some fields that cause the following
warning on boot:

[    0.118011] omap_hwmod: iva: cannot be enabled for reset (3)

Fix by encoding the IP block's main functional clock, reset lines, and
clockdomain.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c05a445..1bf1888 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -98,9 +98,19 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 };
 
 /* IVA2 (IVA2) */
+static struct omap_hwmod_rst_info omap3xxx_iva_resets[] = {
+	{ .name = "logic", .rst_shift = 0 },
+	{ .name = "seq0", .rst_shift = 1 },
+	{ .name = "seq1", .rst_shift = 2 },
+};
+
 static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.name		= "iva",
 	.class		= &iva_hwmod_class,
+	.clkdm_name	= "iva2_clkdm",
+	.rst_lines	= omap3xxx_iva_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_iva_resets),
+	.main_clk	= "iva2_ck",
 };
 
 /* timer class */


