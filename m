From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to
 program pbias regulator
Date: Thu, 20 Aug 2015 10:42:52 -0700
Message-ID: <20150820174252.GF12027@sirena.org.uk>
References: <1437996250-2913-1-git-send-email-kishon@ti.com>
 <1437996250-2913-2-git-send-email-kishon@ti.com>
 <20150814180006.GB10748@sirena.org.uk>
 <55D2C872.9000400@ti.com>
 <20150819181149.GZ10748@sirena.org.uk>
 <55D56ACA.1030309@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55D56ACA.1030309@ti.com>
Sender: stable-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, grygorii.strashko@ti.com, nsekhar@ti.com, stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2015 at 11:21:06AM +0530, Kishon Vijay Abraham I wrote:
> On Wednesday 19 August 2015 11:41 PM, Mark Brown wrote:
> > On Tue, Aug 18, 2015 at 11:23:54AM +0530, Kishon Vijay Abraham I wrote:

Please fix your mail client to word wrap within paragraphs.

> >> platform_get_resource can be used if we need the absolute address but here we
> >> need only the offset.

> > So substract this address from the start of the resource to get the

> That would mean from the offset (provided in dt) get the absolute address and
> then again from the absolute address get the offset.

Sure, that's how the Linux APIs work right now and why I'm suggesting
you might want a wrapper.

> > offset?  Or provide a wrapper function in the resource code which does

> Why not use 'of_get_address' which does the same thing? Moreover it's not a
> resource we are dealing with here. It's a resource only for the syscon driver.

This is how the OF description you've done is intended to be parsed and
hence is interpreted by the generic code, it's just a detail of the
syscon implementation that you need to translate it into an offset.

> > that.  What you're saying above is pretty much "this happens to work"
> > but my concern is that the solution that happens to work isn't really
> > what we want to do.

> Not just makes this work, this is also the most reasonable solution available IMHO.

In general moving to a lower level inteface is not usually a step
forward.  As far as I can tell the driver already has all the
information it needs from the more generic APIs, it's just not
interpreting it in the way that the APIs it's trying to use wants.  It
just needs to fix the way it interprets the data it's passing through.

> The most ideal way would have been to use something like what Grygorii
> mentioned to use syscon = <&scm_conf 0xe00> and then use the phandle to get the
> offset. But then with this we'll be breaking older dtbs.

There is no need to break older DTs, that would clearly be a bad idea.

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1hGXAAoJECTWi3JdVIfQQuQH/1APBJQhUtBzUE2WhFucY2ny
lwrBJfdjZ+KCx/eg3Tx/V+o230XixGK6jBJKmI783Bb7Hi26fkJh4/rgPpO+PJk0
hpES9u1ry4TY67jvn13Ng6QegJqyEaqt2lrZZ8r6+5WBS7k4zyu7iVZ1GbbeB46X
KMLevQ0tUdwOnElSzwUGedWG9+jbfayhKueN+1B8kuK1m/K95DQPviFesyBKppBb
Dcoxp2avjraEGR0JF8QQyAYo/JcS5muKB3ynjV1WGvSKs2a88bL922fiRPZYEjsI
htauZjXwjc0LMz9IZM/0aSUeDDL0ztshIw2mAfjZAmumtrUrKCEKmbyoLQ4wpKg=
=PiBq
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
