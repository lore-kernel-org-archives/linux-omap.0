From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] pwm: export of_pwm_request
Date: Mon, 5 Nov 2012 07:48:16 +0100
Message-ID: <20121105064815.GA31066@avionic-0098.mockup.avionic-design.de>
References: <1351699030-4401-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351699030-4401-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2012 at 05:57:10PM +0200, Pantelis Antoniou wrote:
> No need to hide of_pwm_request, it's useful to other in-kernel users.

Can you specify which users that might be? I'm reluctant to export
symbols which aren't used by any drivers.

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
[...]
> @@ -457,7 +457,7 @@ static struct pwm_chip *of_node_to_pwmchip(struct dev=
ice_node *np)
>   * becomes mandatory for devices that look up the PWM device via the con=
_id
>   * parameter.
>   */
> -static struct pwm_device *of_pwm_request(struct device_node *np,
> +struct pwm_device *of_pwm_request(struct device_node *np,
>  					 const char *con_id)

Can you please make sure that this remains properly aligned?

> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
[...]
> @@ -171,6 +171,7 @@ struct pwm_device *pwm_request_from_chip(struct pwm_c=
hip *chip,
>  					 unsigned int index,
>  					 const char *label);
> =20
> +struct pwm_device *of_pwm_request(struct device_node *np, const char *co=
nsumer);

The second argument is called con_id, so please fix this up to keep it
consistent.

>  struct pwm_device *pwm_get(struct device *dev, const char *consumer);
>  void pwm_put(struct pwm_device *pwm);
> =20
> @@ -204,6 +205,12 @@ static inline struct pwm_device *pwm_request_from_ch=
ip(struct pwm_chip *chip,
>  	return ERR_PTR(-ENODEV);
>  }
> =20
> +static inline struct pwm_device *of_pwm_request(struct device_node *np,
> +					 const char *consumer)

Here as well. Also make sure the arguments are properly aligned.

Thierry

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQl2EvAAoJEN0jrNd/PrOhpowQAIaz+Sjp7sZQ0IPs94HxRZiu
Ig79mR7joqP6u0K3BYhV2pA1a8fYnkh3cAPSciVLhX6cSGOTRT1WVAAfonx1n9Og
8Z2JcuXke/NnKSjlAmPgL95rJ1Qex75YL6MXuXyVzZ8uVgK47jVGM+7CdTHS0A4m
6bktg7IULo5uOx9N5yvpkYL15XT91d5lDiCbrU81hMZJE8Awo9sDWaUoBNELuYVl
KfRFcxyos7t5GR/Y4/GP2ndngY7HAYhYpWu9t7+pdF6rAmM7kksYCVJeKgMttl2R
6uRqnq2qyRJmGJFKlaHPlVgbYLn4uZaZ0ALvsNwiyGWW2gk/jnGqPS49ThKm8nsy
hDr86g0byfOi+3xl9n3npLJK3GMEjtF98lImSv4PwRM5zbwheiB9VzRLC8swIfdc
Zew2xItnm9DwwUTvbk9egpL0PIBD3l9ijgcfg1zXDFTZB5wvNjbd0Lk9Sovz6MUL
JzM+IbWe/NLvtAaqC+42Tp+iZ727a8hxxodT9M+H+XTW25+ehHaUWcYciOa5RaP7
bJ6EMGPamj/FK07G1gCn7xhhgaW4jtMMNk2e0u/68WgEPbW2JjdvkUzjr89ClXzI
RzW+gSt+icvswGQPbvfR1lc1bsQ/qC/MfAqwQUcGgobXxDKoY8OqQM3DtVpsByjn
HE264ashOaqsaL+IgW8C
=EVPS
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
