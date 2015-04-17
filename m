From: Sebastian Reichel <sre@kernel.org>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Fri, 17 Apr 2015 20:41:56 +0200
Message-ID: <20150417184156.GA3326@earth>
References: <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk>
 <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150415163108.GB2033@earth>
 <20150416160858.GH18048@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46337 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905AbbDQSm3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Apr 2015 14:42:29 -0400
Content-Disposition: inline
In-Reply-To: <20150416160858.GH18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2015 at 09:08:58AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [150415 09:32]:
> > Hi,
> >=20
> > On Thu, Apr 09, 2015 at 02:48:43PM +0100, Russell King - ARM Linux wrot=
e:
> > > On Thu, Apr 09, 2015 at 12:06:58AM +0100, Russell King - ARM Linux wr=
ote:
> > > > On Tue, Apr 07, 2015 at 08:22:08AM -0700, Tony Lindgren wrote:
> > > > > Works for me. The above needs the following fix folded in to buil=
d:
> > > > >=20
> > > > > --- a/arch/arm/mm/proc-v7.S
> > > > > +++ b/arch/arm/mm/proc-v7.S
> > > > > @@ -532,7 +532,7 @@ __v7_ca9mp_proc_info:
> > > > >  __v7_ca8_proc_info:
> > > > >  	.long	0x410fc080
> > > > >  	.long	0xff0ffff0
> > > > > -	__v7_proc __v7_ca8mp_proc_info, proc_fns =3D ca8_processor_func=
tions
> > > > > +	__v7_proc __v7_ca8_proc_info, __v7_setup, proc_fns =3D ca8_proc=
essor_functions
> > > > >  	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
> > > > > =20
> > > > >  #endif	/* CONFIG_ARM_LPAE */
> > > >=20
> > > > Thanks, merged into the original patch.
> > >=20
> > > Do you want to give me an ack for this, thanks?
> >=20
> > I tried to test this together with Tony's follow up patch, but I get
> > this after applying the patch to v4.0:
> >=20
> > sre@earth ~/src/linux [430973-fix] % make -j4
> >   CHK     include/config/kernel.release
> >   CHK     include/generated/uapi/linux/version.h
> >   CHK     include/generated/utsrelease.h
> > make[1]: 'include/generated/mach-types.h' is up to date.
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   AS      arch/arm/mm/proc-v7.o
> > arch/arm/mm/proc-v7.S: Assembler messages:
> > arch/arm/mm/proc-v7.S:535: Error: invalid operands (*ABS* and .text sec=
tions) for `|'
> > arch/arm/mm/proc-v7.S:535: Error: invalid operands (*ABS* and .text sec=
tions) for `|'
> > scripts/Makefile.build:294: recipe for target 'arch/arm/mm/proc-v7.o' f=
ailed
> > make[1]: *** [arch/arm/mm/proc-v7.o] Error 1
> > Makefile:947: recipe for target 'arch/arm/mm' failed
> > make: *** [arch/arm/mm] Error 2
> > make: *** Waiting for unfinished jobs....
>=20
> Maybe test the version in Linux next:
>=20
> a6d746789825 ("ARM: proc-v7: avoid errata 430973 workaround for non-Corte=
x A8 CPUs")

DONE with your your patch added on top:

Tested-By: Sebastian Reichel <sre@kernel.org>

(on N900)

I guess we should also drop the CONFIG_ARM_ERRATA_430973 check from
pdata-quirks' nokia_n900_legacy_init() and just enable it unconditionally.

-- Sebastian

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVMVPsAAoJENju1/PIO/qaOtkP/jFkavRBuGw3nGnsJI9XBPjW
YmMKlXScD/PZgHsknh+G3ddKp8zK/S9qGTJmWOwIswhvHqSaUV3n1IEiYIFyrazI
MKKZDejYt5vYsYgRiCfU1/08EeLVeuFjTmU2Zcv7UCI2p5132ZeHQ5VbMJhUFDL3
ycq42v+hi2ZAIcvBQrvJ7CFQwjIRr4PF31KNZQF24Ag6sh8z5Tfgd+2MWgk08zcW
ccs/91idUOQz6owwNcf4xFN4+e9PYVG0T2BzCX+up6ZClhgr47pCGHlUnPbUrbVK
goprwoum/oWNvHHaYzbvEIWw7XtQTeCeA1exle0hdF8yJjIm8czJoKxoQnRPYJwD
rdxbaL/7N3E8p0nqMn3mPnKvoREt/Q4UrgY0H4iAvOyZ7MORXms84OEznHGQTRKM
FFEGTfdwJ/fktMjdXekWtR8HqyH78F++Z+cb2OtZcOFuRNJE/UPz8msJlEnUAemv
rRWZTqzFhkoplfAk8pHFv0Cp39Sdk8FtuYg6yhOGCpPHTYSpcwwsTGC821JvZe1G
3FkeYgGLHC8FWNBXPpTwEL7sjK+WUkKn0mt6XpjS+tm6ZI4j6jJn31Oh1I79XW+V
g4DTV1mgbSqBCdn8oc/gFJKqPHBc9YCbs5gOa1/xU+FFdj5N3mji74V6Pcbye8M+
s2rjm1cv4yogirnzgOE3
=PtbP
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
