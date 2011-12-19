From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] ASoC: OMAP: HDMI: Move HDMI codec trigger function
 to generic HDMI driver
Date: Mon, 19 Dec 2011 10:12:36 +0200
Message-ID: <1324282356.1903.25.camel@deskari>
References: <1324018993-31466-1-git-send-email-ricardo.neri@ti.com>
	 <1324018993-31466-5-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fWd2yoB65Ft/k/z3c1D/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:59017 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752117Ab1LSIMm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 03:12:42 -0500
Received: by lago2 with SMTP id o2so1943330lag.10
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 00:12:39 -0800 (PST)
In-Reply-To: <1324018993-31466-5-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com


--=-fWd2yoB65Ft/k/z3c1D/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

On Fri, 2011-12-16 at 01:03 -0600, Ricardo Neri wrote:
> The function hdmi_audio_trigger is a callback used by ASoC to stop/start
> HDMI audio. Also, it does not perform IP-specific configuration directly.
> Hence, it should be placed in the general portion of the HDMI driver,
> along with the other ASoC callbacks.
>=20
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c            |   31 +++++++++++++++++++++++=
+++++
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   32 -----------------------=
------
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    2 -
>  3 files changed, 31 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index a0e254e..5c93041 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -554,6 +554,37 @@ void omapdss_hdmi_display_disable(struct omap_dss_de=
vice *dssdev)
>  #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
>  	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> =20
> +int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
> +				struct snd_soc_dai *dai)

This should be static. Otherwise the patch set looks fine to me.

 Tomi


--=-fWd2yoB65Ft/k/z3c1D/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO7vH0AAoJEPo9qoy8lh71gqcQAJkZNHrDamDEWywEMJdPxuvr
C8F35vvoekaYemeaeQ9zScOawQXz3jC45njGjouHoK4dmXzIi2UhpvlLA6cWS0vb
Zo40eZteO9AcdK6R3N58e3J5GHcx2VrA1oeutA8ieU2MvE/SEp7P8jGRfR16keOD
RTOG2fsCcBySftV0mdMiozSul3InYZJvmEIzVgdBD7C7doOH9+EY/NyFIlEdaqGJ
zG2JCKG/2gTU9xu8KKwI1cpT0+olIfuJ9V6iZuhL4XztihxyhSYnJvzv6TauFrSe
B0sWEZ8q2pKJY7smCHXagSPG5pNST66eGNwHRHhhBfTKJZaVK3+2+viuAB9oIObN
QFunfYPTI7GFi1ASrtrEkUpUCk78rDWgGARkQM/s2ir730lFtQ86huqCnkF4tgI+
Ok+6MqD3W/ShWIIYx5W0DvwCJhAGAkgUuMYFXlhl5Pn++uRPpX18ajzvrWr6F4iP
SwcT87pgf0kg4wgfK14mfdVBIpK6H9P8ED5F1IDA0QYsKktneQmlf1mxY1YD3X8v
ZUDpaOPkcwIuCpWRneY3PZYV9NUQM9Xka5uOdC73bI5Wv0WylA8qhZvPXevTvYxP
flmeEFIHtTKau9gQPGp/ZEW48Av7N26CHuX9twd8Pgm2aE/depxSfPtgG9y79loA
LqyXtCW7jKYF5pQ73JmN
=Gnja
-----END PGP SIGNATURE-----

--=-fWd2yoB65Ft/k/z3c1D/--

