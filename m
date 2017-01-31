From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] regulator: cpcap: Add basic regulator support
Date: Tue, 31 Jan 2017 23:13:56 +0000
Message-ID: <20170131231356.yubhrtyehkr462mo@sirena.org.uk>
References: <20170131001241.5926-1-tony@atomide.com>
 <20170131211256.l3e53y2mkzylfjnw@sirena.org.uk>
 <20170131220953.GF7403@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jpdxfvqowm7gyc4x"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170131220953.GF7403-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--jpdxfvqowm7gyc4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 31, 2017 at 02:09:53PM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170131 13:14]:
> > On Mon, Jan 30, 2017 at 04:12:41PM -0800, Tony Lindgren wrote:
> > > +	error = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
> > > +				   rdev->desc->enable_mask,
> > > +				   rdev->desc->enable_val);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	if (rdev->desc->enable_val & CPCAP_REG_OFF_MODE_SEC) {
> > > +		error = regmap_update_bits(rdev->regmap, regulator->assign_reg,
> > > +					   regulator->assign_mask,
> > > +					   regulator->assign_mask);
> > > +		if (error)
> > > +			return error;
> > > +	}

> > What does this second register bit do?

> My guess is that it triggers regulator idle modes in the PMIC based
> on the SoC off mode. There's no documentation for this thing..

> I've just kept what the Motorola Linux kernel tree does here and added
> some comments to CPCAP_REG_OFF_MODE_SEC.

> I'll address the rest of the comments and post v2, thanks for looking.

OK, thanks - comments should cover it here.

--jpdxfvqowm7gyc4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliRGjMACgkQJNaLcl1U
h9BCUgf/WpeUMgLHZyjkizmQJvrzHfTU3wRC6VM5yezR1nViHWnNAb1y/MnDvLp8
OrGQHnpQRTLFI+7OGyBEYllT+Uw/lwOVORCk/cxTISWqvXQ0vmWYIhaaxggoczCD
pLzEAUhBJzaErHGdkhv+7Us3wbOyz8Tjod2RWa/jJiZAPo+k1tgBYKL0lQRsVWY7
d9cO8FDicGsGuLk3BFfAa7lEFfr7nGsIa1PFxG6V+07nUxvW1gs9rbLvu/mIsOyl
rmUl/ydXMLg3ntXnEfV8e5Gzy0e3MXiE9WJ45ihbW4GFeNIbudHBtKWW4bbQ2+Hv
W0UWcs5P+7Egv0n5gDuTRt/4PqYYIg==
=pznc
-----END PGP SIGNATURE-----

--jpdxfvqowm7gyc4x--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
