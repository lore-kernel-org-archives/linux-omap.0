From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 16:02:59 +0100
Message-ID: <20160325150259.GA9372@earth>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160325111757.GC2566@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Mar 25, 2016 at 11:17:57AM +0000, Mark Brown wrote:
> On Wed, Mar 23, 2016 at 09:22:36PM +0200, Ivaylo Dimitrov wrote:
>=20
> > Assigning a device group to a regulator does not change its state. To
> > change the state of a regulator a message over the powerbus is required.
> > Also, the check for the current state of a regulator should not count on
> > a device group being assigned, but on the current resource state.
>=20
> How did this driver ever work then?  It sounds like there must be
> something else going on here.

=46rom my understanding of the twl4030 TRM assigning a device group
means "<device group> wants this regulator enabled". It does not
change the regulator mode (sleep vs normal or in regulator-framework
terms: REGULATOR_STATUS_NORMAL vs REGULATOR_STATUS_STANDBY).

It usually works, since the default state is normal. If the system
is rebooted from a non-mainline kernel, which left the regulator in
sleep/standby, nothing in the kernel switches it to normal.

-- Sebastian

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW9VMgAAoJENju1/PIO/qasGUP/jZwACL6AK9kAuzQxuiYis9m
/qv9ZlqqXaN2uYt1JG9YKeDMzXETHFLITqzRXbFzFw8lMaCLN23SojDv7mFxz1qb
BfpRQac8YuPMbgQ3BW9afx5HNB5gIJErSQFhkZcmTmatYO2gt22wnIwhHbugCxvO
3UPIWcRuzYOrLHTNmu42dzHqQtX8Tcb0Ql8PflcwmSfKTNMDpvO/J80Fy9tJQdez
FMKYPesm0rP4i1iux3RBEJcU1AaklOjPVHKhZa+18Fh2fgOA4uy8CKScfvebaUHt
7JJffIYn3eK7M4zgtCfiNQDaUw3OGk5DPlF66P/PBx3NuCy0FB7L8yirWC/sfVJY
jTuxSOroZxf24KXSAfqSyJ6syHauCZnJU4+O8/MRjOVEEoFHKcxfF/H6ph2IYcx+
A1k6193ysTO+5dGdlks59W1eByDxQ6TRwwn98FIRZt+jhm4G9ijlDQ778JTlogsb
6lwuqbJ6BEhNHsdk5w+z8AypH2g3qiVlXMAYKJ/2VzxE6i5iZaWHiKCWH1NuYxSL
IgJFU+A1E0ZSJN0p2fEtdqrl0yy5vM0A1XipvA69/CuDQbrP1wJas7bgTK2QZLJ4
9A8cpzE4qG/iojQ4qtR5TILKSbnNmLIjOXSBUqWRKsinQEp5TFPYS2krXUHxpGvf
ape1TKpGcBpYFhF0hI52
=nWhO
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
