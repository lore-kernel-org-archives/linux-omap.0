From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Mon, 7 Jul 2014 10:10:24 -0500
Message-ID: <20140707151024.GJ5582@saruman.home>
References: <20140617131935.GB9070@saruman.home>
 <20140701194704.GG13396@saruman.home>
 <20140702081142.GU28884@atomide.com>
 <20140707104727.GM28884@atomide.com>
 <20140707104944.GS3705@n2100.arm.linux.org.uk>
 <20140707110249.GO28884@atomide.com>
 <53BA8983.3030803@ti.com>
 <20140707121512.GT3705@n2100.arm.linux.org.uk>
 <20140707123925.GW28884@atomide.com>
 <20140707134008.GU3705@n2100.arm.linux.org.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ed/6oDxOLijJh8b0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44117 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbaGGPLH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Jul 2014 11:11:07 -0400
Content-Disposition: inline
In-Reply-To: <20140707134008.GU3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

--ed/6oDxOLijJh8b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 07, 2014 at 02:40:08PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 07, 2014 at 05:39:26AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [140707 05:17]:
> > > On Mon, Jul 07, 2014 at 05:20:27PM +0530, Sekhar Nori wrote:
> > > > OMAP4430 had L2 cache controller version r2p0 (per the public TRM) =
which
> > > > does not have this register. So unless there is a ROM API that was
> > > > introduced after OMAP4430, this would not be there even for other
> > > > OMAP4s. Public TRM of OMAP4470 does not indicate an API for this.
> > > >=20
> > > > Before creating the patch, I checked with ROM team handling AM437x =
and
> > > > they denied an API to write to this register was present in AM437x =
ROM.
> > >=20
> > > Okay, so why are we trying to write to this register then...
> > >=20
> > > Ah, we have a bug in cache-l2x0.c:
> > >=20
> > > #define L2X0_CACHE_ID_PART_MASK         (0xf << 6)
> > > #define L2X0_CACHE_ID_RTL_MASK          0x3f
> > > #define L310_CACHE_ID_RTL_R3P0          0x05
> > >=20
> > >         unsigned rev =3D readl_relaxed(base + L2X0_CACHE_ID) & L2X0_C=
ACHE_ID_PART_MASK;
> > >=20
> > >         if (rev >=3D L310_CACHE_ID_RTL_R2P0) {
> > > ...
> > >         if (rev >=3D L310_CACHE_ID_RTL_R3P0) {
> > >                 l2c_write_sec(L310_DYNAMIC_CLK_GATING_EN | L310_STNDB=
Y_MODE_EN,
> > >                               base, L310_POWER_CTRL);
> > >=20
> > > So, because we're masking the wrong bits, we end up with these tests
> > > always succeeding.
> > >=20
> > > So that's a NACK for the original patch, it's the wrong fix.  The
> > > right fix is to avoid writing this register by fixing the RTL masking.
> >=20
> > Okie dokie, dropping the omap specific fix.
>=20
> Here's the revision mask fix - with the existing code, the revision checks
> are all useless since they would all pass irrespective of the actual
> revision.  (Had the L2C series been better tested rather than being large=
ly
> ignored, this may have been noticed before it was merged...)  Anyway, what
> isn't clear from Sekhar's message is which revision L2C310 is in the AM43=
7x.
>=20
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Subject: [PATCH] ARM: l2c: fix revision checking
>=20
> The revision checking in l2c310_enable() was not correct; we were
> masking the part number rather than the revision number.  Fix this
> to use the correct macro.
>=20
> Fixes: 4374d64933b1 ("ARM: l2c: add automatic enable of early BRESP")
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mm/cache-l2x0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 948f12cf6180..0b5068256baf 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -732,7 +732,7 @@ static int l2c310_cpu_enable_flz(struct notifier_bloc=
k *nb, unsigned long act, v
> =20
>  static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned n=
um_lock)
>  {
> -	unsigned rev =3D readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PA=
RT_MASK;
> +	unsigned rev =3D readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_RT=
L_MASK;
>  	bool cortex_a9 =3D read_cpuid_part() =3D=3D ARM_CPU_PART_CORTEX_A9;

even with this change, l2c still tries to write to power control
register, at least on AM437x. Looking a little deeper here, AM437x
identifies itself as l2c PL310 r3p3, which should have power control
register, but aparentely there's no way to write that register. I'll
file a bug to our ROM team, but we will certainly need a way to
workaround this inside omap4-common.c

--=20
balbi

--ed/6oDxOLijJh8b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTurhgAAoJEIaOsuA1yqREcL4P/i7akCR8FjC3bOzbdsQZypcP
jtr1jpoLV1BeoaZjiQu23SbP5wGD2MKt2TJR5wzH1KPgtkbZfmuyyOKAp/pD+LuI
r2wYsRWbbvkJLMseYUK/zp/Pk7dFn9lButNHwhNGidW1kE2Ow7Xre3sSYUuDhFyd
/1I28TEnx79HMXRKvFYElTSiPAuziTt1gr7VKiDMOxApCx4qD+W2AuyNex6pSWwK
X6pnqZ1CTjzoEsgZjsvVzJ8sfcHCIhgP5kdwD1mqFkmtXl7DnPQyPWkN/qpng7E1
JyH7W3pZ5kJ//qJTEZYC1spO2ctgA/PxJduEILX4dJS1nz0AO5iZhZZV55Ez2uzL
zM3a0hPbj4TZcx3FVPTpcskIBkAYLiwC1bWPjDJCFylMdXd4+Omvdm2UaY7Pe9wl
v4bLh+PAdAOoSSHERU41CH4ysVMITQ4FYP1yV13eabUCe03E9oWukuipGWrQUPWL
dC704/bO6LJ4UjFaQt3VwSYIjoT1pIMOGkPvm9hKVHux8nvFCsnKzNFQXFuIevqA
A/nBqHOwJBsUpryNb3eIxLG6EvdMDujTFJAmIU7O/uma33kmTt0/1HynGsSVkuBV
HezeLejmG0HbNVvyuh4owxLyqRMYEAILa/14JpoqFGFlsYu0ql3O6nnZu29Kw2zI
9p4b0Krht8z/JflLlZBN
=HRRa
-----END PGP SIGNATURE-----

--ed/6oDxOLijJh8b0--
