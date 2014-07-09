From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Wed, 9 Jul 2014 08:51:37 -0500
Message-ID: <20140709135137.GC973@saruman.home>
References: <20140707104944.GS3705@n2100.arm.linux.org.uk>
 <20140707110249.GO28884@atomide.com>
 <53BA8983.3030803@ti.com>
 <20140707121512.GT3705@n2100.arm.linux.org.uk>
 <20140707123925.GW28884@atomide.com>
 <20140707134008.GU3705@n2100.arm.linux.org.uk>
 <20140707151024.GJ5582@saruman.home>
 <53BB7980.2060909@ti.com>
 <20140708082948.GE28884@atomide.com>
 <20140709092531.GK28884@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50742 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbaGINwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 09:52:14 -0400
Content-Disposition: inline
In-Reply-To: <20140709092531.GK28884@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sekhar Nori <nsekhar@ti.com>, balbi@ti.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 02:25:31AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140708 01:32]:
> > * Sekhar Nori <nsekhar@ti.com> [140707 21:56]:
> > > On Monday 07 July 2014 08:40 PM, Felipe Balbi wrote:
> > > > On Mon, Jul 07, 2014 at 02:40:08PM +0100, Russell King - ARM Linux =
wrote:
> > > >> --- a/arch/arm/mm/cache-l2x0.c
> > > >> +++ b/arch/arm/mm/cache-l2x0.c
> > > >> @@ -732,7 +732,7 @@ static int l2c310_cpu_enable_flz(struct notifi=
er_block *nb, unsigned long act, v
> > > >> =20
> > > >>  static void __init l2c310_enable(void __iomem *base, u32 aux, uns=
igned num_lock)
> > > >>  {
> > > >> -	unsigned rev =3D readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACH=
E_ID_PART_MASK;
> > > >> +	unsigned rev =3D readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACH=
E_ID_RTL_MASK;
> > > >>  	bool cortex_a9 =3D read_cpuid_part() =3D=3D ARM_CPU_PART_CORTEX_=
A9;
> > > >=20
> > > > even with this change, l2c still tries to write to power control
> > > > register, at least on AM437x. Looking a little deeper here, AM437x
> > > > identifies itself as l2c PL310 r3p3, which should have power control
> > > > register, but aparentely there's no way to write that register. I'll
> > > > file a bug to our ROM team, but we will certainly need a way to
> > > > workaround this inside omap4-common.c
> > >=20
> > > Looks like we need both my patch as well as Russell's patch. I can
> > > respin my patch with the pr_info_once() dropped if it helps further
> > > reduce boot noise.
> >=20
> > In that case I'm fine with the original patch in this series. Russell,
> > got any better ideas?
>=20
> I guess no more comments. Took a look at the patch again, Sekhar, can
> you please update the description with what has been discovered in this
> thread and repost?

another thing to note is that as of today, there is no known way of
accessing power control register in *any* TI parts. That's quite
unfortunate :-(

--=20
balbi

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTvUjpAAoJEIaOsuA1yqRE/P0P/Rgub4wqv++65GmmQgUn1lVJ
+d0aj0sp68ssfBseY3TAVBN4b06eZqLRoqYBOK7/vpQcVeU212Wf6/jC2KNGMl33
T7aXZd/pF4xy5WFS03wsnUN85q60kSOAVwZNBlyEG8cU4qGSlSNSHzZaD9KpChIT
GSNR/8zyECRz38wNeupoP8VkVs24bcd/gvSA/UP+40D8upCZBgtfIwX0lADHyA5j
kOKP46Z5nPqNO8YjA7laOjoGyuD8J0lz0rIWiG7JbVEjItFWsqmIu5fitYRqSnhW
N87G/DjKvwIak9+TnMbrdTjnACjLQxvR+eyF+HC6eXteqy1zCwGmC/IpulEJ+g+Q
9JcPZLnvf6WnbUAmVgiiMaqtgEi7/GRZQFW3AHDn2s8CJVXK+nFwtOEhBrMzSaX0
KMenpNtFwseJ274jmCXfqdaooz+qho4QvB0l6htxB6oOqnmEbiIvXsQ4CrG1G+vN
hOIr6ygt7SG44BD9ZWltgogCRJhYiaY8xIULWbDxV+b1DVRv0tW/fSog7Ry5snPE
4U2+mQlsCydXzc2Wnhxo48uAtrO1lNwBDDG7ZUjpyRqeX/B3mlwMNSEb6xiK2iWz
LDiBXTfa72pvcuJ89ffkoglhDa5wt9Cvq8btS1pglK7vr3xFvQFrtHVmJyKoiyei
m57UtK7vf5+DTFxl2cij
=ykng
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
