From: Jan Weitzel <J.Weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
 cyc_to_fixed_sched_clock
Date: Tue, 5 Apr 2011 12:59:12 +0200
Message-ID: <OFDC271AC0.D19DB9A2-ONC1257869.003AA29F-C1257869.003C5A1D@phytec.de>
References: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>	<20110405075622.GB4699@n2100.arm.linux.org.uk> <20110405083144.GN13963@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110405083144.GN13963-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rubini-9wsNiZum9E8@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

linux-arm-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org schrieb am 05.04.2011=20
10:31:44:

> Von: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> An: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Kopie: rubini-9wsNiZum9E8@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,=20
> eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Jan=20
> Weitzel <j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,=20
> STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,=20
> kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khc-9GfyWEdoJtI@public.gmane.org=
l
> Datum: 05.04.2011 10:33
> Betreff: Re: [PATCH] ARM: type casts update_sched_clock=20
> cyc_to_sched_clock cyc_to_fixed_sched_clock
> Gesendet von: linux-arm-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>=20
> On Tue, Apr 05, 2011 at 08:56:22AM +0100, Russell King - ARM Linux=20
wrote:
> > On Tue, Apr 05, 2011 at 09:43:21AM +0200, Jan Weitzel wrote:
> > > parameter "u32 mask" type cast befor inversion
> s/befor/before/
>=20
> > Nak.  I want a 32-bit all ones quantity.
> >=20
> > unsigned long long vali =3D (unsigned short)~0;
> > unsigned long long vall =3D ~(unsigned short)0;
> >=20
> BTW, the definiton of vall is equivalent to=20
>=20
>    unsigned long long valu =3D ~(unsigned int)0;
>=20
> because ~ converts the unsigned short to unsigned int.
>=20
> > compiles to:
> >=20
> > vali:
> >         .word   65535
> >         .word   0
> >=20
> > vall:
> >         .word   -1
> >         .word   -1
> I really wonder about that. If I take a value of 0xffffffff (i.e. a 3=
2
> bit wide int =3D=3D ~0U) and assign that to an 64-bit unsigned long l=
ong I'd
> expect it to get the value 0x00000000ffffffffULL, not
> 0xffffffffffffffffULL. What's wrong?
>=20
> > So moving the ~ to be evaluated after the cast has the effect of=20
making
> > the cast pointless, and produces wrong values.  (u32)~0 does the=20
32-bit
> My C-Book tells that using ~ on a signed it produces implementation
> defined behaviour. That's what I pointed out to Jan and I guess that'=
s
> the reason why he created the patch.

That's right. I tested it and got for both
static unsigned long long valuica =3D (unsigned int)~0;
static unsigned long long valuicb =3D ~(unsigned int)0;

the same:
=2Eword   0xffffffff
=2Eword   0x00000000

With unsigned short I see the problem. Sorry for the noise.

Kind regards=20
Jan
