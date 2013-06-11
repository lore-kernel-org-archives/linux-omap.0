From: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Subject: Re: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Tue, 11 Jun 2013 10:42:58 +0300
Message-ID: <51B6D502.5010208@iki.fi>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com> <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com> <20130607162927.GA3331@atomide.com> <20130607175005.GB3331@atomide.com> <51B5ACA6.2010101@iki.fi> <20130610141451.GE8164@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2VLBFQDEEVUGCGFAPAQPV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:42558 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab3FKHnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jun 2013 03:43:10 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so6574210lab.19
        for <linux-omap@vger.kernel.org>; Tue, 11 Jun 2013 00:43:09 -0700 (PDT)
In-Reply-To: <20130610141451.GE8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, t-kristo@ti.com, ambresh@ti.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2VLBFQDEEVUGCGFAPAQPV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/06/13 17:14, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@iki.fi> [130610 03:44]:

>> DSS does not have DT bindings, and removing DSS from hwmod data will
>> break DSS for omap4.
>=20
> Ah that's right. Care to post a patch reverting the minimal parts that
> you need for omap4 against omap-for-v3.11/cleanup?

This one adds back the DSS data.

 Tomi


=46rom e23a18fe14cbfebf9b08e3004aec92e05a86a117 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Jun 2013 10:37:19 +0300
Subject: [PATCH] ARM: OMAP4: hwmod data: add DSS data back

Commit 3b9b10151c6838af52244cec4af41a938bb5b7ec (ARM: OMAP4: hwmod data:
Clean up the data file) removes hwmod data for omap4, including DSS
data. DSS has not yet been converted to DT, so the hwmod data is still
needed.

This patch adds back the DSS parts of the hwmod data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 54 ++++++++++++++++++++++++=
++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_44xx_data.c
index 5f5d631..c8d4957 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -619,6 +619,16 @@ static struct omap_hwmod_class omap44xx_dispc_hwmod_=
class =3D {
 };
=20
 /* dss_dispc */
+static struct omap_hwmod_irq_info omap44xx_dss_dispc_irqs[] =3D {
+	{ .irq =3D 25 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_dss_dispc_sdma_reqs[] =3D {
+	{ .dma_req =3D 5 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req =3D -1 }
+};
+
 static struct omap_dss_dispc_dev_attr omap44xx_dss_dispc_dev_attr =3D {
 	.manager_count		=3D 3,
 	.has_framedonetv_irq	=3D 1
@@ -628,6 +638,8 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod =3D=
 {
 	.name		=3D "dss_dispc",
 	.class		=3D &omap44xx_dispc_hwmod_class,
 	.clkdm_name	=3D "l3_dss_clkdm",
+	.mpu_irqs	=3D omap44xx_dss_dispc_irqs,
+	.sdma_reqs	=3D omap44xx_dss_dispc_sdma_reqs,
 	.main_clk	=3D "dss_dss_clk",
 	.prcm =3D {
 		.omap4 =3D {
@@ -660,6 +672,16 @@ static struct omap_hwmod_class omap44xx_dsi_hwmod_cl=
ass =3D {
 };
=20
 /* dss_dsi1 */
+static struct omap_hwmod_irq_info omap44xx_dss_dsi1_irqs[] =3D {
+	{ .irq =3D 53 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_dss_dsi1_sdma_reqs[] =3D {
+	{ .dma_req =3D 74 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req =3D -1 }
+};
+
 static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] =3D {
 	{ .role =3D "sys_clk", .clk =3D "dss_sys_clk" },
 };
@@ -668,6 +690,8 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod =3D =
{
 	.name		=3D "dss_dsi1",
 	.class		=3D &omap44xx_dsi_hwmod_class,
 	.clkdm_name	=3D "l3_dss_clkdm",
+	.mpu_irqs	=3D omap44xx_dss_dsi1_irqs,
+	.sdma_reqs	=3D omap44xx_dss_dsi1_sdma_reqs,
 	.main_clk	=3D "dss_dss_clk",
 	.prcm =3D {
 		.omap4 =3D {
@@ -680,6 +704,16 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod =3D=
 {
 };
=20
 /* dss_dsi2 */
+static struct omap_hwmod_irq_info omap44xx_dss_dsi2_irqs[] =3D {
+	{ .irq =3D 84 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_dss_dsi2_sdma_reqs[] =3D {
+	{ .dma_req =3D 83 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req =3D -1 }
+};
+
 static struct omap_hwmod_opt_clk dss_dsi2_opt_clks[] =3D {
 	{ .role =3D "sys_clk", .clk =3D "dss_sys_clk" },
 };
@@ -688,6 +722,8 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod =3D =
{
 	.name		=3D "dss_dsi2",
 	.class		=3D &omap44xx_dsi_hwmod_class,
 	.clkdm_name	=3D "l3_dss_clkdm",
+	.mpu_irqs	=3D omap44xx_dss_dsi2_irqs,
+	.sdma_reqs	=3D omap44xx_dss_dsi2_sdma_reqs,
 	.main_clk	=3D "dss_dss_clk",
 	.prcm =3D {
 		.omap4 =3D {
@@ -720,6 +756,16 @@ static struct omap_hwmod_class omap44xx_hdmi_hwmod_c=
lass =3D {
 };
=20
 /* dss_hdmi */
+static struct omap_hwmod_irq_info omap44xx_dss_hdmi_irqs[] =3D {
+	{ .irq =3D 101 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_dss_hdmi_sdma_reqs[] =3D {
+	{ .dma_req =3D 75 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req =3D -1 }
+};
+
 static struct omap_hwmod_opt_clk dss_hdmi_opt_clks[] =3D {
 	{ .role =3D "sys_clk", .clk =3D "dss_sys_clk" },
 };
@@ -733,6 +779,8 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod =3D =
{
 	 * set idle mode by software.
 	 */
 	.flags		=3D HWMOD_SWSUP_SIDLE,
+	.mpu_irqs	=3D omap44xx_dss_hdmi_irqs,
+	.sdma_reqs	=3D omap44xx_dss_hdmi_sdma_reqs,
 	.main_clk	=3D "dss_48mhz_clk",
 	.prcm =3D {
 		.omap4 =3D {
@@ -765,6 +813,11 @@ static struct omap_hwmod_class omap44xx_rfbi_hwmod_c=
lass =3D {
 };
=20
 /* dss_rfbi */
+static struct omap_hwmod_dma_info omap44xx_dss_rfbi_sdma_reqs[] =3D {
+	{ .dma_req =3D 13 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req =3D -1 }
+};
+
 static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] =3D {
 	{ .role =3D "ick", .clk =3D "dss_fck" },
 };
@@ -773,6 +826,7 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod =3D =
{
 	.name		=3D "dss_rfbi",
 	.class		=3D &omap44xx_rfbi_hwmod_class,
 	.clkdm_name	=3D "l3_dss_clkdm",
+	.sdma_reqs	=3D omap44xx_dss_rfbi_sdma_reqs,
 	.main_clk	=3D "dss_dss_clk",
 	.prcm =3D {
 		.omap4 =3D {
--=20
1.8.1.2




------enig2VLBFQDEEVUGCGFAPAQPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRttUIAAoJEPo9qoy8lh71d+YP/jSNMdJ3UliE5NZ6HeU7jzN4
ItnsoC1rJbI5GjTF+ohCj9Mwp5KQtJM1Ta588V1Sc1jlNvVDbcXXmaknzAbkt5Qu
SAQzOh+2gRhELq9J8s2AJ3Mgol4m+UHJl0lT+nl6eBMs1GpZLwp0BXYmJw0xLD1z
Lr/MvP4UEy+VhvROv8Je6gkXMXYV7JPsnrxQjV5tmW28WNYNQWB43lpUeTVkaS2n
rpUIb0fQ8x+S3gouktQu6WzClkCAHvoUGeMpb2u0r9eSqqOVtkH9zkaNNU7pbmL1
iNWdPfCkvl2ANZanERsvgfsT1HpxFomVkdfY1hGldxacEGhF3woFk8ShWvcI0FZi
XvRjxrBHK01CERD4DVJi4CmV30fwpxZKC6Vb+zxcDpod8zS9Niql/5+AC2QrIN7X
80BS7iRidCvd71y/yQcrpiVLyzvOAWZq6tDXwFU9wODKzudHpD33yr7C+shRZXcS
oZKYxOE4XMr/hiAH/nIO2ou5fU9tuwIZII4aqmdwh1xM/jJKhKwtbtjTmO6/cD5M
NiEBwG1SGilW5jo8CN12iG8xwPh3zaX3CmXQDSVyvQV1MFTnXLFPzcpwEy/5Xioa
Z+5QXwaarkhdCQ8xHs8x4PuYE9p1wybODIKT1y8Jha3+9OZwnOenxCm+9qudhgtG
2h0+iZEKQYuZRAyl2Qli
=tEKn
-----END PGP SIGNATURE-----

------enig2VLBFQDEEVUGCGFAPAQPV--
