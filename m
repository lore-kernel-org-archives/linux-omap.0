From: Felipe Balbi <balbi@ti.com>
Subject: hwmod data duplication (was: Re: [RFC/NOT FOR MERGING 2/3] serial:
 omap: remove hwmod dependency)
Date: Tue, 19 Feb 2013 21:43:28 +0200
Message-ID: <20130219194327.GB8978@arwen.pp.htv.fi>
References: <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
 <20130214224710.GF11362@atomide.com>
 <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
 <20130219154511.GU17852@n2100.arm.linux.org.uk>
 <20130219163053.GE5724@atomide.com>
 <20130219182257.GV17852@n2100.arm.linux.org.uk>
 <20130219193122.GJ5724@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58565 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933048Ab3BSTni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 14:43:38 -0500
Content-Disposition: inline
In-Reply-To: <20130219193122.GJ5724@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 19, 2013 at 11:31:22AM -0800, Tony Lindgren wrote:
> > However... if you think you're going to get away with another total
> > rewrite of OMAP device support away from hwmod to a new scheme with a
> > new load of huge churn, think again.  Remember, churn is evil.  I've
> > complained to you about the amount of churn that OMAP manufactures
> > in the past.  Linus has complained about it too.  You can't continue
> > like this.
>=20
> I don't think there's any churn needed here if done properly. It's
> mostly a question of dropping duplicate data from hwmod that we
> already have available in device tree. That means we can shrink the
> hwmod data needed.

how about starting by removing register addresses and interrupt numbers
which are passed by devicetree today ? If you want to move to DT-only
now even without all drivers DT-adapted, you can have something like
what Marvel folks did for kirkwood:

static void __init kirkwood_dt_init(void)
{

[ ... ]

	if (of_machine_is_compatible("globalscale,dreamplug"))
		dreamplug_init();

	if (of_machine_is_compatible("dlink,dns-kirkwood"))
		dnskw_init();

	if (of_machine_is_compatible("iom,iconnect"))
		iconnect_init();

[ ... ]

	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
}

those machine-based inits are there just to initialize drivers which
aren't converted to DT.

this would let you remove all board-files except board-generic.c and
remove data which is already passed in via DT. It has the benefit of
showing Linus (or whoever cares) that we are working to remove the
"churn" while also removing some of the pressure of DT conversion, since
there are still details which need to be sorted out (UART function
pointers, clock nodes via DT - see Roger's discussion with Rajendra, DMA
nodes, etc etc).

Only on board-files we're talking about over 13K lines:

 arch/arm/mach-omap2/board-2430sdp.c          |  289 ------
 arch/arm/mach-omap2/board-3430sdp.c          |  602 ------------
 arch/arm/mach-omap2/board-3630sdp.c          |  216 -----
 arch/arm/mach-omap2/board-4430sdp.c          |  730 ---------------
 arch/arm/mach-omap2/board-am3517crane.c      |   97 --
 arch/arm/mach-omap2/board-am3517evm.c        |  398 --------
 arch/arm/mach-omap2/board-apollon.c          |  342 -------
 arch/arm/mach-omap2/board-cm-t35.c           |  769 ----------------
 arch/arm/mach-omap2/board-cm-t3517.c         |  302 ------
 arch/arm/mach-omap2/board-devkit8000.c       |  648 -------------
 arch/arm/mach-omap2/board-flash.c            |  242 -----
 arch/arm/mach-omap2/board-flash.h            |   62 --
 arch/arm/mach-omap2/board-h4.c               |  347 -------
 arch/arm/mach-omap2/board-igep0020.c         |  673 --------------
 arch/arm/mach-omap2/board-ldp.c              |  440 ---------
 arch/arm/mach-omap2/board-n8x0.c             |  762 ---------------
 arch/arm/mach-omap2/board-omap3beagle.c      |  549 -----------
 arch/arm/mach-omap2/board-omap3evm.c         |  762 ---------------
 arch/arm/mach-omap2/board-omap3logic.c       |  249 -----
 arch/arm/mach-omap2/board-omap3pandora.c     |  623 -------------
 arch/arm/mach-omap2/board-omap3stalker.c     |  432 ---------
 arch/arm/mach-omap2/board-omap3touchbook.c   |  391 --------
 arch/arm/mach-omap2/board-omap4panda.c       |  467 ----------
 arch/arm/mach-omap2/board-overo.c            |  556 -----------
 arch/arm/mach-omap2/board-rm680.c            |  165 ----
 arch/arm/mach-omap2/board-rx51-peripherals.c | 1276 ----------------------=
----
 arch/arm/mach-omap2/board-rx51-video.c       |   89 --
 arch/arm/mach-omap2/board-rx51.c             |  128 ---
 arch/arm/mach-omap2/board-rx51.h             |   11 -
 arch/arm/mach-omap2/board-ti8168evm.c        |   62 --
 arch/arm/mach-omap2/board-zoom-debugboard.c  |  139 ---
 arch/arm/mach-omap2/board-zoom-display.c     |  147 ---
 arch/arm/mach-omap2/board-zoom-peripherals.c |  304 ------
 arch/arm/mach-omap2/board-zoom.c             |  155 ----
 arch/arm/mach-omap2/board-zoom.h             |   10 -
 35 files changed, 13434 deletions(-)

If we remove all addresses and interrupts, numbers look even better.

--=20
balbi

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRI9XfAAoJEIaOsuA1yqREMnsP/28Bvlv/nx21QFO5t8gWMCYw
FHUMS7c/+Di/RtByGwd66lLZ6DNMs9iCM7b1saOqvinZScnYnG1L7+vwrotCLq7g
12IfbtjaFO0VqcWH7ty75i1HSOiqvSHECGUwk2+ZxV9cFsuNadFKrO0UM+8bLgfk
4BZGE6+BRUM1yDn0rikudBRUQNJaMIW16ZVIEyvT6hnG8HhSvwlOB7VLU2Bn/pSg
F4kqfHHJEgAdVzUUwNYyyCmW8nPLuKF4TQStSvSoMJ61kBIWSHw/ema9hWJCCWuF
8boA659n4Tlc+Rlfycq73VSb2jNkUFnsqZVrCybRdOu9DqCRuHk5EsfTWJsayRXc
XN2E3W7pcabjZ2O8/uxMwkyZisLYngftZe/kmFQ5RAYP4WaWhbeZzKi3HwxYXCPI
69tRq7ZmaADCSs5BazMvWK0+QK3ATy3jfGfX0xyF+dddPm12Qe+nLWyJtmNjLe7Z
mqSEO0pOg22RrGTRDfIwFtiXa7jv8yybNCVilsvFS3RvaQ/O0kxk/7cfMVAS5mzc
0PWljYRU7WWsOKVk6B/DfeIT2LAYnP3BHed6Y2DzqeczD1fSvOnFyc1mzuBJj4cM
m8d+GLDwQvwxCN77AO96BQ2FEATSphKlF1lZe27F/7/lVZmyPis45W8JwPXTxnrO
DQuUdiCIy0+xVda8+Slc
=+qkp
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
