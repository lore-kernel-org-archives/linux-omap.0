From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: N900 v3.19-rc5 arm atags_to_fdt.c is broken
Date: Mon, 26 Jan 2015 17:23:10 +0100
Message-ID: <201501261723.10505@pali>
References: <201501232239.55801@pali> <201501232336.36187@pali>
 <20150126161454.GE28663@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8686844825247582791=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150126161454.GE28663@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Russell King <linux@arm.linux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nicolas Pitre <nico@linaro.org>, Sebastian Reichel <sre@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Laura Abbott <lauraa@codeaurora.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============8686844825247582791==
Content-Type: multipart/signed;
  boundary="nextPart1746215.nYFFRZPYm0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1746215.nYFFRZPYm0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 26 January 2015 17:14:55 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150123 14:39]:
> > On Friday 23 January 2015 22:39:55 Pali Roh=C3=A1r wrote:
> > > Hello,
> > >=20
> > > when I boot zImage with appended DT n900 in qemu
> > > fdt_open_into() function called from file
> > > arch/arm/boot/compressed/atags_to_fdt.c (in function
> > > atags_to_fdt) always returns -FDT_ERR_NOSPACE.
> > >=20
> > > It means that all ATAGS (including cmdline arguments)
> > > passed by bootloader are ignored.
> > >=20
> > > On real n900 device I see that booted DT version also
> > > ignore cmdline arguments from bootloader. I cannot debug
> > > decompress code on real device, but I think it is same
> > > problem as in qemu.
> >=20
> > Looks like this quick patch is fixing above problem:
> >=20
> > diff --git a/arch/arm/boot/compressed/head.S
> > b/arch/arm/boot/compressed/head.S index 68be901..4a7d75b
> > 100644
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -268,7 +268,7 @@ restart:	adr	r0, LC0
> >=20
> >  		 * area.  No GOT fixup has occurred yet, but none of=20
the
> >  		 * code we're about to call uses any global variable.
> >  	=09
> >  		*/
> >=20
> > -		add	sp, sp, #0x10000
> > +		add	sp, sp, #0x20000
> >=20
> >  		stmfd	sp!, {r0-r3, ip, lr}
> >  		mov	r0, r8
> >  		mov	r1, r6
> >=20
> > @@ -289,7 +289,7 @@ restart:	adr	r0, LC0
> >=20
> >  		bleq	atags_to_fdt
> >  	=09
> >  		ldmfd	sp!, {r0-r3, ip, lr}
> >=20
> > -		sub	sp, sp, #0x10000
> > +		sub	sp, sp, #0x20000
> >=20
> >  #endif
> > =20
> >  		mov	r8, r6			@ use the appended device tree
>=20
> Nico, got any ideas about this one? This seems like a
> regression somewhere..
>=20
> Regards,
>=20
> Tony

$ du -b arch/arm/boot/dts/omap3-n900.dtb=20
70212   arch/arm/boot/dts/omap3-n900.dtb

$ echo $((0x10000))
65536

I would say, problem is because omap3-n900 binary DT is too large

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1746215.nYFFRZPYm0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTGae4ACgkQi/DJPQPkQ1KeuwCfb7Wd+CVB+Ft/jVbF2F8rS1eA
ajMAnjnsCQNHqH+Gqj2uoieNgESeIaPQ
=FX6k
-----END PGP SIGNATURE-----

--nextPart1746215.nYFFRZPYm0--


--===============8686844825247582791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8686844825247582791==--
