From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap2: timer: always define omap4_local_timer_init
Date: Mon, 28 Sep 2015 16:12:58 -0500
Message-ID: <20150928211258.GB16627@saruman.tx.rr.com>
References: <1443464744-16561-1-git-send-email-balbi@ti.com>
 <5609ACD0.1010907@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1130909294223545397=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5609ACD0.1010907@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============1130909294223545397==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline

--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2015 at 04:10:40PM -0500, Nishanth Menon wrote:
> On 09/28/2015 01:25 PM, Felipe Balbi wrote:
> > omap4_local_timer_init() can be used by other
> > platforms as is. At least AM437x wants to use
> > it. Instead of making omap4-only and providing
> > a stub for builds without OMAP4, we can just
> > always define that function.
> >=20
> > Reported-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/mach-omap2/timer.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > index a55655127ef2..f9028582e962 100644
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -642,20 +642,11 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_c=
k", "ti,timer-alwon",
> >  			       2, "sys_clkin_ck", NULL);
> >  #endif
> > =20
> > -#ifdef CONFIG_ARCH_OMAP4
> > -#ifdef CONFIG_HAVE_ARM_TWD
> >  void __init omap4_local_timer_init(void)
> >  {
> >  	omap4_sync32k_timer_init();
> >  	clocksource_of_init();
> >  }
> > -#else
> > -void __init omap4_local_timer_init(void)
> > -{
> > -	omap4_sync32k_timer_init();
> > -}
> > -#endif /* CONFIG_HAVE_ARM_TWD */
> > -#endif /* CONFIG_ARCH_OMAP4 */
> > =20
> >  #if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
> >  void __init omap5_realtime_timer_init(void)
> >=20
> I am a little confused if this will build in a am437xx only build.
>=20
> #define OMAP_SYS_32K_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop, \
> clksrc_nr, clksrc_src, clksrc_prop) \
> void __init omap##name##_sync32k_timer_init(void) \
>=20
> Would you like to consider this for OMAP4 only build as well?
>=20
> #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
>=20
>         defined(CONFIG_SOC_DRA7XX)
> static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
>                                2, "sys_clkin_ck", NULL);
> #endif

heh, more of the ifdeferry to drop. Okay, I'll respin this

--=20
balbi

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWCa1aAAoJEIaOsuA1yqRES+kP/3/YcSThtsYq/Etst8RINN52
gADavTtu4eYFvaPUAEpsXYpdXI0/Mkxg9W5KjBpjuk+PCNr3boO+b2Tp9G2CUtdN
9OUvnw9imov4KWuKMPkakdkdTn4KLmq0TcTtdo5/u05IHJc82xzXy2vIDhQ1YVlH
kHkVny3u5TGARQStxaiZWYI0n9216njP0T2fUKpGThU+4sHDeDfGiAunKo1H0dw6
1wOkEDFFlPOVl5uP0FlXmn/4npdAGyiyr9ptdo6N85cRurkZ5sU0A2ntuJXCtPsB
SLv6MEHYyvXB1XvLenclCs3cMCjRVPyPlPD5W74w2liA92u6B4R19zMQ5FFsjNck
TqE4NSJ2dxvao27dvN/yAf1IcE1XHvoqS/Xaj8WWhtN+xksu0L4mVYZYOdfdC7mN
jptRi1C+JqNY9Xj/RbW8+Cnzg8FhkIqGqK6Ln241xcp6HVNJMWd+pzH5qrgtQuug
hCcX1XFhfK07Dd1YRfd6i2WaOVIvV4d22SZEpmM6zOKfCNSrZV3SHBsK4/k1lGFL
+tOuBhROfm3iBoduZmbrng0yU4xaNNbxie0pQmbHoQGMm4rdQ5gzeACSknAwGtY/
CA+EJraTIzJQTiUGlsEgaNTi8Qj301lYVqh0en4Dkje8MHPvNzTIMoYj0pzBAYE5
oNSYxItwBd+V+9pMb0MV
=w3eD
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--


--===============1130909294223545397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1130909294223545397==--
