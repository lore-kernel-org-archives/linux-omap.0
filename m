From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Provide interface for audio support in DSS
Date: Fri, 20 Apr 2012 15:03:56 +0300
Message-ID: <1334923436.1564.8.camel@lappy>
References: <1332971516-4325-1-git-send-email-ricardo.neri@ti.com>
	 <1332971516-4325-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2+lO/xiKURf+ZK5CB0ym"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:44544 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753488Ab2DTMEF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 08:04:05 -0400
Received: by lbdb5 with SMTP id b5so4523774lbd.26
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 05:04:01 -0700 (PDT)
In-Reply-To: <1332971516-4325-2-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: s-chereau@ti.com, x0055901@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org


--=-2+lO/xiKURf+ZK5CB0ym
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-28 at 15:51 -0600, Ricardo Neri wrote:
> There exist several display technologies and standards that support audio=
 as
> well. Hence, it is relevant to update the DSS device driver to provide an=
 audio
> interface that may be used by an audio or any other driver interested in =
the
> functionality.
>=20
> The DSS audio functions are intended to be used as follows:
>=20
> The audio_enable function is intended to prepare the relevant IP for play=
back
> (e.g., enabling an audio FIFO, taking out of reset some IP, etc).
>=20
> While the display may support audio, it is possible that for certain
> configurations audio is not supported (e.g., an HDMI display using a VESA=
 video
> timing). The audio_detect function is intended to query whether the curre=
nt
> configuration of the display supports audio.
>=20
> The audio_config function is intended to configure all the relevant audio
> parameters of the display. In order to make the function independent of a=
ny DSS
> device driver or IP, it takes an IEC-60958 channel status word struct as =
well
> as a CEA-861 audio infoframe struct. At the moment, this should be enough=
 to
> support HDMI and DisplayPort, as both are based on CEA-861 and IEC-60958.
>=20
> The audio_start function is intended to effectively start/stop audio play=
back
> after the configuration has taken place.
>=20
> Please note that asound.h is #included only to pass the relevant data
> structures to the DSS device driver. The DSS device driver should
> not link to any ALSA function as DSS and ALSA are built in separate modul=
es.
>=20
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  Documentation/arm/OMAP/DSS |   28 ++++++++++++++++++++++++++++
>  include/video/omapdss.h    |   12 ++++++++++++
>  2 files changed, 40 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
> index 888ae7b..b303a5c 100644
> --- a/Documentation/arm/OMAP/DSS
> +++ b/Documentation/arm/OMAP/DSS
> @@ -47,6 +47,34 @@ flexible way to enable non-common multi-display config=
uration. In addition to
>  modelling the hardware overlays, omapdss supports virtual overlays and o=
verlay
>  managers. These can be used when updating a display with CPU or system D=
MA.
> =20
> +omapdss driver support for audio
> +--------------------------------
> +There exist several display technologies and standards that support audi=
o as
> +well. Hence, it is relevant to update the DSS device driver to provide a=
n audio
> +interface that may be used by an audio or any other driver interested in=
 the
> +functionality.
> +
> +The audio_enable function is intended to prepare the relevant IP for pla=
yback
> +(e.g., enabling an audio FIFO, taking out of reset some IP, etc).
> +
> +While the display may support audio, it is possible that for certain
> +configurations audio is not supported (e.g., an HDMI display using a VES=
A video
> +timing). The audio_detect function is intended to query whether the curr=
ent
> +configuration of the display supports audio.
> +
> +The audio_config function is intended to configure all the relevant audi=
o
> +parameters of the display. In order to make the function independent of =
DSS
> +any device driver, it takes a IEC-60958 channel status word as well
> +as a CEA-861 audio infoframe. At the moment, this should be enough to su=
pport
> +HDMI and DisplayPort, as both are based on CEA-861 and IEC-60958.
> +
> +The audio_start function is intended to effectively start/stop audio pla=
yback
> +after the configuration has taken place.
> +
> +Please note that asound.h is #included only to pass the relevant data
> +structures to the DSS device driver. The DSS device driver should
> +not link to any ALSA function as DSS and ALSA are built in separate modu=
les.
> +
>  Panel and controller drivers
>  ----------------------------
> =20
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index 483f67c..e35ae96 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -21,6 +21,7 @@
>  #include <linux/list.h>
>  #include <linux/kobject.h>
>  #include <linux/device.h>
> +#include <sound/asound.h>

You don't need to include asound.h, you can just:

struct snd_aes_iec958;
struct snd_cea_861_aud_if;
=20
>  #define DISPC_IRQ_FRAMEDONE		(1 << 0)
>  #define DISPC_IRQ_VSYNC			(1 << 1)
> @@ -642,6 +643,17 @@ struct omap_dss_driver {
> =20
>  	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
>  	bool (*detect)(struct omap_dss_device *dssdev);
> +
> +	/*
> +	 * For display drivers that support audio. This encompasses
> +	 * HDMI and DisplayPort at the moment.
> +	 */
> +	int (*audio_enable)(struct omap_dss_device *dssdev, bool enable);
> +	int (*audio_start)(struct omap_dss_device *dssdev, bool start);
> +	bool (*audio_detect)(struct omap_dss_device *dssdev);
> +	int (*audio_config)(struct omap_dss_device *dssdev,
> +		struct snd_aes_iec958 *iec, struct snd_cea_861_aud_if *aud_if);

I can't say anything about the parameters for audio_config, so I trust
they are ok. But some comments about the functions:

I don't like foo_enable(bool enable) style functions. While it does
reduce the amount of code a bit, I think it's much less readable than
separate foo_enable() and foo_disable() functions.

audio_detect sounds a bit misleading to me... You're not detecting
anything, but asking if audio is supported. So... "audio_supported()" or
something?

Is there need for the audio_config function, or could the audio configs
be given with audio_start call?

 Tomi


--=-2+lO/xiKURf+ZK5CB0ym
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPkVCmAAoJEPo9qoy8lh71PxIP/0rryd65C7VinDm93lYo7HFm
yXeBQ0dSFWxLBHG7I6YuONtfV7PH9c07NHHSOpatYqv4DuV+oZMW0shjyanx/atQ
PSFA7DoLNKX3nYXuHgFFmpsgfi9kuI7wrhHfBmjU+kO/qIO83FH4EfT/jhSB9zwt
4pBO0kiu2/sr+BhVgd2SY+p+L5KQ13jiPCeMX827hBb044mZtAF0+YnbsxppUMxW
gjPfCzjQncQWCKRHCMlGzzN5PbxhMLdXC0v8wRDW/Uh+4yvwewI9ayzhqiS8s4sZ
oGGPDod4Hfdu6iIiyTvN4M8tGMB7+0w7CQpCWCv/qSh5qkLgcroNSuWTQSEK1rDS
u1Mouuv7nceTp4D8P9XS+7c7TLwdt1U77/x4bBIoLwR4nyntFTM0Sju777iyGOSp
iWNeH3oqor9E3MkGKsiA/jlOyMJYtxxEKXMN4J1mfO3l1bs2GLIwhoJ/QYqq7WKS
tTAiJcnGMFNdnZE0LcmOPAkLtGczfOBIC8XfeFf4MeFYjXKkZ8nQ9xcaeTJTdXwG
NNAHmW/1yxgspkpmTygoT8UEUtUDzLA5OMoAhQpnrf8wROFqi6AoN6uVh+716MCb
A134zPUWa+8WQGU4Pcr5/8TesbGTtpVfnkxXgu84jruXH4UE1+rhHSeyt9VBx6k1
jFF8JRoSNh7jJqA4VuCZ
=xTsX
-----END PGP SIGNATURE-----

--=-2+lO/xiKURf+ZK5CB0ym--

