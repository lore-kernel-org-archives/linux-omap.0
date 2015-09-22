From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/3] power_supply: Add support for tps65217-charger.
Date: Tue, 22 Sep 2015 15:44:32 +0200
Message-ID: <20150922134432.GG23334@earth>
References: <1441699779-22189-1-git-send-email-enric.balletbo@collabora.com>
 <1441699779-22189-3-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441699779-22189-3-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dbaryshkov@gmail.com, dwmw2@infradead.org, tony@atomide.com, sameo@linux.intel.com, lee.jones@linaro.org, sjoerd.simons@collabora.co.uk, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Sep 08, 2015 at 10:09:38AM +0200, Enric Balletbo i Serra wrote:
> This patch adds support for the tps65217 charger driver. This driver is
> responsible for controlling the charger aspect of the tps65217 mfd.
> Currently, this mainly consists of turning on and off the charger, but
> some other features of the charger can be supported through this driver.

Driver looks mostly fine. I have two comments though:

> [...]
>
> +static int tps65217_ac_get_property(struct power_supply *psy,
> +			enum power_supply_property psp,
> +			union power_supply_propval *val)
> +{
> +	struct tps65217_charger *charger = power_supply_get_drvdata(psy);
> +
> +	if (psp == POWER_SUPPLY_PROP_ONLINE) {
> +		val->intval = charger->ac_online;
> +		charger->prev_ac_online = charger->ac_online;

I think prev_ac_online should be set at the beginning of
tps65217_charger_irq().

> [...]
>
> +static int tps65217_charger_probe(struct platform_device *pdev)
> +{
>
> [...]
>
> +	charger->ac = power_supply_register(&pdev->dev,
> +					&tps65217_charger_desc, NULL);
> +	if (IS_ERR(charger->ac)) {
> +		dev_err(&pdev->dev, "failed: power supply register\n");
> +		return PTR_ERR(charger->ac);
> +	}

You can use devm_power_supply_register(...) to simplify the driver
a bit more.

-- Sebastian

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAVs9AAoJENju1/PIO/qaMZwP/2hkjOS3EBALtiClJtJQ9pkP
J1WFNEJqAjg9gBzz0qQraa6ObwQaK7bvR3IIizpWEztNuAcbg9zK6EJc7LGfwgFr
tmbDpWsJ/x30WVpeg/7c3GWZipFo6xgBCbA/1Ew6DD3ZWrgd9nwJb8CnMPIO1Bw8
QoSJb88AxCb74k2dwrBhkCp2b/d7+DQXDAbDRXj50ZiPmZIieFXrRe1bGKingUs9
pTaMm4e1+u2EfN4UyMhCulLaguyhp3skZY5T7eCLEhU5X8ieAABFbHINWngfjGch
twj2VU9AZgvOkB5ipcdAdj4mPuI3fEH8XuvHx/3U6V5NeDH7EW647Wx3TW7359DX
VXETmoqeLezM4mojTv3gRaQwbeiKINwkxpNsreANNCcd+sONTkuGCZS3w7jkJu8T
0lrZ+C1PkzuyroGoXWt1PPgCzmqbR4ldojx8W/wfpKECyuaVI/RiwzTf4nneOtWX
76DXZn3S+76GhgEjRo7p8IYk9oFRZdAFOQKfDmnvv6Sc6R0THqH0nTXdTXnORc3p
8yDgpIr7KjWfD96Wt1FEEXVYsxudgLMk2cQrbFY33BhCkKcoToHZ9bMwNR875j+M
HMsRlxyLssrTrLmuR8qdAd7VByAyO/C9Do1B0N0TNRY3WZQVVui6e3KsiCIOpC4q
yaCUV1iG5jDaqNiWdgD+
=Oas6
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
