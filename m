From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: [PATCH 4/5] am3505/3517: UART4 fclk
Date: Mon, 04 Jul 2011 15:34:51 -0400
Message-ID: <4E1215DB.6020601@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:41413 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab1GDTew (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jul 2011 15:34:52 -0400
Received: from raph.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1Qdoux-0001L7-MM
	for linux-omap@vger.kernel.org; Mon, 04 Jul 2011 15:34:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add support for the AM35xx UART4 fclk. Based on information
found on TI's E2E forum.

Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 75b119b..3706aaa 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3179,10 +3179,18 @@ static struct clk vpfe_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-/*
- * The UART1/2 functional clock acts as the functional
- * clock for UART4. No separate fclk control available.
- */
+/* Documented as 'reserved' in latest technical manual (July 2010), 
+ * bit 23 in CM_CLKEN1_CORE really seems to control the UART4 fclk.. */
+static struct clk uart4_fck_am35xx = {
+	.name		= "uart4_fck",
+	.ops		= &clkops_omap2_dflt,
+	.parent		= &core_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= AM35XX_EN_UART4_SHIFT,
+	.clkdm_name	= "core_l4_clkdm",
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk uart4_ick_am35xx = {
 	.name		= "uart4_ick",
 	.ops		= &clkops_omap2_iclk_dflt_wait,
@@ -3462,6 +3470,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("musb-am35x",	"fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
 	CLK(NULL,	"hecc_ck",	&hecc_ck,	CK_AM35XX),
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
+	CLK(NULL,	"uart4_fck",	&uart4_fck_am35xx,	CK_AM35XX),
 };
 
 
