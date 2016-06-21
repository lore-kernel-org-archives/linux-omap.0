From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9] regulator: tps65217: Enable suspend configuration
Date: Tue, 21 Jun 2016 20:08:48 +0100
Message-ID: <20160621190848.GF28202@sirena.org.uk>
References: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
 <1466412218-5906-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466412218-5906-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 20, 2016 at 02:13:30PM +0530, Keerthy wrote:

> +static struct tps65217_regulator_data regulator_data[TPS65217_NUM_REGULATOR];

Why is this a static global?

> +		/* Store default strobe info */
> +		ret = tps65217_reg_read(tps, regulators[i].bypass_reg, &val);
> +
> +		regulator_data[i].strobe = val & regulators[i].bypass_mask;
> +

Not sure what this is doing...  I think this needs splitting up a bit,
it looks like it's a bit more than just adding the ops (which should be
generic things), that bit seems OK but there's these other bits in
there as well.

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaZC+AAoJECTWi3JdVIfQJ9IH/jvO5mMNs/t1n9soNxyQUqbj
bDNw3p/jWayvnOgV66QMyXPc3YJo2z5Gp/A+SwtSQRdhbE7TerSQYUWly+xGnjIj
3ftlfEeKPvF0DOc8ZSm7XaLSn41iy5yctcPcCpAcXuu1unJfOHfFHBxTaxKS7m3M
DagqcsU4WAhrkFHAhhkJMhb8HNQmIOoREzWbEh8gppmJeSn0zWcwpeTIUNxd0kNA
0tGZHdufWXFUX8Z6DRfzJ2eYD/3QoGNmw2H16h2ygwH8302GpduY6FUJ9NQdxZYM
qXCCHzx1aKOogDQrS1RIPbI0V0jsyKkCbvTovXuv2tk4SGDfsmAqk8jHd/mlgGU=
=uxF5
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
