From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Mon, 22 Oct 2012 10:40:12 +0300
Message-ID: <5084F85C.9050508@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2210AB0FE4D0256BF82047DC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47639 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764Ab2JVHkP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 03:40:15 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9M7eFTx018300
	for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 02:40:15 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9M7eFca005739
	for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 02:40:15 -0500
In-Reply-To: <1350350839-30408-7-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

--------------enig2210AB0FE4D0256BF82047DC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-16 04:27, Ricardo Neri wrote:
> Creating the accessory devices, such as audio, from the HDMI driver
> allows to regard HDMI as a single entity with audio an display
> functionality. This intends to follow the design of drivers such
> as MFD, in which a single entity handles the creation of the accesory
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
>  drivers/video/omap2/dss/hdmi.c |   68 ++++++++++++++++++++++++++++++++=
++++++++
>  1 files changed, 68 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/h=
dmi.c
> index e5be0a5..c62c5ab 100644
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
> @@ -73,6 +76,13 @@ static struct {
>  	struct omap_dss_output output;
>  } hdmi;
> =20
> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
> +#define HDMI_AUDIO_MEM_RESOURCE 0
> +#define HDMI_AUDIO_DMA_RESOURCE 1

I don't see much point with these definitions. They are hdmi.c internal,
so the audio driver can't use them, and so they aren't really fixed.

> +static struct resource hdmi_aud_res[2];

Did you check if the platform_device_register does a copy of these? If
it does, this can be local to the probe function.

> +#endif
> +
> +
>  /*
>   * Logic for the below structure :
>   * user enters the CEA or VESA timings by specifying the HDMI/DVI code=
=2E
> @@ -765,6 +775,50 @@ static void hdmi_put_clocks(void)
>  }
> =20
>  #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
> +static int hdmi_probe_audio(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +
> +	hdmi.audio_pdev =3D ERR_PTR(-EINVAL);
> +
> +	res =3D platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		DSSERR("can't get IORESOURCE_MEM HDMI\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Pass this resource to audio_pdev.
> +	 * Audio drivers should not remap it
> +	 */
> +	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].start =3D res->start;
> +	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].end =3D res->end;
> +	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].flags =3D IORESOURCE_MEM;
> +
> +	res =3D platform_get_resource(hdmi.pdev, IORESOURCE_DMA, 0);
> +	if (!res) {
> +		DSSERR("can't get IORESOURCE_DMA HDMI\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Pass this resource to audio_pdev */
> +	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].start =3D res->start;
> +	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].end =3D res->end;
> +	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].flags =3D IORESOURCE_DMA;
> +
> +	/* create platform device for HDMI audio driver */
> +	hdmi.audio_pdev =3D platform_device_register_simple(
> +							  "omap_hdmi_audio",
> +							  -1, hdmi_aud_res,
> +							   ARRAY_SIZE(hdmi_aud_res));
> +	if (IS_ERR(hdmi.audio_pdev)) {
> +		DSSERR("Can't instantiate hdmi-audio\n");
> +		return PTR_ERR(hdmi.audio_pdev);
> +	}
> +
> +	return 0;
> +}

So, how will this work? All the audio related functions will be removed
from the (video) hdmi driver, and the audio driver will access the
registers independently? The audio driver will still need to access the
video parts, right?

I feel a bit uneasy about giving the same ioremapped register space to
two independent drivers... If we could split the registers to video and
audio parts, each driver only ioremapping their respective registers,
it'd be much better.

 Tomi



--------------enig2210AB0FE4D0256BF82047DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQhPhcAAoJEPo9qoy8lh71UbEP/2IdgdY5/gI11aeI5JEBjb8k
Zn1ZKoAhB5J64OWKB+c+FFQTxJMpQculLhyg8x50aWQkYvOrXL9qCuaORZ1ayB44
hiRYVMYBKYTFK5zRUwYdpkL4Gvm33IHs8dVRIMQqj9Kw8v8e2DWehjgkTgtBtV+5
KhTAEwNSO+4yty2bvSEhkdbz4hVUTXwlDsJoa9RwVmevB/CeYLpo+Vy3Odnsu++5
TlzGOJgpji+d2x6Bqam8FBGqCdnY2YkK/2msGkx6NJskVREsJMJPQ9CgLtNymxEH
QuBwAVqU6o4SV76PiNMG/bY+CwxWL5o4aCXoA/kpJZdT2GSYbKOL+uACe9wcS5Uy
xzHAPvTpK8iac8ZsJ83/CLwRfupPd+FaQ1LszFPMO8uaQdD6hW+kwzJo0Qmd16gQ
XjXd72BH+hY7B22pAK9vhm5RlRsBrZgszZTEfsmPBGNLOw1iNh4hMZEuOHSCWa8j
LTi8N/PNxhWJhAwUuXjfo/LyUInXfv+JJz4OOD3ZIHAqjqw0i+vBF413C9PjLsYr
CitNaQG1MgX3W+lwX7d2o3b1MBmSngbzQM11AnJuqeiaUMiT8kvJch6bFk6QQwJ9
NppRa7xjxe09muwYvEqWgUU9qazt1GtOlcbIoVpJp39u3Weybufbjg5njKb2yvYn
VrRik2Q6Alzaxl0+ZdAu
=uWOM
-----END PGP SIGNATURE-----

--------------enig2210AB0FE4D0256BF82047DC--
