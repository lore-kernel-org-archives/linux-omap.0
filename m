From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/10] OMAPDSS: HDMI: Implement DSS driver interface
 for audio
Date: Mon, 23 Apr 2012 16:01:56 +0300
Message-ID: <1335186116.1535.23.camel@lappy>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
	 <1332974305-4578-11-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-gEY3Rq18seZs8zsIZ6GL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:42002 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752526Ab2DWNCE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 09:02:04 -0400
Received: by lagw12 with SMTP id w12so11481323lag.34
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 06:02:01 -0700 (PDT)
In-Reply-To: <1332974305-4578-11-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org


--=-gEY3Rq18seZs8zsIZ6GL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-28 at 16:38 -0600, Ricardo Neri wrote:
> Implement the DSS device driver audio support interface in the HDMI
> panel driver and generic driver. The implementation relies on the
> IP-specific functions that are defined at DSS probe time.
>=20
> A HW-safe spinlock is used to protect the audio functions. This is becaus=
e

What is a "HW-safe spinlock"?

> the audio functions may be called while holding a lock; in such case,
> the panel's driver mutex is not suitable. Functions should be used
> to set registers and should not wait for any other event.

Are you sure this is the only option? What lock is being held? While a
spinlock may be ok for now, quite often enabling/disabling things do not
happen immediately, and it's much easier to do the wait synchronously.

> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  drivers/video/omap2/dss/dss.h        |    7 +++
>  drivers/video/omap2/dss/hdmi.c       |   33 +++++++++++++++
>  drivers/video/omap2/dss/hdmi_panel.c |   76 ++++++++++++++++++++++++++++=
++++++
>  3 files changed, 116 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.=
h
> index 32ff69f..fca4490 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -520,6 +520,13 @@ int omapdss_hdmi_read_edid(u8 *buf, int len);
>  bool omapdss_hdmi_detect(void);
>  int hdmi_panel_init(void);
>  void hdmi_panel_exit(void);
> +#ifdef CONFIG_OMAP4_DSS_HDMI_AUDIO
> +int hdmi_audio_enable(bool enable);
> +int hdmi_audio_start(bool start);
> +bool hdmi_mode_has_audio(void);
> +int hdmi_audio_config(struct snd_aes_iec958 *iec,
> +		struct snd_cea_861_aud_if *aud_if);
> +#endif
> =20
>  /* RFBI */
>  #ifdef CONFIG_OMAP2_DSS_RFBI
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index bd44891..880509d 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -698,6 +698,39 @@ int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *c=
ts)
> =20
>  	return 0;
>  }
> +
> +int hdmi_audio_enable(bool enable)
> +{
> +	DSSDBG("audio_enable\n");
> +
> +	hdmi.ip_data.ops->audio_enable(&hdmi.ip_data, enable);

Shouldn't this, and the others below, return the value from the called
function, instead of always returning 0?

> +
> +	return 0;
> +}
> +
> +int hdmi_audio_start(bool start)
> +{
> +	DSSDBG("audio_enable\n");
> +
> +	hdmi.ip_data.ops->audio_start(&hdmi.ip_data, start);
> +
> +	return 0;
> +}
> +
> +bool hdmi_mode_has_audio(void)
> +{
> +	if (hdmi.ip_data.cfg.cm.mode =3D=3D HDMI_HDMI)
> +		return true;
> +	else
> +		return false;
> +}
> +
> +int hdmi_audio_config(struct snd_aes_iec958 *iec,
> +		struct snd_cea_861_aud_if *aud_if)
> +{
> +	return hdmi.ip_data.ops->audio_config(&hdmi.ip_data, iec, aud_if);
> +}
> +
>  #endif
> =20
>  /* HDMI HW IP initialisation */
> diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/d=
ss/hdmi_panel.c
> index 533d5dc..dac1ac2 100644
> --- a/drivers/video/omap2/dss/hdmi_panel.c
> +++ b/drivers/video/omap2/dss/hdmi_panel.c
> @@ -31,6 +31,10 @@
> =20
>  static struct {
>  	struct mutex hdmi_lock;
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
> +	/* protects calls to HDMI driver audio functionality */
> +	spinlock_t hdmi_sp_lock;

What does "sp" stand for? Spinlock? Perhaps a better name would be
"audio_lock", if it's audio specific. And probably no reason to prefix
it with "hdmi", as it's inside "hdmi" struct already.

 Tomi


--=-gEY3Rq18seZs8zsIZ6GL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPlVLEAAoJEPo9qoy8lh71O1kP/RBOBHu0cDPE3TN6ucjh0tg4
dLp1eAvgPgw/H+zdnyqvQaN9yjxf4eIjsdFKLRehPuqAzQOSwmupJqasq5Gam53C
I64Ly+RV+M4rkURz4KKyEkjoSyWwu5tNc99SQ62e36ZgkSfAopITYQzSRKgrD49j
xuRWg3zvBB76b+aBSYXweoREWvPAbUxriBH1IRLFbf9HeR8B9XS5/o3UyEZBS1/D
ImF1MN+ACUVMlYWqi6bgg9jkYj0GGhgQ3rdl6gMqFL+bM392kOC/hOTO+N/qhosU
kuebiWNQO/Oa+rKDP5kRp0iv7GpD90KsGnK1bl3phRyNUIXCrQ77niIEDzaEmjOg
IvMzl1Vmr0fSDHn2hzahl9HlAPSudZYiE5dncAHfuyRzmZDJmNukf2eOh78W0I5Y
ivUVs0alhXZFsCH3yKQo8KLBl7kQgFp0lPCC+DFVK8fofYlTC344T17/rXf2yBVf
J7YKDaYQa+COESdOAKbuO3TvWpapc1YfZSFp7cNh+1lOpxYeDyuE96Nw0PPbKN0I
cvyqT91uTfEdPrkP2TtFIOmbLVKE4n6MbCGG27s/wrm6bEBsZliRNGvFLmFQJohU
763W+HLb7jBF16laP6/+kqhdZ/x0zGGRhsfMgHw+k5bYJ27Z/rz0dNuCseOZ+EOi
Rv4Zc+3XBtwQV0AR6zux
=TxnD
-----END PGP SIGNATURE-----

--=-gEY3Rq18seZs8zsIZ6GL--

