From: Felipe Balbi <balbi@ti.com>
Subject: Re: hwmod data duplication (was: Re: [RFC/NOT FOR MERGING 2/3]
 serial: omap: remove hwmod dependency)
Date: Wed, 20 Feb 2013 00:22:15 +0200
Message-ID: <20130219222215.GA12225@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
 <20130214224710.GF11362@atomide.com>
 <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
 <20130219154511.GU17852@n2100.arm.linux.org.uk>
 <20130219163053.GE5724@atomide.com>
 <20130219182257.GV17852@n2100.arm.linux.org.uk>
 <20130219193122.GJ5724@atomide.com>
 <20130219194327.GB8978@arwen.pp.htv.fi>
 <20130219220932.GL5724@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47203 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934252Ab3BSWW0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Feb 2013 17:22:26 -0500
Content-Disposition: inline
In-Reply-To: <20130219220932.GL5724@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 19, 2013 at 02:09:33PM -0800, Tony Lindgren wrote:
> > On Tue, Feb 19, 2013 at 11:31:22AM -0800, Tony Lindgren wrote:
> > > > However... if you think you're going to get away with another total
> > > > rewrite of OMAP device support away from hwmod to a new scheme with=
 a
> > > > new load of huge churn, think again.  Remember, churn is evil.  I've
> > > > complained to you about the amount of churn that OMAP manufactures
> > > > in the past.  Linus has complained about it too.  You can't continue
> > > > like this.
> > >=20
> > > I don't think there's any churn needed here if done properly. It's
> > > mostly a question of dropping duplicate data from hwmod that we
> > > already have available in device tree. That means we can shrink the
> > > hwmod data needed.
> >=20
> > how about starting by removing register addresses and interrupt numbers
> > which are passed by devicetree today ? If you want to move to DT-only
> > now even without all drivers DT-adapted, you can have something like
> > what Marvel folks did for kirkwood:
> >=20
> > static void __init kirkwood_dt_init(void)
> > {
> >=20
> > [ ... ]
> >=20
> > 	if (of_machine_is_compatible("globalscale,dreamplug"))
> > 		dreamplug_init();
> >=20
> > 	if (of_machine_is_compatible("dlink,dns-kirkwood"))
> > 		dnskw_init();
> >=20
> > 	if (of_machine_is_compatible("iom,iconnect"))
> > 		iconnect_init();
> >=20
> > [ ... ]
> >=20
> > 	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
> > }
> >=20
> > those machine-based inits are there just to initialize drivers which
> > aren't converted to DT.
>=20
> Yes we could do that at least partially, but..
> =20
> > this would let you remove all board-files except board-generic.c and
> > remove data which is already passed in via DT. It has the benefit of
> > showing Linus (or whoever cares) that we are working to remove the
> > "churn" while also removing some of the pressure of DT conversion, since
> > there are still details which need to be sorted out (UART function
> > pointers, clock nodes via DT - see Roger's discussion with Rajendra, DMA
> > nodes, etc etc).
>=20
> ..that means massive amount of churn in the board-*.c files to convert
> them to various init functions to be called from board-generic.c and
> removing the ones that are working with DT.

why ? I meant that only what's not converted to DT today should be
handled this way. Also, most of the "churn" is already there
(usb_musb_init(), usb_ehci_init(), etc etc), it just needs to be called
=66rom a different place. We don't need to have one function for each
board, however, maybe we could target by-soc:

if (of_is_compatible("omap3"))
	omap3_init_devices(); /* or whatever you wanna call it */

omap_init_devices() has initialization for everything which isn't DT
adapted today and as we move things to DT, there's a single place to
remove code from.

> I think we're better off making first sure things are usable with
> DT, then just dropping the board-*.c files as we go.
>=20
> And omap4 is the place to start as we only have blaze and panda
> board files. Once DSS, USB and WLAN work with the .dts files, we
> can just drop those board files and make omap4 DT only.

fair enough.

> We may be able to drop omap4 board-*.c files faster than going full
> DT with few selected legacy init functions in board-generic.c for
> things like LCD panel configuration etc.
> =20
> > Only on board-files we're talking about over 13K lines:
> >=20
> >  arch/arm/mach-omap2/board-2430sdp.c          |  289 ------
> >  arch/arm/mach-omap2/board-3430sdp.c          |  602 ------------
> >  arch/arm/mach-omap2/board-3630sdp.c          |  216 -----
> >  arch/arm/mach-omap2/board-4430sdp.c          |  730 ---------------
> >  arch/arm/mach-omap2/board-am3517crane.c      |   97 --
> >  arch/arm/mach-omap2/board-am3517evm.c        |  398 --------
> >  arch/arm/mach-omap2/board-apollon.c          |  342 -------
> >  arch/arm/mach-omap2/board-cm-t35.c           |  769 ----------------
> >  arch/arm/mach-omap2/board-cm-t3517.c         |  302 ------
> >  arch/arm/mach-omap2/board-devkit8000.c       |  648 -------------
> >  arch/arm/mach-omap2/board-flash.c            |  242 -----
> >  arch/arm/mach-omap2/board-flash.h            |   62 --
> >  arch/arm/mach-omap2/board-h4.c               |  347 -------
> >  arch/arm/mach-omap2/board-igep0020.c         |  673 --------------
> >  arch/arm/mach-omap2/board-ldp.c              |  440 ---------
> >  arch/arm/mach-omap2/board-n8x0.c             |  762 ---------------
> >  arch/arm/mach-omap2/board-omap3beagle.c      |  549 -----------
> >  arch/arm/mach-omap2/board-omap3evm.c         |  762 ---------------
> >  arch/arm/mach-omap2/board-omap3logic.c       |  249 -----
> >  arch/arm/mach-omap2/board-omap3pandora.c     |  623 -------------
> >  arch/arm/mach-omap2/board-omap3stalker.c     |  432 ---------
> >  arch/arm/mach-omap2/board-omap3touchbook.c   |  391 --------
> >  arch/arm/mach-omap2/board-omap4panda.c       |  467 ----------
> >  arch/arm/mach-omap2/board-overo.c            |  556 -----------
> >  arch/arm/mach-omap2/board-rm680.c            |  165 ----
> >  arch/arm/mach-omap2/board-rx51-peripherals.c | 1276 ------------------=
--------
> >  arch/arm/mach-omap2/board-rx51-video.c       |   89 --
> >  arch/arm/mach-omap2/board-rx51.c             |  128 ---
> >  arch/arm/mach-omap2/board-rx51.h             |   11 -
> >  arch/arm/mach-omap2/board-ti8168evm.c        |   62 --
> >  arch/arm/mach-omap2/board-zoom-debugboard.c  |  139 ---
> >  arch/arm/mach-omap2/board-zoom-display.c     |  147 ---
> >  arch/arm/mach-omap2/board-zoom-peripherals.c |  304 ------
> >  arch/arm/mach-omap2/board-zoom.c             |  155 ----
> >  arch/arm/mach-omap2/board-zoom.h             |   10 -
> >  35 files changed, 13434 deletions(-)
> >=20
> > If we remove all addresses and interrupts, numbers look even better.
>=20
> Yeah. Let's start with omap4 first when DSS + USB + WLAN work.

USB is going to be ready for v3.10, likely Wlan too.

--=20
balbi

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRI/sXAAoJEIaOsuA1yqREUuYQAKyH4zJgMmsb8UjcLl26q7lu
q7GYJ+A0RcJ6Iq9lwGyIZz/8o3ZkuZk+UiYMl/bEvpJjXo52kegvn50a/m3Ws1qM
rKbc2+KoAH1OdyN87lz337tGFnBJ/mpffGECksjk6nnzFmiAwdJ3ZBOAjvSbGRGY
yPdfhTCne/mMKQhpNnoj6117nWkuQ0gn1t4FUhbOiHc8nCTyq0ZCgEE0x16cQN7m
2H/7ZOGZHX+YMsyuKb5dus0vBLJ/kjTq18rrDbt+U5Qcg5H2e1yghybgkOi+MhjT
vIp/9d6SJhz8CC9x1Zp+N5dJd9DUXheZgEUxcGaQ41cn2Wvdd66IGwD7okiv6qd/
pace8ydfYVIrBOlpF2zzBv2ooP4nwyiZOEMBarSaCsO3WTBg4sFxPQFzZM1t2CG+
ipqFsCGsY+msOz4b+CCUb/Pdq0iSO845EosWzzG+XOo25KNUOX/6aQYlZ3/yRKA3
4QpjPySavAyRg724J+w0p2klCEeI6CS63caUxs6AUZjblQKNz896ee9dhJphj7bz
iMhzAlxs8xNcQXDFmIiF/hZQiYF2VUQzDqH0cEWvvgW0R9YjiWlTHBTpWAKrc2n/
emdaWZv1xeq1oGBK4vjyN0urDyziCyY7IjSQR/cN4rrkd6BBTj8ozgr0Tq9TpD68
ZoQuqFV43TPHqy0vxqfD
=fQZw
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
