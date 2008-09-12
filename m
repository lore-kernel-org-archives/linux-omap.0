From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2: Fix definition of SGX clock register
	bits
Date: Fri, 12 Sep 2008 18:31:34 +0300
Message-ID: <20080912153133.GQ31563@intune.research.nokia.com>
References: <20080827012736.GA10868@intune.research.nokia.com> <1219800687-11044-1-git-send-email-daniel.stone@nokia.com> <alpine.DEB.1.00.0808262258480.4624@utopia.booyaka.com> <20080827051309.GA3594@intune.research.nokia.com> <alpine.DEB.1.00.0808270049120.4624@utopia.booyaka.com> <20080827094217.GC15832@intune.research.nokia.com> <20080911001303.GB21163@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65208 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbYILPbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 11:31:08 -0400
Content-Disposition: inline
In-Reply-To: <20080911001303.GB21163@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: ext Paul Walmsley <paul@booyaka.com>, linux-omap@vger.kernel.org


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2008 at 05:13:03PM -0700, ext Tony Lindgren wrote:
> * Daniel Stone <daniel.stone@nokia.com> [080827 02:47]:
> > On Wed, Aug 27, 2008 at 12:50:37AM -0600, ext Paul Walmsley wrote:
> > > Hello Daniel,
> > >=20
> > > On Wed, 27 Aug 2008, Daniel Stone wrote:
> > >=20
> > > > Yep, looks fine to me: just wasn't really sure what to put.  Should=
 I
> > > > resend, or?
> > >=20
> > > yes, please resend - that will make it convenient for Tony to apply t=
he=20
> > > patches.
> >=20
> > Hi,
> > I'll do that.  Thanks a lot for the review.
>=20
> ping, any news on the updated patch?

Sorry, my bad.  Inlined below.

Cheers,
Daniel


=46rom d8f04561d17adc8c52f8c2d6091bc9897904feb7 Mon Sep 17 00:00:00 2001
=46rom: Daniel Stone <daniel.stone@nokia.com>
Date: Wed, 27 Aug 2008 04:31:59 +0300
Subject: [PATCH] ARM: OMAP2: Fix definition of SGX clock register bits

The GFX/SGX functional and interface clocks have different masks, for
some unknown reason, so split EN_SGX_SHIFT into one each for fclk and
iclk.

Correct according to the TRM and the far more important 'does this
actually work at all?' metric.

Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.h       |    4 ++--
 arch/arm/mach-omap2/cm-regbits-34xx.h |    8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34x=
x.h
index d7d6ffd..ce96270 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1323,7 +1323,7 @@ static struct clk sgx_fck =3D {
 	.name		=3D "sgx_fck",
 	.init		=3D &omap2_init_clksel_parent,
 	.enable_reg	=3D _OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_FCLKEN),
-	.enable_bit	=3D OMAP3430ES2_EN_SGX_SHIFT,
+	.enable_bit	=3D OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT,
 	.clksel_reg	=3D _OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_CLKSEL),
 	.clksel_mask	=3D OMAP3430ES2_CLKSEL_SGX_MASK,
 	.clksel		=3D sgx_clksel,
@@ -1337,7 +1337,7 @@ static struct clk sgx_ick =3D {
 	.parent		=3D &l3_ick,
 	.init		=3D &omap2_init_clk_clkdm,
 	.enable_reg	=3D _OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
-	.enable_bit	=3D OMAP3430ES2_EN_SGX_SHIFT,
+	.enable_bit	=3D OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT,
 	.flags		=3D CLOCK_IN_OMAP3430ES2,
 	.clkdm		=3D { .name =3D "sgx_clkdm" },
 	.recalc		=3D &followparent_recalc,
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm=
-regbits-34xx.h
index ffb695b..fe8e9ef 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -340,8 +340,12 @@
 #define OMAP3430ES1_CLKACTIVITY_GFX_MASK		(1 << 0)
=20
 /* CM_FCLKEN_SGX */
-#define OMAP3430ES2_EN_SGX_SHIFT			1
-#define OMAP3430ES2_EN_SGX_MASK				(1 << 1)
+#define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT		1
+#define OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_MASK		(1 << 1)
+
+/* CM_ICLKEN_SGX */
+#define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT		0
+#define OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_MASK		(1 << 0)
=20
 /* CM_CLKSEL_SGX */
 #define OMAP3430ES2_CLKSEL_SGX_SHIFT			0
--=20
1.5.6.3


--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjKi1UACgkQ68xJuWtYYdXi2QCeIV89DKFR23ijsLU+QOYS69ix
28kAn2tv+aphahdlXFzxKiy3KD0SOSwQ
=4ktT
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--
