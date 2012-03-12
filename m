From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Mon, 12 Mar 2012 11:39:24 +0200
Message-ID: <20120312093921.GA5375@legolas.emea.dhcp.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com>
 <20120305225530.GJ12083@atomide.com>
 <79CD15C6BA57404B839C016229A409A83180F73D@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51461 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755054Ab2CLJj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 05:39:28 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so1308618lbb.33
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 02:39:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83180F73D@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 05:58:00PM +0000, Hiremath, Vaibhav wrote:
> On Tue, Mar 06, 2012 at 04:25:30, Tony Lindgren wrote:
> > Hi,
> >=20
> > * Vaibhav Hiremath <hvaibhav@ti.com> [120119 06:01]:
> > > OMAP device has 32k-sync timer which is currently used as a
> > > clocksource in the kernel (omap2plus_defconfig).
> > > The current implementation uses compile time selection between
> > > gp-timer and 32k-sync timer, which breaks multi-omap build for
> > > the devices like AM33xx, where 32k-sync timer is not available.
> > >=20
> > > So use hwmod database lookup mechanism, through which at run-time
> > > we can identify availability of 32k-sync timer on the device,
> > > else fall back to gp-timer.
> > ...
> >=20
> > > --- a/arch/arm/plat-omap/counter_32k.c
> > > +++ b/arch/arm/plat-omap/counter_32k.c
> > > @@ -69,52 +69,55 @@ void read_persistent_clock(struct timespec *ts)
> > > =20
> > >  int __init omap_init_clocksource_32k(void)
> > >  {
> > > -	static char err[] __initdata =3D KERN_ERR
> > > -			"%s: can't register clocksource!\n";
> > > -
> > > -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> > > -		u32 pbase;
> > > -		unsigned long size =3D SZ_4K;
> > > -		void __iomem *base;
> > > -		struct clk *sync_32k_ick;
> > > -
> > > -		if (cpu_is_omap16xx()) {
> > > -			pbase =3D OMAP16XX_TIMER_32K_SYNCHRONIZED;
> > > -			size =3D SZ_1K;
> > > -		} else if (cpu_is_omap2420())
> > > -			pbase =3D OMAP2420_32KSYNCT_BASE + 0x10;
> > > -		else if (cpu_is_omap2430())
> > > -			pbase =3D OMAP2430_32KSYNCT_BASE + 0x10;
> > > -		else if (cpu_is_omap34xx())
> > > -			pbase =3D OMAP3430_32KSYNCT_BASE + 0x10;
> > > -		else if (cpu_is_omap44xx())
> > > -			pbase =3D OMAP4430_32KSYNCT_BASE + 0x10;
> > > -		else
> > > +	u32 pbase;
> > > +	unsigned long size =3D SZ_4K;
> > > +	void __iomem *base;
> > > +	struct clk *sync_32k_ick;
> > > +
> > > +	if (cpu_is_omap16xx()) {
> > > +		pbase =3D OMAP16XX_TIMER_32K_SYNCHRONIZED;
> > > +		size =3D SZ_1K;
> > > +	} else if (cpu_class_is_omap2()) {
> > > +		struct omap_hwmod *oh;
> > > +		const char *oh_name =3D "counter_32k";
> > > +
> > > +		oh =3D omap_hwmod_lookup(oh_name);
> > > +		if (!oh || oh->slaves_cnt =3D=3D 0) {
> > > +			pr_err("Could not lookup %s hwmod\n", oh_name);
> > >  			return -ENODEV;
> > > +		}
> > > +		pbase =3D oh->slaves[0]->addr->pa_start + 0x10;
> > > +	} else {
> > > +		return -ENODEV;
> > > +	}
> >=20
> > How about have separate omap1 and omap2+ init functions that
> > call a common function and passes the pbase as a parameter?
> >=20
> > That way we can get rid of the cpu_is_omapxxxx tests here.
> >=20
>=20
> Tony,
>=20
> In the morning, I replied very soon, without much thinking...
>=20
> Just now I started working on the patch, I was just reviewing the code,=
=20
> and I felt that, it is unnecessary to split the code between omap1 and=20
> omap2+.
>=20
> The reason is,
>=20
> Currently Only OMAP16xx base-address is hardcoded with
> cpu_is_omap16xx() macro, For all other omap family of devices the
> complete information is fetched from HWDMO api's/data.

In that case, why don't you create the platform_device by hand on
arch/arm/mach-omap1/devices.c and move the omap2+ (which is based on
hwmod) to arch/arm/mach-omap2/devices.c ?

--=20
balbi

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXcRJAAoJEIaOsuA1yqREAIsP/ipPGeFVSABfuWcrqvEBF2GY
5Bimae6IsdeO/MRVNkrv2GbhNzLpNUOWD51B3QPKgaOUgKLqxOomkWPD7mhJy0vK
sIOuA6yHpy6eLPZfqmSr9GFUQNYKGyt4kcnnO6qch6X/c18qNJq9QK1e+RkqQlG+
vXVUyc9UhDlSubUtgmWma0hbB2iTHB01eW4XcXFaocF0MrDENDB8XXKWW87bGNTo
XcKQuWAsOoqcWCUuM5RdyNJrOCp4XOo8edfxZLzg2RafqoxAQR3ZmF6qwnrKahf/
ORMxO25a37ly9+Fc015Z+6Qczgt1ZgqRDStPvkAd0nAhKZCe0DJHNpSXMuEBFa73
QHbnSe4IegyMobcZkf2NxfLV8cTP26McFqBpP6Ducf2UkkkohyleH/d6bK/74wl+
APaIG0xL0FuUg7VZL3m3RcI0hR9PpJ9OyquywzVHtaSHkU9xe2JWp0TKmyaDYI3Y
ElgO5vU/e7EVYmJ+VHjJGk9ilLkUI1Q9N2tC3P8dzhYCF/y2Y+re7edCDbapC/Ao
rFaq0zZHwc5s7G/YBrGbV15U+cH+PErclDF/1m5KODBlmL9jFK1rY5g8BHphftUo
7waV0voK27u67vYPK4vErARZ2cm4CG+z1vDydBoOliXQWfe8Q7yxh8IjI/u+zUVI
ZupJX+IPY3ln4Oa4MT6r
=fOiq
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
