From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 2/4] i2c: omap: implement workaround for handling
 invalid BB-bit values
Date: Mon, 24 Nov 2014 11:47:59 -0800
Message-ID: <20141124194759.GG2757@atomide.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416685634-5864-1-git-send-email-al.kochet@gmail.com>
 <1416685634-5864-3-git-send-email-al.kochet@gmail.com>
 <CAMAWPa8whctBR6fBFaSzPvm3qn+QK06CimRrxFxxH=0kNkF4UA@mail.gmail.com>
 <47A1A441-952C-4AC3-859C-5A8E405767E0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <47A1A441-952C-4AC3-859C-5A8E405767E0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [141124 11:41]:
>=20
> 24 =D0=BD=D0=BE=D1=8F=D0=B1. 2014 =D0=B3., =D0=B2 22:08, Kevin Hilman=
 <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0=
):
>=20
> > This patch recently hit linux-next (as commit 903c3859f77f) and boo=
t
> > breakage[1] in next-20141124 on OMAP3530 Beagle and Overo/Tobi boar=
ds
> > was bisected down to this commit.
> >=20
> > Kevin
> >=20
> > [1] http://status.armcloud.us/boot/?next-20141124&omap
>=20
>=20
> Could someone advice with debugging on OMAP3530?

Just try to boot it with your patch? :)
=20
> I'd like to apply one one more commit to see events during boot and
> see actual signals on wire (during of timeout)?

If you post a patch, I can test boot with it. Looks like the failing
ones have i2c rev3.3 on 34xx vs rev4.4 on 36xx.

But the test function should not loop forever in any case I take?

So I doubt we just want to change the test for for a higher rev number
for  OMAP_I2C_REV_ON_3430_3530.
=20
> Otherwise, commit must dropped (or rewritten such way it is disabled =
by default).
>=20
>=20
> 24 =D0=BD=D0=BE=D1=8F=D0=B1. 2014 =D0=B3., =D0=B2 22:13, Wolfram Sang=
 <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0)=
:
>=20
> > OK, giving Alexander some time for a fix. If it can't be found, I'l=
l
> > revert this patch. Thanks!
>=20
> What deadline?

I'd say by Tuesday as we have multiple automated test systems failing
as soon as people update their trees. And when they are failing, we
may miss other breakage happening in linux next.

Regards,

Tony
