From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/5] ASoC: RX-51: Add DT support to sound driver
Date: Tue, 15 Apr 2014 13:34:49 +0100
Message-ID: <20140415123449.GC12304@sirena.org.uk>
References: <1396733753-9820-1-git-send-email-sre@kernel.org>
 <1396733753-9820-4-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ro1PRY3Rtw8g7IwX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396733753-9820-4-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Ro1PRY3Rtw8g7IwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 05, 2014 at 11:35:51PM +0200, Sebastian Reichel wrote:
> This patch adds device tree support to the Nokia N900 audio driver.
> It also removes GPIO defines and gets them from platform data /
> device tree, since some GPIO numbers may be different with DT boot.

This binding looks mostly fine, a few code things though which may
influence the binding.  The main thing is that you're doing a lot of
changes here which aren't really related to adding the binding which
aren't mentioned and make it harder to review - as well as making the
change larger one of the things that's done in review is to check that
the change did what it was described as doing.  At least some of the
time there isn't even any code overlap.

> @@ -290,6 +286,9 @@ static const struct snd_kcontrol_new aic34_rx51_contr=
olsb[] =3D {
>  static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct snd_soc_codec *codec =3D rtd->codec;
> +	struct snd_soc_card *card =3D codec->card;
> +	struct rx51_audio_pdata *pdata =3D snd_soc_card_get_drvdata(card);
> +
>  	struct snd_soc_dapm_context *dapm =3D &codec->dapm;
>  	int err;
> =20

Random blank line added here.

> @@ -301,8 +300,10 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtim=
e *rtd)
>  	/* Add RX-51 specific controls */
>  	err =3D snd_soc_add_card_controls(rtd->card, aic34_rx51_controls,
>  				   ARRAY_SIZE(aic34_rx51_controls));
> -	if (err < 0)
> +	if (err < 0) {
> +		dev_err(card->dev, "Failed to add RX-51 specific controls\n");
>  		return err;
> +	}
> =20
>  	/* Add RX-51 specific widgets */
>  	snd_soc_dapm_new_controls(dapm, aic34_dapm_widgets,

This is nothing to do with DT support, separate patch please.  There's
quite a few other things like this.  You're also not printing any error
codes in the messages.

> @@ -312,25 +313,39 @@ static int rx51_aic34_init(struct snd_soc_pcm_runti=
me *rtd)
>  	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
> =20
>  	err =3D tpa6130a2_add_controls(codec);
> -	if (err < 0)
> +	if (err < 0) {
> +		dev_err(card->dev, "Failed to add TPA6130A2 controls\n");
>  		return err;
> +	}

If this is converted to DT and you've added aux CODEC support as part of
that then why are we still manually adding the controls for the
headphone amp?  I would have expected this to be registered as an aux
CODEC.  This seems likely to feed through into the binding for
referencing the components.

> +	err =3D omap_mcbsp_st_add_controls(rtd, 2);
> +	if (err < 0) {
> +		dev_err(card->dev, "Failed to add MCBSP controls\n");
>  		return err;
> +	}

Refactoring this as a separate patch would also help.

> -	err =3D gpio_request_one(RX51_ECI_SW_GPIO,
> +	if (err) {
> +		dev_err(card->dev, "could not setup tvout_sel\n");
> +		goto error;
> +	}
> +	err =3D devm_gpio_request_one(card->dev, pdata->eci_sw_gpio,
>  			       GPIOF_DIR_OUT | GPIOF_INIT_HIGH, "eci_sw");

Again, moving this refactoring into a separate patch will help a lot
with review.

--Ro1PRY3Rtw8g7IwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTSdmAAoJELSic+t+oim9ygMP/jeBngPHxkTdywK18SH8GwWq
N4SG2enx7HaSyHL0FG+Wftk9/FIadSm4uPIQeer+fYg+zx4CzEFeY/YSbgAz1/QL
7e5Dnl8Tnf8uEU75/PreQ8N5tM7oMlta5MhT3sFzm+6Yub+PZhPxN8Ie0eKXT0wE
9fD342eKTNVjGoDUlH3hmQ33x7rtun2v65RO0qvQlCKZ+TPKKx9Cylq6e/OVSd5H
K8Qc2WbhHzbC6bjBqgElgWg0L7QPDZbOzKb0qSvDFmEimcjf5GHysl8zHDp6UKXx
CuAogz1qMonmNgONcAxjvW+ie812dXVn73+vB+TNcKmPRx6d30AaFVzR4fhdvy5r
n/8RNkkrbKCKfWHvqbmBmKkDJktBk6u6nZTZSDbNNqXOQlU8En8wFjro6eJD0Oxr
4xk+3L1Muvd8S/g/QlycFiP0kCYIqOLyaUpaeBAOS7j/+Aj5lgEkB81HFIdGHgxj
9IMFHhFqNPW8kpD4QwYmUJzw1uSlgmmrBBZAB/ImY80jIU+GvDLBc6WlhK0oG5CZ
a/w1wNS8NGW64zRBMP711OEn/tugv5Vm6jUexSPH1SL/qvC/TyLO1dniJVI8tkjP
lg8m41iUftCnrKxL3UNW5qHReo7iAJXEnpBDpFZFfCBQZnG9aI6NDC8SFhnTd8iF
k11dAM8TXoS9+rIQ63N/
=hwAL
-----END PGP SIGNATURE-----

--Ro1PRY3Rtw8g7IwX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
