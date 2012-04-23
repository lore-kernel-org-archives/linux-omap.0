From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/10] OMAPDSS: HDMI: Decouple HDMI audio from ASoC
Date: Mon, 23 Apr 2012 16:25:09 +0300
Message-ID: <1335187509.1535.37.camel@lappy>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
	 <1332974305-4578-6-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-hC4mZuRf8a7uK2w6DOy9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:53615 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752454Ab2DWNZR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 09:25:17 -0400
Received: by lagr15 with SMTP id r15so9493874lag.30
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 06:25:14 -0700 (PDT)
In-Reply-To: <1332974305-4578-6-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org


--=-hC4mZuRf8a7uK2w6DOy9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-28 at 16:38 -0600, Ricardo Neri wrote:
> Instead of having OMAPDSS HDMI audio functionality depending on the
> ASoC HDMI audio driver, use a new config option so that
> potential users, including ASoC,  may select if needed.
>=20
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  drivers/video/omap2/dss/Kconfig           |    4 ++++
>  drivers/video/omap2/dss/dss_features.c    |    3 +--
>  drivers/video/omap2/dss/ti_hdmi.h         |    6 ++----
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    3 +--
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    5 +----
>  5 files changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kc=
onfig
> index 7be7c06..b492001 100644
> --- a/drivers/video/omap2/dss/Kconfig
> +++ b/drivers/video/omap2/dss/Kconfig
> @@ -68,6 +68,10 @@ config OMAP4_DSS_HDMI
>  	  HDMI Interface. This adds the High Definition Multimedia Interface.
>  	  See http://www.hdmi.org/ for HDMI specification.
> =20
> +config OMAP4_DSS_HDMI_AUDIO
> +	bool
> +	depends on OMAP4_DSS_HDMI
> +
>  config OMAP2_DSS_SDI
>  	bool "SDI support"
>  	depends on ARCH_OMAP3
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2=
/dss/dss_features.c
> index c1839e2..399a28a 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -497,8 +497,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functio=
ns =3D {
>  	.dump_core		=3D	ti_hdmi_4xxx_core_dump,
>  	.dump_pll		=3D	ti_hdmi_4xxx_pll_dump,
>  	.dump_phy		=3D	ti_hdmi_4xxx_phy_dump,
> -#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
> -	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>  	.audio_enable		=3D       ti_hdmi_4xxx_wp_audio_enable,
>  	.audio_start		=3D       ti_hdmi_4xxx_audio_start,
>  #endif
> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/=
ti_hdmi.h
> index 529e227..211da6f 100644
> --- a/drivers/video/omap2/dss/ti_hdmi.h
> +++ b/drivers/video/omap2/dss/ti_hdmi.h
> @@ -110,8 +110,7 @@ struct ti_hdmi_ip_ops {
> =20
>  	void (*dump_phy)(struct hdmi_ip_data *ip_data, struct seq_file *s);
> =20
> -#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
> -	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>  	void (*audio_enable)(struct hdmi_ip_data *ip_data, bool start);
> =20
>  	void (*audio_start)(struct hdmi_ip_data *ip_data, bool start);
> @@ -145,8 +144,7 @@ void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_dat=
a, struct seq_file *s);
>  void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file=
 *s);
>  void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_fil=
e *s);
>  void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file=
 *s);
> -#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
> -	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>  void ti_hdmi_4xxx_wp_audio_enable(struct hdmi_ip_data *ip_data, bool ena=
ble);
>  void ti_hdmi_4xxx_audio_start(struct hdmi_ip_data *ip_data, bool enable)=
;
>  #endif
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.c
> index e6fa61d..e06139a 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> @@ -1030,8 +1030,7 @@ void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_=
data, struct seq_file *s)
>  	DUMPPHY(HDMI_TXPHY_PAD_CFG_CTRL);
>  }
> =20
> -#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
> -	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>  void hdmi_wp_audio_config_format(struct hdmi_ip_data *ip_data,
>  					struct hdmi_audio_format *aud_fmt)
>  {
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.h
> index 9fa5cb1..222cc16 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
> @@ -26,8 +26,6 @@
>  #include "ti_hdmi.h"
>  #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
>  	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> -#include <sound/soc.h>
> -#include <sound/pcm_params.h>

Unrelated change. And... is there something wrong with this? Shouldn't
the defines above be changed?

 Tomi


--=-hC4mZuRf8a7uK2w6DOy9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAABAgAGBQJPlVg1AAoJEPo9qoy8lh71JV0P+L2lQGNo4VIb1+QOokt/pZfz
lZKFOQgME1RKGT4uMwbnBv92I2Cb2XKGD3EI94bbNy8YSWX1uv7Ru4kEVm0RadSQ
nRUB364lBBA12roqmvlMPdYZ9CTTEl4T8bJoWekxmb67/sWBgVwo5YB7V2MDyOKr
UinVtaNc2rbalGArBviHjhJIQ9jX1Qm+t11I2AZthHD+aGG43T8CoP9Z4t4oqF4T
MPQ1fSpZawGq8crEHctq+JbMhvAknC1/hTt/RG6eV7uVj4DGt89GUGGXWqHQ8iag
iEhfwAsTE2/ABSrxx+Lt9SVdpiIzgSC+5ZDMtJlpkYIIKnDleA3JA2zjGrbsWdjJ
rYJ769uvQP35A7SEcONfOiVBHobJUMPgK//wFtCkaU0NCdooZS0JREiWbjoRpyxl
jOdFAfBTjQlJ23jDvpUNHXRo2C6CXIDFDwgKj/xCWw8aXp3D+H0Z+tugYy5L8hTl
QvpFAJZ0gmJTeNq9xZBWkQPY5ntvgcba+nbDgI5VAtVHJPzXhS10QLVrhoaeR1gf
EJtCFhyZYMOx6tmr+3vMiCHWkr0aMMIxlcrw1ny4lCypnY1/xMRVK+58BG3bvyMi
+befC1njykwS/Na3cS9lFqrSx7epVm3XhFFCR+7z7C8cH/WMRELdp+GaZ9CS1txN
NbB6oxM0UrspnLn9pIw=
=8r87
-----END PGP SIGNATURE-----

--=-hC4mZuRf8a7uK2w6DOy9--

