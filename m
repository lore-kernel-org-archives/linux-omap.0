From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to
 program pbias regulator
Date: Wed, 19 Aug 2015 11:11:49 -0700
Message-ID: <20150819181149.GZ10748@sirena.org.uk>
References: <1437996250-2913-1-git-send-email-kishon@ti.com>
 <1437996250-2913-2-git-send-email-kishon@ti.com>
 <20150814180006.GB10748@sirena.org.uk>
 <55D2C872.9000400@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l1DedMHSARaHaG29"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55D2C872.9000400@ti.com>
Sender: stable-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, grygorii.strashko@ti.com, nsekhar@ti.com, stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--l1DedMHSARaHaG29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2015 at 11:23:54AM +0530, Kishon Vijay Abraham I wrote:
> On Friday 14 August 2015 11:30 PM, Mark Brown wrote:
> > On Mon, Jul 27, 2015 at 04:54:09PM +0530, Kishon Vijay Abraham I wrote:

> >> is moved as a child node of syscon, vsel_reg and enable_reg has the
> >> absolute address because of the address translation that happens while
> >> creating device from device tree node.
> >> So avoid using platform_get_resource and use of_get_address in order to
> >> get only the offset (untranslated address) and populate these in
> >> vsel_reg and enable_reg.

> > This sounds like we're going in the wrong direction, we're moving from a
> > more generic API to a firmware specific one.  Why is this a good fix?

> platform_get_resource can be used if we need the absolute address but here we
> need only the offset.

So substract this address from the start of the resource to get the
offset?  Or provide a wrapper function in the resource code which does
that.  What you're saying above is pretty much "this happens to work"
but my concern is that the solution that happens to work isn't really
what we want to do.

--l1DedMHSARaHaG29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1MbeAAoJECTWi3JdVIfQol8H/1typNAuC+GUW6ozKcwtO1f0
mfcxbllbz9Y+qqEVVOJE1fBXIjhjKNpTnF2h6D8oolfm5tRhi2HNO03LL2e6uoek
YfCibmNeBof4t+1T5qknC5djzm/sfc/rJR9RqPOztd/2ktWN8TMBNe9liF2X/vUK
nguo51oO9fy0lJkg4Z/gV5Lb2X/n0oHSfQMMgrqPPwrSKtF4gfmwnn264eqlr1/+
+bvkdicDhwwLve3q9RYc+NrDwp6qLUo+rtOUw4ec6DBZnAInjXyVS5nKcNrJZY9j
Jy5DWDbj5yOb2cmRkgiOmgptd/D9V9UMZl+I5EaBs9/LuUikzyZTkuTxZ9R5SZg=
=W9Ib
-----END PGP SIGNATURE-----

--l1DedMHSARaHaG29--
