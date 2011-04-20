From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] OMAP4: clock data: Change DSS clock aliases
Date: Wed, 20 Apr 2011 13:28:41 -0600
Message-ID: <20110420192839.16986.17445.stgit@twilight.localdomain>
References: <20110420192601.16986.56558.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49008 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab1DTTpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Apr 2011 15:45:44 -0400
In-Reply-To: <20110420192601.16986.56558.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Tomi Valkeinen <tomi.valkeinen@ti.com>

DSS driver has used fck and ick clocks on OMAP2/3 to get DSS HW up and
running, and also to get the pixel clock's source clock rate from the
fck.

On OMAP4 the clock data is set up in a different way, as there's no ick=
,
dss_fck points to a fake clock which just affects DSS's MODULEMODE, and
dss_dss_clk if the DSS_FCK.

>From DSS driver's point of view the dss_fck sounds like an ick, and
dss_dss_clk is the fck. While this is not entirely correct from HW poin=
t
of view, especially for the ick, configuring the clock aliases that way
makes DSS "just work" with OMAP4's clock setup.

In the (hopefully near) future DSS driver will be reworked to use
pm_runtime support which should clean up the clock code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2=
/clock44xx_data.c
index 276992d..8c96567 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3116,14 +3116,9 @@ static struct omap_clk omap44xx_clks[] =3D {
 	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
 	CLK("omapdss_dss",	"sys_clk",			&dss_sys_clk,	CK_443X),
 	CLK("omapdss_dss",	"tv_clk",			&dss_tv_clk,	CK_443X),
-	CLK("omapdss_dss",	"dss_clk",			&dss_dss_clk,	CK_443X),
 	CLK("omapdss_dss",	"video_clk",			&dss_48mhz_clk,	CK_443X),
-	CLK("omapdss_dss",	"fck",				&dss_fck,	CK_443X),
-	/*
-	 * On OMAP4, DSS ick is a dummy clock; this is needed for compatibili=
ty
-	 * with OMAP2/3.
-	 */
-	CLK("omapdss_dss",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omapdss_dss",	"fck",				&dss_dss_clk,	CK_443X),
+	CLK("omapdss_dss",	"ick",				&dss_fck,	CK_443X),
 	CLK(NULL,	"efuse_ctrl_cust_fck",		&efuse_ctrl_cust_fck,	CK_443X),
 	CLK(NULL,	"emif1_fck",			&emif1_fck,	CK_443X),
 	CLK(NULL,	"emif2_fck",			&emif2_fck,	CK_443X),


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
