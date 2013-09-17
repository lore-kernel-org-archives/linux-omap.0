From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v4 1/2] ARM: OMAP: Add secure function omap_smc3() which calling instruction smc #1
Date: Tue, 17 Sep 2013 17:53:23 +0200
Message-ID: <201309171753.24433@pali>
References: <20130916171023.GA17477@localhost.localdomain> <20130917154331.GA9994@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1783934.necBAGRBmD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130917154331.GA9994@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Martin <Dave.Martin@arm.com>, =?utf-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE?= =?utf-8?q?_=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>, "nm@ti.com" <nm@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>, "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--nextPart1783934.necBAGRBmD
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 17 September 2013 17:43:31 Tony Lindgren wrote:
> * Dave Martin <Dave.Martin@arm.com> [130916 10:18]:
> > On Sat, Sep 14, 2013 at 10:37:12AM +0100, Pali Roh=C3=A1r wrote:
> > > On Sunday 08 September 2013 09:43:29 Pali Roh=C3=A1r wrote:
> > > > + */
> > > > +ENTRY(omap_smc3)
> > > > +	stmfd	sp!, {r4-r11, lr}
> > > > +	mov	r12, r0		@ Copy the secure service ID
> > > > +	mov	r6, #0xff	@ Indicate new Task call
> > > > +	dsb			@ Memory Barrier (not sure if needed, copied
> > > > from omap_smc2) +	smc	#1		@ Call PPA service
> > > > +	ldmfd	sp!, {r4-r11, pc}
> > > > +ENDPROC(omap_smc3)
> > > > +
> > > >=20
> > > >  ENTRY(omap_modify_auxcoreboot0)
> > > > =20
> > > >  	stmfd   sp!, {r1-r12, lr}
> > > >  	ldr	r12, =3D0x104
> > >=20
> > > Dave, it is ok now?
> >=20
> > Yes, that's sufficient to warn people to stop and think (at
> > least, if someone copy-pastes it, they will likely
> > highlight the possible error by copy-pasting the comment
> > too).  Thanks.
> >=20
> > Acked-by: Dave Martin <Dave.Martin@arm.com>
>=20
> Have you guys checked how this works with the recently posted
> "[PATCH v6 0/5] ARM: support for Trusted Foundations secure
> monitor" series?
>=20
> Regards,
>=20
> Tony

Hello,

this code looks like some Tegra and "Trusted Foundations"=20
specific. There is Note: The API followed by Trusted Foundations=20
does *not* follow the SMC calling conventions.  Also code calling=20
smc #0 instruction, so in my opinion for rx51 it is useless.

Tony, can you include this two rx51 secure patches (patch v4 1/2=20
and patch v2 2/2)? Or is there some any other problem?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1783934.necBAGRBmD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlI4evQACgkQi/DJPQPkQ1I6bgCfbbfsNJlk6xTy+LKKMJ2fjk8R
xhcAoJUvGZ8O+650grdDDw5sxVbwFzEM
=ueLy
-----END PGP SIGNATURE-----

--nextPart1783934.necBAGRBmD--
