From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] pwm: Add PWM driver for OMAP using dual-mode timers
Date: Wed, 16 Dec 2015 17:27:47 +0100
Message-ID: <20151216162747.GL28947@ulmo>
References: <5637458D.60106@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tv2SIFopg1r47n4a"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5637458D.60106@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org


--tv2SIFopg1r47n4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2015 at 12:14:21PM +0100, Neil Armstrong wrote:
> Adds support for using a OMAP dual-mode timer with PWM capability
> as a Linux PWM device. The driver controls the timer by using the
> dmtimer API.
>=20
> Add a platform_data structure for each pwm-omap-dmtimer nodes containing
> the dmtimers functions in order to get driver not rely on platform
> specific functions.
>=20
> Cc: Grant Erickson <marathon96@gmail.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |  18 ++
>  drivers/pwm/Kconfig                                |   9 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-omap-dmtimer.c                     | 322 +++++++++++++++=
++++++
>  include/linux/platform_data/pwm_omap_dmtimer.h     |  69 +++++
>  5 files changed, 419 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtime=
r.txt
>  create mode 100644 drivers/pwm/pwm-omap-dmtimer.c
>  create mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h

I've applied this with some coding style bikeshedding applied. Also I
think there's a timer leak in the probe function:

> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtime=
r.c
[...]
> +static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> +{
[...]
> +	dm_timer =3D pdata->request_by_node(timer);
> +	if (!dm_timer)
> +		return -EPROBE_DEFER;

dm_timer holds the requested timer now.

> +
> +	omap =3D devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
> +	if (!omap)
> +		return -ENOMEM;

But it's not released when this allocation fails...

> +
> +	omap->pdata =3D pdata;
> +	omap->dm_timer =3D dm_timer;
> +	omap->dm_timer_pdev =3D of_find_device_by_node(timer);
> +	if (!omap->dm_timer_pdev) {
> +		dev_err(&pdev->dev, "Unable to find timer pdev\n");
> +		return -EINVAL;
> +	}

=2E.. nor when this lookup fails. I've taken the liberty of adding two
calls to omap->pdata->free(dm_timer) to these error paths.

Please take a look at what's in the pwm/for-next branch to see if it
still works correctly.

Thanks,
Thierry

--tv2SIFopg1r47n4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWcZD/AAoJEN0jrNd/PrOhpLAQALPbKUvBPqri1hQhMBxtA8F/
6dFGNn5mB8txxcWF0YsEuH9/NMCgTbtqr4WL5dBf7mFczR/B93ol900tRSCVBOyh
MkfavaF3p04WAh8dLZEyNs6+R7pHIDdj88XkfPTxIwc74nYjNlhl+VAr7hy+zzL8
aXmk2vjZgkja5UtsZPE2bDyoi0HOT7ctFx/APPEMWLcfbIdEB8iOHB4qO5OeouEU
XFXDhEKsWMsILL9y0xQHzpYR/OzV/lw/vD+4yJ9FykS2atTY0KYZkREpheWrYiXY
zRb5BTFS1iBMPKnbZyLropjRu6lZ+2oz0m5a+71qTUc29jGitEAdpPf0jMp5xlRH
KhhVbXfawMvIPOTHLeON4an1o5NeFbTg7K8qNwz2lyF3LgONi+4Pht60Av2qGoO8
L7amnU5E3PaA+9VO8uUaBzwlIb0AVAG2xEbJjM5eE7kf1EEgLGlvvnneGK8+roYd
Kx64jrWAAqbiX0o7xutoCBhWhjgPH0jkIT6ww1EZ8W5yg8c0W//N5okXLeFWdqHu
smvFwhJANtETysvFSI0gbhZMLlz8svG0KryJeh9yd7cS83GbK9KCjw+eaPlK6vaa
HT2NXBj4SToBsUHbRvfIPwOSCPgh6Uts5uciSVEc/+rdavo644Qidy8LtA5TVx/B
SdNhDvFgIfU+jjrNMp75
=5fnx
-----END PGP SIGNATURE-----

--tv2SIFopg1r47n4a--
