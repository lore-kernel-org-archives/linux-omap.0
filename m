From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
 cyc_to_fixed_sched_clock
Date: Tue, 5 Apr 2011 13:12:57 +0200
Message-ID: <20110405111257.GR13963@pengutronix.de>
References: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>
 <20110405075622.GB4699@n2100.arm.linux.org.uk>
 <20110405083144.GN13963@pengutronix.de>
 <20110405090100.GC4699@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110405090100.GC4699-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jan Weitzel <j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rubini-9wsNiZum9E8@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 05, 2011 at 10:01:00AM +0100, Russell King - ARM Linux wrot=
e:
> On Tue, Apr 05, 2011 at 10:31:44AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 05, 2011 at 08:56:22AM +0100, Russell King - ARM Linux =
wrote:
> > > On Tue, Apr 05, 2011 at 09:43:21AM +0200, Jan Weitzel wrote:
> > > > parameter "u32 mask" type cast befor inversion
> > s/befor/before/
> >=20
> > > Nak.  I want a 32-bit all ones quantity.
> > >=20
> > > unsigned long long vali =3D (unsigned short)~0;
> > > unsigned long long vall =3D ~(unsigned short)0;
> > >=20
> > BTW, the definiton of vall is equivalent to=20
> >=20
> > 	unsigned long long valu =3D ~(unsigned int)0;
> >=20
> > because ~ converts the unsigned short to unsigned int.
>=20
> No.  The value gets promoted to int not unsigned int.
>=20
> > > compiles to:
> > >=20
> > > vali:
> > >         .word   65535
> > >         .word   0
> > >=20
> > > vall:
> > >         .word   -1
> > >         .word   -1
> > I really wonder about that. If I take a value of 0xffffffff (i.e. a=
 32
> > bit wide int =3D=3D ~0U) and assign that to an 64-bit unsigned long=
 long I'd
> > expect it to get the value 0x00000000ffffffffULL, not
> > 0xffffffffffffffffULL. What's wrong?
>=20
> See above.  int not unsigned int.  And it makes a difference:
>=20
> unsigned long long vals =3D ~(int)0;
> unsigned long long valu =3D ~(unsigned int)0;
>=20
> vals:
>         .word   -1
>         .word   -1
> valu:
>         .word   -1
>         .word   0
>=20
ah, ok, makes sense and actually is consistent with my book.
(After knowing what I search I found it. The rules are:

 - A signed type of rank less than int
   -> int
 - An unsigned type of rank less than int,
   all of whose values can be represented in type int
   -> int
 - An unsigned type of rank less than int,
   all of whose values cannot be represented in type int
   -> unsigned int
).

So the maximal correct variant is (u32)(int)~0U or alternatively
(u32)(-1), right?

Thanks for your answer, best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
