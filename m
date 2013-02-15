From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 08:46:27 +0200
Message-ID: <20130215064626.GB30038@arwen.pp.htv.fi>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
 <20130214224710.GF11362@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47530 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab3BOGqh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 01:46:37 -0500
Content-Disposition: inline
In-Reply-To: <20130214224710.GF11362@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2013 at 02:47:10PM -0800, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [130214 13:44]:
> > Hi,
> >=20
> > On Thu, 14 Feb 2013, Paul Walmsley wrote:
> >=20
> > > So instead of something bus-specific like that, a better way would be=
 to=20
> > > use something like:
> > >=20
> > > va =3D dev->bus->ioremap( ... );
> > > va =3D dev->bus->iounmap( ... );
> >=20
> > Something like this is what I was thinking.  Obviously there would be m=
ore
> > patches needed, for the various arches, etc.; and I'm not convinced that
> > the function pointer init is done at the right time yet. Comments welco=
me.
> >=20
> >=20
> > - Paul
> >=20
> >=20
> > From: Paul Walmsley <paul@pwsan.com>
> > Date: Thu, 14 Feb 2013 13:49:58 -0700
> > Subject: [PATCH] EXPERIMENTAL: device/ARM: allow buses to override iore=
map*()
> >  and iounmap()
> >=20
> > On some hardware, such as OMAP, the bus abstraction code needs to call
> > ioremap(), since some SoC-integration registers are located in the
> > device address space.  But generic device drivers should be able to
> > call ioremap() from driver code, for the majority of situations where
> > this isn't necessary.  This experimental patch allows Linux bus abstrac=
tion
> > code to override all of the ioremap*() and iounmap() functions.  In the=
 OMAP
> > case, this would be used to return the previously-mapped address range =
=66rom
> > the bus code, when called for the device's register area.  This would a=
void
> > a duplicate TLB mapping for that space.
> >=20
> > This might also be useful as a generic replacement for pci_ioremap_bar(=
).
> >=20
> > Compile-tested only.
>=20
> The other option could be to allow custom ioremap function pointers=20
> based on address range in __arm_ioremap_pfn_caller() the same way as
> the SoC specific static mappings are allowed. That would require adding
> a function pointer to struct map_desc.
>=20
> Maybe that would do the trick?

I'm not sure we should even try that. I mean, eventually (maybe in 100
years) we wouldn't mach-* at all and even struct map_desc would be
dynamically initialized by data passed in via DTB, right ? Just consider
Arnd's patch for the "machine_desc-less" DT boot. If we add a function
pointer to struct map_desc, it will just become yet another function
pointer to be removed later.

--=20
balbi

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHdnCAAoJEIaOsuA1yqREyq8P/1uQv8UDvjiST+/YhvTKd8W9
pOq4/l+G4vMog6+WbS7bEctKoQHlskQ+HY5sjOxgm6hXAkN5be1c0rD3BdYFhyW4
uyqt2cdMUh3pN/yu1/MM6AW/eSEM/yR7011HJrfAUZye56GYNHDkbjKkalOBzT2I
eDsD+lT4fgE7QBOGBw84VpVf15DKqHlwSAUy/bqownkayKU5DCORvbFxi70mV+D2
RLxL/zqQAGZ1QEi/RLAyMBunr2sL75RqD9dRwqU9qS6Kyv3T+VK1BwBuBCgRqD0Z
+VVSXSRpSfo/7TZfauemFA82iwyzqcA/OGGlpr2pVMYNHetThihDaghD9GDll0+x
FcuGiWtVCELLIH6LBraFpvrBz7rPDDH6Hcr3+638JDQdjyn9M9Pj7quJHojirByn
aDRnuBls7pCcAI14yGXH+dZl8RLT7qzKszuC4FmccuQ0pIdBY9n/OlaouAiCLzfz
nXSUJW9Qz6VbHZEQ6rdCqveADn10DiSYIhvYlGAvg3jrYyYZhx+BuhydZItDysnQ
m74zriA1WSIKX37vwI71UgxYy6jnK5cxqrR8cs3Fm5AV+59LBc8vCDpEYrvDm6OD
E1+6VY8I5/GzRouLJomOv4ULIpJ/+J4s39WBh2FDJkDriBc+HNM7pyjEX5fDKK4c
F4TaK/bDTh69q4hy+Rsz
=bXSH
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
