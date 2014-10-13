From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 2/4] regulator: act8865: Add support to turn off
 all outputs
Date: Mon, 13 Oct 2014 15:16:22 +0200
Message-ID: <20141013131622.GA27755@sirena.org.uk>
References: <1412711104-15902-1-git-send-email-romain.perier@gmail.com>
 <1412711104-15902-2-git-send-email-romain.perier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+u5Zr0N4xEYVI1yx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412711104-15902-2-git-send-email-romain.perier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Perier <romain.perier@gmail.com>
Cc: devicetree@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, heiko@sntech.de, sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, robh@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, ldewangan@nvidia.com, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--+u5Zr0N4xEYVI1yx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 07:45:02PM +0000, Romain Perier wrote:
> When the property "poweroff-source" is found in the
> devicetree, the function pm_power_off is defined. This function sends the
> rights bit fields to the global off control register. shutdown/poweroff
> commands are now supported for hardware components which use these PMU.

Reviwed-by: Mark Brown <broonie@kernel.org>

but...

> +	if (dev->of_node && is_system_poweroff_source(dev->of_node) &&
> +		!pm_power_off) {
> +		act8865_i2c_client = client;
> +		act8865->off_reg = off_reg;
> +		act8865->off_mask = off_mask;
> +		pm_power_off = act8865_power_off;
> +	}

Perhaps worth wrapping the dev->of_node check into the function?  I
imagine the same pattern will be quite common.

Might also make sense to warn if we've got the property but we're not
setting pm_power_off - it's indicating that things aren't working as
expected, an error will help users figure out what's going wrong.

--+u5Zr0N4xEYVI1yx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO9CmAAoJECTWi3JdVIfQ81IH+QG2zDvLTh0iMG1qdEK/plrI
O/ij4U2SrOESLz3pY4iUQti3iyzcrjth47+VywyYw4abGxUYHsuLQCN48RR1j8rE
LsjH4bh4S0NbPBWxEyswD422zkH9dOsEZ9JLa2GMLW+6jcrGyGT8fLhfviXJ/Iu2
+chW/ImDzxwQ1mP8lzwo686aXU/K3kNQwT6Er4pvoBAp3rPzIo2hupYte5tDP6Pf
RAQu7nvsmyJuK3ZZatC+R9FHmWYCOboWGTmduVo6gYg8J3gTIUkxPtfOrat5CvH2
jQfb0CaBajR0CnByp7wWHA5NskTB33wvczlmeoW3ZWQ9Dtl26A2jx1E5VXBydkI=
=/Doj
-----END PGP SIGNATURE-----

--+u5Zr0N4xEYVI1yx--
