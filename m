From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 09/12] ARM: OMAP4: hwmod data: temporarily comment out data for the sl2if IP block
Date: Thu, 19 Jul 2012 16:26:29 +0300
Message-ID: <1342704392-23657-10-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58913 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab2GSN10 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 09:27:26 -0400
In-Reply-To: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, nm@ti.com, paul@pwsan.com, khilman@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>

The OMAP4 sl2if IP block requires some special programming for it to
enter idle. Without this programming, they will prevent the rest of
the chip from entering full chip idle.

This patch comments out the IP block data.

Later, once the appropriate support is available, this patch can be
reverted.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index ad7df4e..8b60377 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4266,7 +4266,7 @@ static struct omap_hwmod_ocp_if omap44xx_dsp__iva=
 =3D {
 };
=20
 /* dsp -> sl2if */
-static struct omap_hwmod_ocp_if omap44xx_dsp__sl2if =3D {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_dsp__sl2if =3D=
 {
 	.master		=3D &omap44xx_dsp_hwmod,
 	.slave		=3D &omap44xx_sl2if_hwmod,
 	.clk		=3D "dpll_iva_m5x2_ck",
@@ -4884,7 +4884,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_=
2__iss =3D {
 };
=20
 /* iva -> sl2if */
-static struct omap_hwmod_ocp_if omap44xx_iva__sl2if =3D {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_iva__sl2if =3D=
 {
 	.master		=3D &omap44xx_iva_hwmod,
 	.slave		=3D &omap44xx_sl2if_hwmod,
 	.clk		=3D "dpll_iva_m5x2_ck",
@@ -5418,7 +5418,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup_=
_scrm =3D {
 };
=20
 /* l3_main_2 -> sl2if */
-static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sl2if =3D {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l3_main_2__sl2=
if =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
 	.slave		=3D &omap44xx_sl2if_hwmod,
 	.clk		=3D "l3_div_ck",
@@ -6088,7 +6088,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_abe__dmic,
 	&omap44xx_l4_abe__dmic_dma,
 	&omap44xx_dsp__iva,
-	&omap44xx_dsp__sl2if,
+	/* &omap44xx_dsp__sl2if, */
 	&omap44xx_l4_cfg__dsp,
 	&omap44xx_l3_main_2__dss,
 	&omap44xx_l4_per__dss,
@@ -6124,7 +6124,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__i2c4,
 	&omap44xx_l3_main_2__ipu,
 	&omap44xx_l3_main_2__iss,
-	&omap44xx_iva__sl2if,
+	/* &omap44xx_iva__sl2if, */
 	&omap44xx_l3_main_2__iva,
 	&omap44xx_l4_wkup__kbd,
 	&omap44xx_l4_cfg__mailbox,
@@ -6155,7 +6155,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_cfg__cm_core,
 	&omap44xx_l4_wkup__prm,
 	&omap44xx_l4_wkup__scrm,
-	&omap44xx_l3_main_2__sl2if,
+	/* &omap44xx_l3_main_2__sl2if, */
 	&omap44xx_l4_abe__slimbus1,
 	&omap44xx_l4_abe__slimbus1_dma,
 	&omap44xx_l4_per__slimbus2,
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
