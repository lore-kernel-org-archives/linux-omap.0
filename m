From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 2/4] i2c: omap: implement workaround for handling
 invalid BB-bit values
Date: Tue, 25 Nov 2014 07:41:50 -0800
Message-ID: <20141125154150.GI2817@atomide.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
 <1416685634-5864-1-git-send-email-al.kochet@gmail.com>
 <1416685634-5864-3-git-send-email-al.kochet@gmail.com>
 <CAMAWPa8whctBR6fBFaSzPvm3qn+QK06CimRrxFxxH=0kNkF4UA@mail.gmail.com>
 <47A1A441-952C-4AC3-859C-5A8E405767E0@gmail.com>
 <20141124194759.GG2757@atomide.com>
 <47749B61-5924-4E56-9931-77B0CFC0AAA0@gmail.com>
 <06376010-5DED-49AA-9494-A9546567E7CA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <06376010-5DED-49AA-9494-A9546567E7CA-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [141124 16:11]:
>=20
> 24 =D0=BD=D0=BE=D1=8F=D0=B1. 2014 =D0=B3., =D0=B2 23:05, Alexander Ko=
chetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB=
(=D0=B0):
>=20
> > Something (u-boot, may be) leave the bus in the wrong state.
> > Really strange.
>=20
> Actually something wrong with i2c-pullups on i2c.1 bus on fault board=
s.
> May be these are boards without pull-ups?

It could be. Boards that use external i2c pulls should have all the
internal pulls disabled as the pulls get connected in parallel and
the total resistance decreases. And then the i2c signals may not be
up to the spec.

Note that there are internal pulls in the i2c controller, and in the
i2c padconf registers.

> All beagles doesn't have internal pull-ups on i2c.1 since u-boot 2011=
=2Ex.

The pulls should be enabled based on the board and possibly based
on the board revision.
=20
> Here is the bug in the u-boot related to beagle:
> http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3D04e2a13336f0e507ef4=
16bbede3be92b79c46594
>=20
> Yes, I made fix, but keep that in mind.
>=20
> For example one of the boards (omap3-beagle):
> http://status.armcloud.us/boot/omap3-beagle/job/next/kernel/next-2014=
1124/defconfig/arm-omap2plus_defconfig/
> http://status.armcloud.us/boot/omap3-beagle,legacy/job/next/kernel/ne=
xt-20141124/defconfig/arm-omap2plus_defconfig/
> http://status.armcloud.us/boot/omap3-beagle/job/next/kernel/next-2014=
1124/defconfig/arm-multi_v7_defconfig/
>=20
> has following warning message in the u-boot log:
> > U-Boot 2014.07 (Aug 21 2014 - 11:03:05)
> >=20
> > OMAP3530-GP ES3.0, CPU-OPP2, L3-165MHz, Max CPU Clock 600 MHz
> > OMAP3 Beagle board + LPDDR/NAND
> > ....
> > Beagle Rev C1/C2/C3
> > Timed out in wait_for_event: status=3D1000
> > Check if pads/pull-ups of bus 1 are properly configured
>=20
> Also beagle schematic has following log entry for A3:
> 4. Added optional pullup resistors on I2C2_SCL and I2C_SDA into the l=
ayout.
>=20
> Is the fault beagle is pre A3 revision?

Seems to be C1/C2/C3 based on the above logs?
=20
> I can't tell anything about second one board (omap3-overo-tobi), beca=
use I could not get it schematic.
>=20
> And how you have i2c.1 working without pull-ups I don't know.

I checked on the LDP and it seems to have external pulls for i2c.
I also tested n900 without your fix, and it's failing too. On n900
there are external pulls and all the internal pulls should be
disabled.

Regards,

Tony
