From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 7/7] OMAPDSS: HDMI: Create platform device for audio
 support
Date: Mon, 5 Nov 2012 10:46:15 +0200
Message-ID: <50977CD7.7070609@ti.com>
References: <1351902708-866-1-git-send-email-ricardo.neri@ti.com> <1351902708-866-8-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig58AB4E84FF5F525057283E07"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43689 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753339Ab2KEIqS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 03:46:18 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA58kIOv022552
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 02:46:18 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA58kISU018979
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 02:46:18 -0600
In-Reply-To: <1351902708-866-8-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

--------------enig58AB4E84FF5F525057283E07
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-03 02:31, Ricardo Neri wrote:
> Creating the accessory devices, such as audio, from the HDMI driver
> allows to regard HDMI as a single entity with audio an display
> functionality. This intends to follow the design of drivers such
> as MFD, in which a single entity handles the creation of the accessory
> devices. Such devices are then used by domain-specific drivers; audio i=
n
> this case.
>=20
> Also, this is in line with the DT implementation of HDMI, in which we w=
ill
> have a single node to describe this feature of the OMAP SoC.
>=20
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |   62 ++++++++++++++++++++++++++++++++=
++++++++
>  1 files changed, 62 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/h=
dmi.c
> index 4adf830..d6ce4c6 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -60,6 +60,9 @@
>  static struct {
>  	struct mutex lock;
>  	struct platform_device *pdev;
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
> +	struct platform_device *audio_pdev;
> +#endif
> =20
>  	struct hdmi_ip_data ip_data;
> =20
> @@ -766,6 +769,54 @@ static void hdmi_put_clocks(void)
>  }
> =20
>  #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
> +static int hdmi_probe_audio(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	u32 port_offset, port_size;
> +	struct resource aud_res[2] =3D {
> +		DEFINE_RES_MEM(-1, -1),
> +		DEFINE_RES_DMA(-1),
> +	};
> +
> +	hdmi.audio_pdev =3D ERR_PTR(-EINVAL);

I don't like this. I think ERR_PTR stuff should be used only for return
values, not when storing pointers. I think it's much more natural and
less error prone to do if (hdmi.audio_pdev =3D=3D NULL) than if
(IS_ERR(hdmi.audio_pdev)).

So store the return value from platform_dev_register first to a local
variable, check IS_ERR for that, and only then store it to hdmi.audio_pde=
v.

> +	res =3D platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		DSSERR("can't get IORESOURCE_MEM HDMI\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Pass DMA audio port to audio drivers.
> +	 * Audio drivers should not ioremap it.
> +	 */
> +	hdmi.ip_data.ops->audio_get_dma_port(&port_offset, &port_size);
> +
> +	aud_res[0].start =3D res->start + port_offset;
> +	aud_res[0].end =3D aud_res[0].start + port_size - 1;
> +
> +	res =3D platform_get_resource(hdmi.pdev, IORESOURCE_DMA, 0);
> +	if (!res) {
> +		DSSERR("can't get IORESOURCE_DMA HDMI\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Pass the audio DMA request resource to audio drivers. */
> +	aud_res[1].start =3D res->start;
> +
> +	/* create platform device for HDMI audio driver */
> +	hdmi.audio_pdev =3D platform_device_register_simple(
> +							  "omap_hdmi_audio",
> +							  -1, aud_res,
> +							   ARRAY_SIZE(aud_res));

Not a problem for the time being, but the above prevents us from having
two HDMI outputs. Perhaps you could use hdmi pdev's ID instead of -1 abov=
e?

Otherwise I think the series is ok.

 Tomi



--------------enig58AB4E84FF5F525057283E07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQl3zXAAoJEPo9qoy8lh716ckP/Apw0bQY+r9t7HRIcP9p2lp4
ltiNA63qShPGlcsvd4AEfly091rjmGefU8l7UJR/jTJkHr4AkWLQKj88iwQ7mnNp
wNBxV9uWEclizqtw7ELS9NyP15qnMCFxHmjydNl6ENChw5A4fHjSMc099McSGmaI
yzbYzav1/kkV9W0+aUS+1ew3jrYxv3HvZlwR5pnn3no7alhIjF1W0o9EMP7df6em
pLxu8bPyabGAGB2MY0M9YESIKEv4r1AW+GOHvO1Xyzh0G81dB55YwhrTcW7oCO3a
HzakKgR638M0u4mQztodHQRVNCm6oensURcgziLl6ShNZKQmeimwTJL5DLi/dDch
Mj5ksqvehpLn4qGS8Z+OE1O3wl//j+RDa0BhYLz1CNQMdNfL7A1IxEiQaqqV5UQW
zx5fYQmatfAJP0nPmaXHuI4Fx8FQTmcC27Xs9X82Xktr1hTLQgVolse2ir78OAzu
LDj7e3llUQBu+87lq57oX1QJEHNZdU9muzFv+lhXTyXXAtx/Anxyi4aN5OH5eHlA
eH4yHvlMXV7xxQTDUVMQWOdrAeTXu7YYKUyiH+om5UlH9Bq+5wcilpS+2+kobZg8
kjrs/5uB9NxZWHPvByW2Q+VROLuJN1ehFyOflR8VRdfFV6iSe61V/tcMqbzemg3d
neGl1IEf5yv05mYuWoNe
=X0KP
-----END PGP SIGNATURE-----

--------------enig58AB4E84FF5F525057283E07--
