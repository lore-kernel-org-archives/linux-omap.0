From: =?UTF-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>
Subject: Re: [PATCH v2] OMAPDSS: Do not require a VDDS_DSI regulator on am35xx
Date: Wed, 19 Sep 2012 15:53:14 -0400
Message-ID: <505A22AA.9080804@8d.com>
References: <20120815191627.GA22993@renkinjitsu.usine.8d.com> <1345545584.4085.49.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:45579 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab2ISTxT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 15:53:19 -0400
In-Reply-To: <1345545584.4085.49.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Tomi,

On 21/08/12 06:39 AM, Tomi Valkeinen wrote:
> Hi,
>=20
> On Wed, 2012-08-15 at 15:16 -0400, Raphael Assenat wrote:
>> On our AM3505 based board, dpi.c complains that there is no VDSS_DSI=
 regulator
>> and the framebuffer cannot be enabled. However, this check does not =
seem to
>> apply to AM3505/17 chips.
>>
>> Taking into account comments received after my first patch[1], I hav=
e added
>> entries to dss_features.c to support the am35xx soc. Then in dpi.c, =
instead
>> of using cpu_is_omap34xx() and soc_is_am35xx(), a call to dss_has_fe=
ature()
>> is used.
>>
>> [1] http://marc.info/?l=3Dlinux-fbdev&m=3D134272967203409&w=3D2
>>
>> Signed-off-by: Rapha=C3=ABl Ass=C3=A9nat <raph@8d.com>
>=20
> Chandrabhanu has posted a series that removes a bunch of cpu_is check=
s
> from omapdss. On of them is the use of VDDS_DSI in dpi.c.
>=20
> Can you wait until I've merged those patches to omapdss master branch
> (probably a few days), and then create a new patch that adds AM35xx t=
o
> dss_features?

Please find a new version of the patch below. Due to the above mentione=
d changes,=20
the patch now only touches dss_features.c.=20

Tested on am3505 only.

Diff based on git://gitorious.org/linux-omap-dss2/linux.git master.

--

On our AM3505 based board, dpi.c complains that there is no VDSS_DSI re=
gulator
and the framebuffer cannot be enabled. However, this check does not see=
m to
apply to AM3505/17 chips.

Taking into account comments received after my first patch[1], I have a=
dded
entries to dss_features.c to support the am35xx soc.

[1] http://marc.info/?l=3Dlinux-fbdev&m=3D134272967203409&w=3D2

Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/oma=
p2/dss/dss_features.c
index c26fc1f..90e2011 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -378,6 +378,25 @@ static const enum dss_feat_id omap3430_dss_feat_li=
st[] =3D {
 	FEAT_DPI_USES_VDDS_DSI,
 };
=20
+static const enum dss_feat_id am35xx_dss_feat_list[] =3D {
+	FEAT_LCDENABLEPOL,
+	FEAT_LCDENABLESIGNAL,
+	FEAT_PCKFREEENABLE,
+	FEAT_FUNCGATED,
+	FEAT_LINEBUFFERSPLIT,
+	FEAT_ROWREPEATENABLE,
+	FEAT_RESIZECONF,
+	FEAT_DSI_PLL_FREQSEL,
+	FEAT_DSI_REVERSE_TXCLKESC,
+	FEAT_VENC_REQUIRES_TV_DAC_CLK,
+	FEAT_CPR,
+	FEAT_PRELOAD,
+	FEAT_FIR_COEF_V,
+	FEAT_ALPHA_FIXED_ZORDER,
+	FEAT_FIFO_MERGE,
+	FEAT_OMAP3_DSI_FIFO_BUG,
+};
+
 static const enum dss_feat_id omap3630_dss_feat_list[] =3D {
 	FEAT_LCDENABLEPOL,
 	FEAT_LCDENABLESIGNAL,
@@ -490,6 +509,27 @@ static const struct omap_dss_features omap3430_dss=
_features =3D {
 	.burst_size_unit =3D 8,
 };
=20
+/* AM35xx DSS Features. This is basically OMAP3 DSS Features without=20
+   the vdds_dsi regulator. */
+static const struct omap_dss_features am35xx_dss_features =3D {
+	.reg_fields =3D omap3_dss_reg_fields,
+	.num_reg_fields =3D ARRAY_SIZE(omap3_dss_reg_fields),
+
+	.features =3D am35xx_dss_feat_list,
+	.num_features =3D ARRAY_SIZE(am35xx_dss_feat_list),
+
+	.num_mgrs =3D 2,
+	.num_ovls =3D 3,
+	.supported_displays =3D omap3430_dss_supported_displays,
+	.supported_color_modes =3D omap3_dss_supported_color_modes,
+	.overlay_caps =3D omap3430_dss_overlay_caps,
+	.clksrc_names =3D omap3_dss_clk_source_names,
+	.dss_params =3D omap3_dss_param_range,
+	.supported_rotation_types =3D OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
+	.buffer_size_unit =3D 1,
+	.burst_size_unit =3D 8,
+};
+
 static const struct omap_dss_features omap3630_dss_features =3D {
 	.reg_fields =3D omap3_dss_reg_fields,
 	.num_reg_fields =3D ARRAY_SIZE(omap3_dss_reg_fields),
@@ -697,8 +737,13 @@ void dss_features_init(void)
 		omap_current_dss_features =3D &omap2_dss_features;
 	else if (cpu_is_omap3630())
 		omap_current_dss_features =3D &omap3630_dss_features;
-	else if (cpu_is_omap34xx())
-		omap_current_dss_features =3D &omap3430_dss_features;
+	else if (cpu_is_omap34xx()) {
+		if (soc_is_am35xx()) {
+			omap_current_dss_features =3D &am35xx_dss_features;
+		} else {
+			omap_current_dss_features =3D &omap3430_dss_features;
+		}
+	}
 	else if (omap_rev() =3D=3D OMAP4430_REV_ES1_0)
 		omap_current_dss_features =3D &omap4430_es1_0_dss_features;
 	else if (omap_rev() =3D=3D OMAP4430_REV_ES2_0 ||
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
