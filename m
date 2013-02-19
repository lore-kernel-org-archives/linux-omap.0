From: Felipe Balbi <balbi@ti.com>
Subject: Re: hwmod data duplication (was: Re: [RFC/NOT FOR MERGING 2/3]
 serial: omap: remove hwmod dependency)
Date: Wed, 20 Feb 2013 00:51:08 +0200
Message-ID: <20130219225108.GA12474@arwen.pp.htv.fi>
References: <20130214224710.GF11362@atomide.com>
 <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
 <20130219154511.GU17852@n2100.arm.linux.org.uk>
 <20130219163053.GE5724@atomide.com>
 <20130219182257.GV17852@n2100.arm.linux.org.uk>
 <20130219193122.GJ5724@atomide.com>
 <20130219194327.GB8978@arwen.pp.htv.fi>
 <20130219220932.GL5724@atomide.com>
 <20130219222215.GA12225@arwen.pp.htv.fi>
 <20130219223128.GM5724@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38631 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933030Ab3BSWvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 17:51:19 -0500
Content-Disposition: inline
In-Reply-To: <20130219223128.GM5724@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 19, 2013 at 02:31:28PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130219 14:26]:
> > On Tue, Feb 19, 2013 at 02:09:33PM -0800, Tony Lindgren wrote:
> > >=20
> > > ..that means massive amount of churn in the board-*.c files to convert
> > > them to various init functions to be called from board-generic.c and
> > > removing the ones that are working with DT.
> >=20
> > why ? I meant that only what's not converted to DT today should be
> > handled this way. Also, most of the "churn" is already there
> > (usb_musb_init(), usb_ehci_init(), etc etc), it just needs to be called
> > from a different place. We don't need to have one function for each
> > board, however, maybe we could target by-soc:
> >=20
> > if (of_is_compatible("omap3"))
> > 	omap3_init_devices(); /* or whatever you wanna call it */
> >=20
> > omap_init_devices() has initialization for everything which isn't DT
> > adapted today and as we move things to DT, there's a single place to
> > remove code from.
>=20
> And the pdata for that comes from where? :) I think that means
> converting each board-*.c to device init functions, which leads to
> the churn I was mentioning..

fair enough, still a lot less churn ;-)

--=20
balbi

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJAHcAAoJEIaOsuA1yqRE0CAQAKxkacGnZK2G5SMVrbxjBC7k
HkvEcK3VEHCamj3B98kmZdpOp0e5jNI8Xt3e61U06um46pbat65d1dNIxwR9xoCV
KdpjbgVASFxrXmldGR2ELsW4HMx7YT48QyUqtY+REKfsVadOb5dHVH6+MbTgsz/8
JhQPdF+2/NS8oEKqzZJp1cViDhJgdKAdy9473luMYSWn1DEdVBWzFPhu6V9a++Ty
a/orLhI1aohNfeVLOf4PYbdVQrmKZxMD0a7AfVUtpCZY4PoUU2cl8DABl1B9zmHd
gp2O2J0NwOdnZQ7L/Aptr5DnlJ2prMZQZarQLk7iFCpN9MlPYC3wP133hi9C1eoh
XYfuN9UvHaOImcaVptWY2bMU/vErozzqIp/6/FI4FeNPY1gwPfSPW9gEIlhqHyEQ
kDryRlQRXbhDMI8qg7sZIeWQuv3jwJwR/1gYNav1iyqMesG8SGVa0W5IZxSU5tFI
2OEumSoOG6sUiD85BNkf7VUH47yLiYUI7UG40RpDPb5nFHKR0NX68DK4l9L8T10+
FLAdh6IaM268QRm1cUN7R15K0HRwTPgt3LQdv8iPXngpFRZNQG9uTS4p355v6a/F
e2fWnRRZv41o6APVmOnFnGYoKko41iIH9Vks9c0uBlhMGflRPQNg0PGz0TKvMaSy
hiq5S09oTn3K6aZwODfC
=xnjt
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
