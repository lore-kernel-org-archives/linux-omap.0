From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] Regulators: TPS65218: Add Regulator driver for
 TPS65218 PMIC
Date: Tue, 3 Dec 2013 15:16:54 +0000
Message-ID: <20131203151654.GB27568@sirena.org.uk>
References: <1386053006-6480-1-git-send-email-j-keerthy@ti.com>
 <1386053006-6480-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zcU1BeNsGC5ZCldZ"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386053006-6480-4-git-send-email-j-keerthy@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--zcU1BeNsGC5ZCldZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 12:13:24PM +0530, Keerthy wrote:

> +static int tps65218_ldo1_dcdc3_vsel_to_uv(unsigned int vsel)
> +{
> +	int uV = 0;
> +
> +	if (vsel <= 26)
> +		uV = vsel * 25000 + 900000;
> +	else
> +		uV = (vsel - 26) * 50000 + 1550000;
> +
> +	return uV;
> +}

Use regulator_map_voltage_linear_range() (and similarly for most of the
other functions).

> +static const struct of_device_id tps65218_of_match[] = {
> +	TPS65218_OF_MATCH("ti,tps65218-dcdc1", tps65218_pmic_regs[0]),
> +	TPS65218_OF_MATCH("ti,tps65218-dcdc2", tps65218_pmic_regs[1]),
> +	TPS65218_OF_MATCH("ti,tps65218-dcdc3", tps65218_pmic_regs[2]),
> +	TPS65218_OF_MATCH("ti,tps65218-dcdc4", tps65218_pmic_regs[3]),
> +	TPS65218_OF_MATCH("ti,tps65218-dcdc5", tps65218_pmic_regs[4]),
> +	TPS65218_OF_MATCH("ti,tps65218-dcdc6", tps65218_pmic_regs[5]),
> +	TPS65218_OF_MATCH("ti,tps65218-ldo1", tps65218_pmic_regs[6]),
> +};
> +MODULE_DEVICE_TABLE(of, tps65218_of_match);

Indexing into another array by magic number like this is both error
prone and hard to read.  Either use defined constants or individual
variables for the things being referenced.

--zcU1BeNsGC5ZCldZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnfXiAAoJELSic+t+oim9EdkP/2uTCay2TZpGcsTIoHoBa0+5
QinGsRfxy0uAzJ97phIQ+b/jLmjiOrl//Ni492hc/C0vIiY5l01IUCD+2Mndb8b8
o77BiY+WthDvKAjqQ5MRDEg72MkHDDrBF6CMrvhCv364EN6cXCvEtgd6vvlIhWa4
bldr9aRrCbD1W3mCrusRwdEC3+jTb4vZ6MgTTuIhoEkZ3fKjLX3Wgsw7T6m4BzYC
72UbdYjjwffzxZ+4OF8q94j0kWOAo74TIMbnlDdAYgTxXIYh5Nrwja7oyiNTNWe6
MKrI7RYt/zdzkFaHrmcKi6gceHfikoglzvlptMvHM9I31t+cqvPhED4QkLRymnRW
u19V40FYj6nSnLORh6ue25T4O2agUGevd98ip7LMns53BexChlQb3hHvZV9dqm4g
V+9rJHBRufjGEqy6IKLeKHQRzup7qQwS1NkQFKfnI3VWf2MNsJgv7MFeRZk3t99m
RNfZBi4NkRynowlLibQMwpRd4DDym3LuFJpNcOG8z29+WvhCDvHcK/35lcRpnFpc
Ii7MP4CqIWhvFX/2xQuk0sPKGo7vd4VIjaFyKlrAOSjBomI6aHpS99S0A56/m5EW
8NfUZN1monFC9iNiVqjuI7rvYe1zw+PnGxdK55UYQ6o5ul2MhllN0tOomp4aUMhp
SFUCdGZ5JHmNc75RTJKX
=zZMa
-----END PGP SIGNATURE-----

--zcU1BeNsGC5ZCldZ--
