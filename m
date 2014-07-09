From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Wed, 9 Jul 2014 08:55:30 -0500
Message-ID: <20140709135530.GD973@saruman.home>
References: <20140707110249.GO28884@atomide.com>
 <53BA8983.3030803@ti.com>
 <20140707121512.GT3705@n2100.arm.linux.org.uk>
 <20140707123925.GW28884@atomide.com>
 <20140707134008.GU3705@n2100.arm.linux.org.uk>
 <20140707151024.GJ5582@saruman.home>
 <53BB7980.2060909@ti.com>
 <20140708082948.GE28884@atomide.com>
 <20140709092531.GK28884@atomide.com>
 <53BD34FD.5070005@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51731 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaGIN4A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 09:56:00 -0400
Content-Disposition: inline
In-Reply-To: <53BD34FD.5070005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, balbi@ti.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 05:56:37PM +0530, Sekhar Nori wrote:
> On Wednesday 09 July 2014 02:55 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [140708 01:32]:
> >> * Sekhar Nori <nsekhar@ti.com> [140707 21:56]:
> >>> On Monday 07 July 2014 08:40 PM, Felipe Balbi wrote:
> >>>> On Mon, Jul 07, 2014 at 02:40:08PM +0100, Russell King - ARM Linux w=
rote:
> >>>>> --- a/arch/arm/mm/cache-l2x0.c
> >>>>> +++ b/arch/arm/mm/cache-l2x0.c
> >>>>> @@ -732,7 +732,7 @@ static int l2c310_cpu_enable_flz(struct notifie=
r_block *nb, unsigned long act, v
> >>>>> =20
> >>>>>  static void __init l2c310_enable(void __iomem *base, u32 aux, unsi=
gned num_lock)
> >>>>>  {
> >>>>> -	unsigned rev =3D readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE=
_ID_PART_MASK;
> >>>>> +	unsigned rev =3D readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE=
_ID_RTL_MASK;
> >>>>>  	bool cortex_a9 =3D read_cpuid_part() =3D=3D ARM_CPU_PART_CORTEX_A=
9;
> >>>>
> >>>> even with this change, l2c still tries to write to power control
> >>>> register, at least on AM437x. Looking a little deeper here, AM437x
> >>>> identifies itself as l2c PL310 r3p3, which should have power control
> >>>> register, but aparentely there's no way to write that register. I'll
> >>>> file a bug to our ROM team, but we will certainly need a way to
> >>>> workaround this inside omap4-common.c
> >>>
> >>> Looks like we need both my patch as well as Russell's patch. I can
> >>> respin my patch with the pr_info_once() dropped if it helps further
> >>> reduce boot noise.
> >>
> >> In that case I'm fine with the original patch in this series. Russell,
> >> got any better ideas?
> >=20
> > I guess no more comments. Took a look at the patch again, Sekhar, can
> > you please update the description with what has been discovered in this
> > thread and repost?
>=20
> How does the following sound:
>=20
> ---
> AM437x has L2C-310 version r3p2 and ROM code on that device does not

at least my SoC has r3p3 (cache ID 0x9), other than that, commit log
looks good to my eyes.


--=20
balbi

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTvUnSAAoJEIaOsuA1yqRE3EAP/1s8YPg9vkCegeY9xNop1nTz
/YTZmP8tIOtppwJh0SjOQglkZ1OKUUdEEYtZsUPwlCJo6XZ9GXKvzK+nBuZ2VKLj
GLSqlMDq+2Rb9GHFP0xWWppCED6BKQl8b0YJUiKg8FU58+8tDx+KyoB2EQfCRBsu
IsbXMhgjv2yRxhZsu12QHUmJNDSqLLHax2gr+EFosaaAv+X4jDDmHrjJUcSaWGGZ
O9FKJE0PzhQhuDCvhCH0m9YCJcC05F/z6hufnqqzBOcY0xb7FmmnYMpi2MxWosf0
cSyhqT9cgWuIlCRGK2utYxHPKcuey7/AGsxx/OSgeGME0jEQrQ2AQ6denuUUa/2g
PGd8PfvE61OLPSbRN+G27lEEUnHPU3H2VUmIoLjsjsIcUl8GRZ466Oyc+D8MwCt9
XBZ/mSLlQ5oeGLamd/B/U8W6oA8wr1ikraPQ/U6IA3lVwjKkgCMOriB+v2UIlUnO
w8qwMdpNdChQVZ4ISVXidAy2oeLszSmD86NJtuirJwkM2M+xiktM90RZkhqReiq7
PHt6mozRpf4mnA2jU2suh5QDC4vQMMQb/oFFNJeopWV2C1n1Ej5ByTXxodPJrtbC
Rx1zAiFWo1wzc4xdSmTvY5bVzYW24PuJrhc/gUWa+fGrGMil7hC9IIdpFcNg2rpo
2dfjqcrxPum/11k1i6mf
=J0n2
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
