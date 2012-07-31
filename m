From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: DISPC: Improve DIGIT channel sync signal
 selection
Date: Tue, 31 Jul 2012 08:46:11 +0300
Message-ID: <1343713571.4685.6.camel@lappyti>
References: <1343693484-26133-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-JjQyCJ9ZPgdEfHL1cokx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:49721 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751838Ab2GaFqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 01:46:15 -0400
Received: by lbbgo11 with SMTP id go11so5117987lbb.17
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 22:46:13 -0700 (PDT)
In-Reply-To: <1343693484-26133-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org


--=-JjQyCJ9ZPgdEfHL1cokx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-07-30 at 19:11 -0500, Ricardo Neri wrote:
> DSS code wrongly assumes that VENC is always available as source for the =
external
> sync signal for the display controller DIGIT channel. One cannot blindly
> rely only on the value of DSS_CONTROL[15] as on certain processors (e.g.,=
 OMAP5)
> reading/writing on that bit may not be valid. If the the sync source is n=
ot read
> correctly, the callers of dss_get_hdmi_venc_clk_source might make wrong a=
ssumptions
> about, for instance, video timings.
>=20
> This patch adds logic to correctly get the sync signal based on the
> available displays in the DIGIT channel. A kernel BUG is thrown if an
> invalid source is selected.
>=20
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
> v2: use BUG_ON() to simplify handling of invalid cases.
>  drivers/video/omap2/dss/dss.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.=
c
> index 04b4586..2f8e4b6 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -648,9 +648,15 @@ void dss_set_dac_pwrdn_bgz(bool enable)
>  	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
>  }
> =20
> -void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_selec=
t hdmi)
> +void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_selec=
t src)
>  {
> -	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
> +	enum omap_display_type dp;
> +	dp =3D dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);
> +
> +	BUG_ON((src =3D=3D DSS_VENC_TV_CLK) && !(dp & OMAP_DISPLAY_TYPE_VENC));
> +	BUG_ON((src =3D=3D DSS_HDMI_M_PCLK) && !(dp & OMAP_DISPLAY_TYPE_HDMI));
> +
> +	REG_FLD_MOD(DSS_CONTROL, src, 15, 15);	/* VENC_HDMI_SWITCH */
>  }

This one will still write to the reserved bit 15 on OMAP5.

Perhaps we could check if both VENC and HDMI are supported, and if not,
return.

 Tomi


--=-JjQyCJ9ZPgdEfHL1cokx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQF3EjAAoJEPo9qoy8lh71bfUP/1ch57z71XD59qjZpC92CToQ
YA7q1lu05K9M2J/6DxXpIXJO9Q/XZJENOTOwPZ8VRkOhPB9Y/Iewby1cjrkByWOM
yugTiK3qnMz3lNDmhH2FEMnN8MDFy4OrcMF20BAyVCY+bQB3gAwadVUTXOoUmDpJ
bJvQnb5iKu4CA1uPuXYJx33oZEZ+0NxYOmenVh6tlo2ri47LYg2zxkr4c3pPdVb2
iZgpWa52x7ebjcMIR6ljL8mV1Rq312bOXQ/rQRSyE0u6cs4HlTQQgTJ15ZBUJgSa
//rPqkdZjnl85HKltLvVnkUrIn1xlnK6uwg3wtBzdMbeoz2hzNS9gEn+RRNhqX0L
d7VLfA8lRoKYrs475R1bvntiLMGZKYvdbMRXHLQdKu+FaYX0NRvZPW8xOXaR3Hac
u3CVQyE3ay43i8LuKwxpYxYowA29RYlpCAyTcdyEYQCpaLov0O3p2b+2jDojbNlO
LGM6ou1NLvJhtAoxHY6lrbf+OvsfOtRtfjxUX1jfY23wcX6VXaeWyvG0yiZIEEgd
+9C5YWCJKMoF3hesVkhwacLFdlIHyaFAD49OpuJ3AtnfUAsS0QxFe+gLtsqnPm8j
CsHiXXeeJCZZPPQ4QtvNJYRRf0A4uxqCp9aTyY01fGT769R2DJZlh+vTt+jcPbXg
S2Wa/5yFN2+5/rcMF7mD
=b2VL
-----END PGP SIGNATURE-----

--=-JjQyCJ9ZPgdEfHL1cokx--

