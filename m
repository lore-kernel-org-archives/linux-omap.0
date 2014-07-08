From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 6/7] regulator: tps65218: Add get_voltage ops for
 dcdc5 and dcdc6
Date: Tue, 8 Jul 2014 16:11:26 +0200
Message-ID: <20140708141126.GW30458@sirena.org.uk>
References: <1404814597-4404-1-git-send-email-j-keerthy@ti.com>
 <1404814597-4404-7-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MjBORTcaENZKFEO1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404814597-4404-7-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mark.rutland@arm.com, galak@codeaurora.org, robh+dt@kernel.org, linux@arm.linux.org.uk, balbi@ti.com, tony@atomide.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org


--MjBORTcaENZKFEO1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2014 at 03:46:36PM +0530, Keerthy wrote:

> +static int tps65218_pmic_dcdc56_get_voltage(struct regulator_dev *dev)
> +{
> +	struct tps65218 *tps = rdev_get_drvdata(dev);
> +	unsigned int rid = rdev_get_id(dev);
> +
> +	return tps->info[rid]->min_uV;
> +}

Set fixed_uV in the descriptor.

--MjBORTcaENZKFEO1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTu/wGAAoJELSic+t+oim9lqIP/RqV+TTMDUxAlFijepWYUBq1
TzJtD2peZymC74ESIFKsaM5YKMqbD4PJ8Kp7gfICOCh1ribTLc6y2QRKh1kczhxt
ISzYV1x6WOGFTVx77YziShJ/w4idKHkJ80aWpRtZ9lx32UQO770u0/CSwkQf/aMd
oBXqBu7PHlbJJUBUcy3Z04N2UQVWe6QjvdEg9CYFNxykVUuLGK3n9/DLJobe7zTM
13Kdl+ivyAO4nmgzCJW3c1DdhxNZu8GuOZ32yERMMp6T9vQAW1gw3OKPzBEcCWKw
TLuFup7RfPcDq7Xc1QmBCsVFxJyvt/hzQe1QPcoSuNI/qta9rtyW6Hep9z42OSz4
koCR44Xuu6UabApwy3pjf3G6NOwJH3hmCZmKSGPVP8CHXaSnmxAvXs00NNqhq3g6
3nnQA9os+VT+kKYO9XbpOkRP60+hr5q4QD3cSgCLytM+9fIsSYlJV6/XWgQfL9KB
glN6tqbh5lxIh6qwKQWSw9+6CmMhwGNF4XeMJ0jIfqixnqGrTKD5d9dkFZhCLr2i
j2r/653OC72TiNNrduOXH4ugNAJuKaI9fqEFeED4g3seYg5Ejj8G6fnOmKy/kXbz
Pq5uPNJeEFutr0V9ibWCHrdxG5ATje9BmneCZOBTAFgCWpxpnTjn//OaMBGqlgkB
LkVgtSwRqQWzX9GFkW3J
=83JU
-----END PGP SIGNATURE-----

--MjBORTcaENZKFEO1--
