From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] ASoC: omap: rx51: Use devm_snd_soc_register_card
Date: Tue, 15 Apr 2014 13:20:44 +0100
Message-ID: <20140415122044.GZ12304@sirena.org.uk>
References: <1396733753-9820-1-git-send-email-sre@kernel.org>
 <1396733753-9820-2-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8M+BMcg+0CmQ2H7L"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396733753-9820-2-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--8M+BMcg+0CmQ2H7L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 05, 2014 at 11:35:49PM +0200, Sebastian Reichel wrote:
> From: Pali Roh=E1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> This patch converts the rx51 ASoC module to use
> devm_snd_soc_register_card. It also adds module alias
> to support driver autoloading.

This doesn't apply against current code and since it does multiple
things it should be multiple patches.

> +static int rx51_soc_remove(struct platform_device *pdev)
>  {
> +	struct snd_soc_card *card =3D platform_get_drvdata(pdev);
> +
>  	snd_soc_jack_free_gpios(&rx51_av_jack, ARRAY_SIZE(rx51_av_jack_gpios),
>  				rx51_av_jack_gpios);
> =20
> -	platform_device_unregister(rx51_snd_device);
> +	card->dev =3D NULL;
> +

Why is this assignment being done?

--8M+BMcg+0CmQ2H7L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTSQZAAoJELSic+t+oim9axwQAJ1bebnpbDkFMA4qfqZKGDA7
ljaUPSVyscdB5l7cOIiyNLM+DQmYZFVZs2HxqOj4mQNljQ44NQu5+0T2U202zQRl
hR2MaCatZvroDw8RsPadpNnazyetECHUeL0DMOGvAl7kmodRpx70EKf4CIlCqSfF
HHc4ZECRUQcpG6v6iZgCBIGJafJrSi4cboQRmlgDl69WMFyBaLtwB0i+T2T30wpM
Nas4Z5UTg8co9KG/UAW81+63BpJ5U7hXRSb/+37U4W0i602ZZmOM/eZyxQ2cdMm8
EVdIm4p/H0CQ++LLBlagIEvWSvnBrUea7X+Fbm50M8R9NEBPJrP66u9Aq3K7MuCM
0FQscvzNHRAU2KD0yyRQebXBE5yr/dZwx535qk49Ws4TaZVo+oCf6G50us0Obt9D
6iotTBbPFnCoIUAGwXbBpKIGY7W5qbgdg2GIpFkKgCiMY8PacipWwa32Oab2jDLB
J8Shb6E9H/3o6/FOq0NfuLw48b0Xpc7geFT2iaJ1pn989G/+tf2MgyR8ISC6oyqm
SVBcp93HshzvpvvjkHNpD6kY5zjvVpI4QifY6xEIx6s/WAlnaiF4tjNMO9ejYd0s
0jZnxp9ZZ6Y2BveDZirVLErEyS8/kHKLpGbmg2TPXUmE0rlfZ748JVV+IPc2XNah
+83a88+8UGp9v9BjANtx
=QCJN
-----END PGP SIGNATURE-----

--8M+BMcg+0CmQ2H7L--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
