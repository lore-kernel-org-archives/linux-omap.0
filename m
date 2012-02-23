From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
Date: Thu, 23 Feb 2012 15:34:22 +0000
Message-ID: <20120223153422.GF4553@opensource.wolfsonmicro.com>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41729 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756488Ab2BWPeZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 10:34:25 -0500
Content-Disposition: inline
In-Reply-To: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2012 at 01:05:09PM +0200, Tero Kristo wrote:

> +static int twl6030coresmps_set_voltage(struct regulator_dev *rdev, int min_uV,
> +	int max_uV, unsigned *selector)
> +{
> +	struct twlreg_info *info = rdev_get_drvdata(rdev);
> +
> +	if (info->set_voltage)
> +		return info->set_voltage(info->data, min_uV);
> +
> +	return 0;
> +}

This should be returning an error if it failed to set the voltage.
Since you're using min_uV as the "register value" you probably ought to
be returning that as the selector too and supplying a list_voltage()
which just passes the selector back in case something tries to use it
and gets confused.

> +static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct twlreg_info *info = rdev_get_drvdata(rdev);
> +
> +	if (info->get_voltage)
> +		return info->get_voltage(info->data);
> +
> +	return 0;

Similarly here.

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRlx4AAoJEBus8iNuMP3dfiwP/jS6Ba8s5u6M6BE1WisgjF/E
71V7A4/Cr8EIyqDXT/6Z6ZrA0myVJa8QQUX2UusSZ+7BCnU48uxBZYuZ77XIgHKH
h80azAtT8Bj4gCUUMRu3USiQe5w2ZLWtKFRvVKRzG8z7XV/3LK139n4HnvYKTqai
+rwZYQkKjjzI65BXGwq6G5j72FK5d2eRn1mTn9GItMHhre0bl4cLhka+4su1crXS
RhJqtx8HA66li8LCLyIsVLCQB18dAgdVtKEBsJoIhf2qOoqK4bo/XGJa1TEt7Jq+
Hp3zp0hJDENQAvWWEqxQ3Bqerdo+ifZayvKKYUKFaRq/pK3Vif+7nEKG7OnJvYZT
No6Ci5KDlRRTQUg6gzwTkWBNyGU9CI3vLNMxOV3jAsAHx6+cvAOzG1MQknN99fXe
Bm+0ZsvltWldKlwXFch61erDyfGH1TyPaViSy+3ljHzMZpQOszoaGkIH2w0faTGl
a0kJZoDTF4e0hb1+FXbJ+WA2enMdTsuC14ib+Ev1HRFbmo5MEVpyXk8g9ihmgmZt
rmaq6wkpq1itj+3frq3I1OHKcWY9rffOLvS/QvqJLTtwbQIGLS2dlI5+eU+JEiEB
//D5Lk3OJvXoHkJbVXOhdetyNbe1hj23JK5cafbUExSsMTAanUvzYAudzD1LoHF0
kN2YbsZCDc+3uoTLBISJ
=zzQf
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--
