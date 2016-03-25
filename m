From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 15:54:19 +0000
Message-ID: <20160325155419.GI2566@sirena.org.uk>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk>
 <20160325150259.GA9372@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G7Nq9MsW2/RO6qci"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160325150259.GA9372@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--G7Nq9MsW2/RO6qci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2016 at 04:02:59PM +0100, Sebastian Reichel wrote:
> On Fri, Mar 25, 2016 at 11:17:57AM +0000, Mark Brown wrote:
> > On Wed, Mar 23, 2016 at 09:22:36PM +0200, Ivaylo Dimitrov wrote:

> > > Assigning a device group to a regulator does not change its state. To
> > > change the state of a regulator a message over the powerbus is required.
> > > Also, the check for the current state of a regulator should not count on
> > > a device group being assigned, but on the current resource state.

> > How did this driver ever work then?  It sounds like there must be
> > something else going on here.

> From my understanding of the twl4030 TRM assigning a device group
> means "<device group> wants this regulator enabled". It does not
> change the regulator mode (sleep vs normal or in regulator-framework
> terms: REGULATOR_STATUS_NORMAL vs REGULATOR_STATUS_STANDBY).

> It usually works, since the default state is normal. If the system
> is rebooted from a non-mainline kernel, which left the regulator in
> sleep/standby, nothing in the kernel switches it to normal.

I really can't tell how anyone could get from the changelog to what
you're saying about modes.  The explanation needs to be *much* clearer.

Part of the confusion is that if you're trying to do something to do
with the mode support that really needs to use the mode APIs, enabling
or disabling the regulator should not silently change the mode.

--G7Nq9MsW2/RO6qci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9V8qAAoJECTWi3JdVIfQVWMH/2f91W76mV7z5PVo9HnHrG+/
mxYrhm/eEM3kDwFHg2z5fF7JD9s41rFzKA/z8d5REAZizFCKsxqJBl/DMwk480Wk
jmjc0A9Pjs2amLQhJHCl2IvzOLMwcNo0QzS8PQGqPevFBxI+TWrHZWfUY1m9OLNI
XuqPSbd47DBDZDqfTtVRXR3f1P/6ooXgLXBLrIxvK4UxsUvL+fhV8R+mChNWPzAM
4YCk4SyUuQoru3niANjPFbpqawY/h1gZ9ftmblJnE9Yz9X4zjlMQEr3C62R3pGo8
LRWWh5nDMYBvJU1QC28iee5ao02ftjWwTKiD1TB65K6w0GNLkt9wlZWVKDCBMiA=
=hBWO
-----END PGP SIGNATURE-----

--G7Nq9MsW2/RO6qci--
