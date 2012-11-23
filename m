From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v3 3/3] pwm: New driver to support PWM driven LEDs on
 TWL4030/6030 series of PMICs
Date: Fri, 23 Nov 2012 16:04:12 +0100
Message-ID: <20121123150412.GB16810@avionic-0098.adnet.avionic-design.de>
References: <1353405382-9226-1-git-send-email-peter.ujfalusi@ti.com>
 <1353405382-9226-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353405382-9226-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 10:56:22AM +0100, Peter Ujfalusi wrote:
> The driver supports the following LED outputs as generic PWM driver:
> TWL4030 LEDA and LEDB (PWMA and PWMB)
> TWL6030 Charging indicator LED (PWM LED)
>=20
> On TWL6030 when the PWM requested LED is configured to be controlled by S=
W.
> In this case the user can enable/disable and set the duty period freely.
> When the PWM has been freed, the LED driver is put back to HW control.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-twl-led.c | 303 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 314 insertions(+)
>  create mode 100644 drivers/pwm/pwm-twl-led.c

Doesn't this belong in the drivers/leds subsystem? Besides that, the
same comments as for the previous patch apply. One additional note
below.

> +static struct platform_driver twl_pwmled_driver =3D {
> +	.driver =3D {
> +		.name =3D "twl-pwmled",
> +		.of_match_table =3D of_match_ptr(twl_pwmled_of_match),
> +	},
> +	.probe =3D twl_pwmled_probe,
> +	.remove =3D __devexit_p(twl_pwmled_remove),

You didn't annotate twl_pwmled_remove() with __devexit, so __devexit_p
isn't needed here either.

Thierry

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQr5BsAAoJEN0jrNd/PrOhp9kP/RzoxDKI4W6V9eDon+tAuJFc
ahyvQdaqEMFDqiVVf0GpiGuFkEDdZ2MgQMLCyH1cGUoGPT1xArPg+SMG2rpIGT8C
qtjldukFJUcyamzF6MUh4uJdWtDSkch6Jus+dfb3nxT14Tfil/9YvEAkyKGDiAwN
ntU3LaxPKT2efFFHJpeLdOUiwqvwdpkv9ao93vkVzcICqpQc1hanIX5qJYdGqWzH
VM2A12EhNaMHkbSIAxsVz5ft/ZShrJhDVtNmCFeYIb0c7W6PN6B2dvE39QoVfVT3
xwx5Njy4vqwGY9UEgYANby4Q9ag6TzQH+9p29WF8OPAK+YdhYfejmFhAIWk2nNNI
lkc3Mq6HFJm1z5bPwDuxXNUMqPgRX8SfwWRxhu7yRz14A2O4tBKLRT0B6t2UKtZD
SJWeXpsPCVw+Kgi2prrOQFHK8ze1EQLmp8kngP0sjEZ9/82dFlUR070BWRX+Oz9w
5HUqcxacERaU06/IqYUyG0C0y+7ST8astbENuxrfKjcqbCzCktDsRwWHVfJpr8Hf
+BOqD5CCUI+5i5IiL/bmvvvj4h24Uoio0BMZIFOFELtHW7ZU4VgwEOuMUxEQa1Lh
v6rKzmYQb11Qt5U0ZW3Pq1tjLTBo4nakelIvstcZ1gsVHZFz4RL4pC5dVKop00Dj
+gHvevjcc2LCQRtMyhOE
=G/rG
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
