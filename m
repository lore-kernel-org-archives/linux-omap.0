From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 18:42:35 +0200
Message-ID: <20130215164235.GA20840@arwen.pp.htv.fi>
References: <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215101610.GR17852@n2100.arm.linux.org.uk>
 <511E3797.2070802@ti.com>
 <20130215132726.GT17852@n2100.arm.linux.org.uk>
 <511E38C3.7080404@ti.com>
 <20130215163031.GA5724@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46620 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab3BOQmw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 11:42:52 -0500
Content-Disposition: inline
In-Reply-To: <20130215163031.GA5724@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 15, 2013 at 08:30:32AM -0800, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130215 05:34]:
> > On Friday 15 February 2013 06:57 PM, Russell King - ARM Linux wrote:
> > >On Fri, Feb 15, 2013 at 06:56:47PM +0530, Santosh Shilimkar wrote:
> > >>Whats your view on use of arch_ioremap_caller() hook ? This can allow
> > >>us to avoid the dual ioremap() issue discussed here if the hook
> > >>maintains the list of mapped ios.
> > >>
> > >>I was even thinking of having such intelligence within the core
> > >>ioremap code but thought that might be too invasive.
> > >
> > >Why do you even need it?  There's no problem with ioremapping the same
> > >space multiple times (you end up with multiple mappings but that
> > >shouldn't be a problem, except for the additional space used.)
> > >
> > It just waste of iospace and Tony insisted to have just single ioremap()
> > hence all this discussion
>=20
> The main goal is to avoid duplicating data both in hwmod and DT.
> That's pretty much solved as we can have the driver probe populate
> the common data for hwmod from DT as Santosh has already demonstrated.
>=20
> Then we also want the driver specific idle and reset code to be done
> in the drivers rather than in hwmod and glue it together with hwmod
> using runtime PM. The biggest issue there is how do we reset and idle
> some piece of hardware for PM purposes when there's no driver loaded.

right, this will be a tough nut to crack.

I guess the only way would be reset all IPs early in the boot process,
before even creating the platform-devices. Can we do that ? I mean, from
omap_device_build_from_dt() we have access to address space of all
devices, through ti,hwmods we can figure out which hwmods are linked to
that particular device, so whenever you build a device, you could just
call _reset().

The only problem is that now omap_device_build_from_dt() is called after
we notify that a new device/driver pair has been registered with the
platform_bus, right ? So we would still need a way to call _reset() for
those which are on DTS but don't have a driver bound to them...

--=20
balbi

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHmV7AAoJEIaOsuA1yqRELCUP+wQOluKRCGzp/52Rcmx5R0Yz
1zbg2pQch0zqXC47aKrPqMwzhoMBKyid1HZn0jVB66WBcCCl4MK15dWg0jqZw5lw
C30L6kyn19JIsDOmOPGBk7oXz0u3VI4pMAjJJnwfzBeYATstTTUHreqogDYTTy8P
O2g8TusH3fTtOO+jKeuOpqk3EodwR4XMo9H8lNX69Js7nGai6HJl+RWxMYzv7Xj/
dvZBZBU8jAuZsdvxUvc933PAq439Dxr6/+2sY4W2zb378kD+o2kEySH5qyMgfXD9
K6axcQzo7TaOVqa10eP4Qs1Bf+FdGzffkhX5es+4JN9w2jsOHvfXVN5Heu6Ol+w0
+ftWxqEJa94KsmhIVqs9J1I+CZ5yCL8/6vYwzzddAEn21kn9Peluc2yr5nl0m5pD
sjKPBADDFygHFzcC3g0zjmRVG2WmOHfNRCudENzijTC9n+jpdXtHT7tZ0IzPk6LX
9YS1LGsk1V9aVmJ2Iv/m6QDEHNhTj4zPbG2t5nJsTEI96Z9WzWoa0alVgeii+Ull
LjR8RxFkAtX6gvpKOjGha6gursn0g3diUapv9+41LSDr+fv3vy77EqfxzOUOVSJ8
wAwYDP5vUorcqDrcrK9s0HQ8UEnuGDhA9om5CqiKvJ5fpVdJzayefsaMQb4wbjHE
J5bNXrFO9LmPtejcEZj8
=oqYk
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
