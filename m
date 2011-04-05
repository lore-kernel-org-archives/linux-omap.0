From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
	cyc_to_fixed_sched_clock
Date: Tue, 5 Apr 2011 14:57:06 +0100
Message-ID: <20110405135706.GE4699@n2100.arm.linux.org.uk>
References: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de> <20110405075622.GB4699@n2100.arm.linux.org.uk> <20110405083144.GN13963@pengutronix.de> <20110405090100.GC4699@n2100.arm.linux.org.uk> <20110405111257.GR13963@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110405111257.GR13963-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jan Weitzel <j.weitzel-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, khc-9GfyWEdoJtJmR6Xm/wNWPw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rubini-9wsNiZum9E8@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 05, 2011 at 01:12:57PM +0200, Uwe Kleine-K=F6nig wrote:
> ah, ok, makes sense and actually is consistent with my book.
> (After knowing what I search I found it. The rules are:
>=20
>  - A signed type of rank less than int
>    -> int
>  - An unsigned type of rank less than int,
>    all of whose values can be represented in type int
>    -> int
>  - An unsigned type of rank less than int,
>    all of whose values cannot be represented in type int
>    -> unsigned int
> ).
>=20
> So the maximal correct variant is (u32)(int)~0U or alternatively
> (u32)(-1), right?

If you really want to be pedantic, (u32)~0UL, as we assume that longs
will always be equal or larger than 32-bit throughout the kernel.  The
u32 cast then becomes truncating in itself.

But... in the interests of avoiding churn, we know the current code
works, we know that its safe should we chose to change the function
argument to be a u64, so lets leave it as-is.  We know the only time
that it'd break is if an 'int' becomes less than 32-bit, which we
aren't going to see on ARM any time soon.
