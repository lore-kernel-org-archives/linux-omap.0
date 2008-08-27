From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2: Fix definition of SGX clock register
	bits
Date: Wed, 27 Aug 2008 08:13:09 +0300
Message-ID: <20080827051309.GA3594@intune.research.nokia.com>
References: <20080827012736.GA10868@intune.research.nokia.com> <1219800687-11044-1-git-send-email-daniel.stone@nokia.com> <alpine.DEB.1.00.0808262258480.4624@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53591 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbYH0FMQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 01:12:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808262258480.4624@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@booyaka.com>
Cc: linux-omap@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2008 at 11:05:42PM -0600, ext Paul Walmsley wrote:
> Hello Daniel,

Hi,

> On Wed, 27 Aug 2008, Daniel Stone wrote:
> > The GFX/SGX functional and interface clocks have different masks, for
> > some unknown reason, so split EN_SGX_SHIFT into one each for fclk and
> > iclk.
>=20
> thanks for the fix, this looks mostly good - one comment:
>=20
> > diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap=
2/cm-regbits-34xx.h
> > index ffb695b..06a78a7 100644
> > --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> > +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> > @@ -339,9 +339,11 @@
> >  #define OMAP3430ES1_CLKACTIVITY_GFX_SHIFT		0
> >  #define OMAP3430ES1_CLKACTIVITY_GFX_MASK		(1 << 0)
> > =20
> > -/* CM_FCLKEN_SGX */
> > -#define OMAP3430ES2_EN_SGX_SHIFT			1
> > -#define OMAP3430ES2_EN_SGX_MASK				(1 << 1)
> > +/* CM_FCLKEN_SGX/CM_ICLKEN_SGX */
> > +#define OMAP3430ES2_EN_SGX_FSHIFT			1
> > +#define OMAP3430ES2_EN_SGX_FMASK			(1 << 1)
> > +#define OMAP3430ES2_EN_SGX_ISHIFT			0
> > +#define OMAP3430ES2_EN_SGX_IMASK			(1 << 0)
>=20
> To keep these consistent with prior practice in prm-regbits-34xx.h for
> name collisions, could you change the above to look something like:
>=20
> /* CM_FCLKEN_SGX */
> #define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT       1
> #define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_MASK        (1 << 1)
>=20
> /* CM_ICLKEN_SGX */
> #define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT       0
> #define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_MASK        (1 << 0)
>=20
> Ugly, but unambiguous.

Yep, looks fine to me: just wasn't really sure what to put.  Should I
resend, or?

Cheers,
Daniel

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki04mUACgkQ68xJuWtYYdVAdACfSAnQN9civybkQcjndxjE6h9B
DY0AoKgG63rDPmXOi7l9FZT5nT2BATJe
=N4+m
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
