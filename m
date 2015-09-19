From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC v4 3/8] ASoC: hdmi-codec: Add hdmi-codec for external
 HDMI-encoders
Date: Sat, 19 Sep 2015 10:54:51 -0700
Message-ID: <20150919175450.GL30445@sirena.org.uk>
References: <cover.1442572860.git.jsarha@ti.com>
 <6fe9ab5dff972e6f228259d6818f3f481a11577d.1442572860.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kkRamCq5m5VQq0L6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6fe9ab5dff972e6f228259d6818f3f481a11577d.1442572860.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--kkRamCq5m5VQq0L6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2015 at 02:06:40PM +0300, Jyri Sarha wrote:

> +#define SPDIF_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |\
> +			 SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S20_3BE |\
> +			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE |\
> +			 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE)
> +
> +#define I2S_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |\
> +			 SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S18_3BE |\
> +			 SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S20_3BE |\
> +			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE |\
> +			 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |\
> +			 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE)

I'm not sure how abstracted this I2S and S/PDIF DAI business is - it
doesn't feel like something that's going to be a property of all HDMI
devices, and the specific sets of formats above cause me to raise a bit
of an eyebrow.  Should this be an interface where the HDMI chip
registers multiple interfaces if it has them instead of automatically
getting this split as is?

We can probably skip more specific constraint stuff I guess on the basis
that things tend to support the full range of HDMI functionality, or at
least that can be added later?

Otherwise this looks mostly OK on a first pass, thanks for working on
it.

--kkRamCq5m5VQq0L6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/aFqAAoJECTWi3JdVIfQe3cH/0t5lNARGtTFx0t1f7f7plRf
/5yPPGpkC9VO3QCAY0og2SNHmlkDM9nfB4Ukm7fqCMG7jT9KSWJl9LtnN+kQpvIE
uAcPjJ9cFaaOZHdGsW9q3Z/J8IL1iTg3iJsdkYuyq/WZAwJjO+Z30yu/pNogRnBj
XHoUVv0os5f5+nLb1Jd80JHt/ACNjUrTl4WIJi9+cnFtZguy+FJvAWxcQTaHgQEY
LuESikDtlVR6YbfxjrzlcT4UNZffgOGRHDsbECsBhvVrMDhGaDcbuN2C972VL2ll
g7XBfqQiq1/YMamdllH9lsXPAcd1bXDImktHZI6rs7Dg/a2p3sbzWy+J1hIFINk=
=enM2
-----END PGP SIGNATURE-----

--kkRamCq5m5VQq0L6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
