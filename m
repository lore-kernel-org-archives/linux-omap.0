From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC v3 3/7] ASoC: hdmi-codec: Add hdmi-codec for external
 HDMI-encoders
Date: Fri, 14 Aug 2015 17:18:20 +0100
Message-ID: <20150814161820.GU10748@sirena.org.uk>
References: <cover.1439542916.git.jsarha@ti.com>
 <ed41a6c0b594866c05e695cc066371d0e3862c7e.1439542916.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m+1hRa/9CwYN9i9M"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ed41a6c0b594866c05e695cc066371d0e3862c7e.1439542916.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--m+1hRa/9CwYN9i9M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 14, 2015 at 12:30:41PM +0300, Jyri Sarha wrote:

> +struct hdmi_codec_ops {
> +	/* For runtime clock configuration from ASoC machine driver.
> +	 * A direct forward from set_sysclk in struct snd_soc_dai_ops.
> +	 * Optional */
> +	int (*set_clk)(struct device *dev, int clk_id, int freq);

I'd be much happier if we were using the clock API as the external
interface here, it's where we want to be internally too and it's going
to be easier to not introduce any external dependencies on the ASoC
internal stuff.

> +	/* Called when ASoC starts an audio stream setup. The call
> +	 * provides an audio abort callback for stoping an ongoing
> +	 * stream if the HDMI audio becomes unavailable.
> +	 * Optional */
> +	int (*audio_startup)(struct device *dev,
> +			     void (*abort_cb)(struct device *dev));

I'm a bit confused about what is going to use abort_cb() and why they
wouldn't just call shutdown instead?

> +/* HDMI codec initalization data */
> +struct hdmi_codec_pdata {
> +	struct device *dev; /* The HDMI encoder registering the codec */

Shouldn't this just be dev->parent?

> +enum {
> +	DAI_ID_I2C = 0,
> +	DAI_ID_SPDIF,
> +};

I2C?  :P

--m+1hRa/9CwYN9i9M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzhTLAAoJECTWi3JdVIfQjp0H/0RWulQb/WC9GMi64BDKCmdm
paUTUKdFTuhaC2HUn8ecFaE4RLYmunc8jgP1rqdI4cLZq7J98lhD3KOgm1n03q6O
Dv/NlYem4THejxX8b8WiNmuXXcJI07NERSyy7B3YrpEsu30RU95z/r4nlFm1wXqo
8UIQC8PsDDimuicYWuC2UKaZV5B9w4ZT8YAzCDDWoBZwMU4gJ0IA0lt4mDhNd1fc
j32CImAzlCT9VJIC8ez5LtOgZmLnzO4ch8UB0vw5dG3mnpnQRalr6+Lzd9JhERee
Co9PQj+FIZvNBqXf3YawGffEt5veDfgsvnKP5i/jh5E55hrNx/XryMuzy1dZpcI=
=ryRi
-----END PGP SIGNATURE-----

--m+1hRa/9CwYN9i9M--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
