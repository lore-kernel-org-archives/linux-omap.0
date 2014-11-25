From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/4] i2c: omap: implement workaround for handling invalid BB-bit values
Date: Tue, 25 Nov 2014 03:09:13 +0300
Message-ID: <06376010-5DED-49AA-9494-A9546567E7CA@gmail.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com> <1416685634-5864-1-git-send-email-al.kochet@gmail.com> <1416685634-5864-3-git-send-email-al.kochet@gmail.com> <CAMAWPa8whctBR6fBFaSzPvm3qn+QK06CimRrxFxxH=0kNkF4UA@mail.gmail.com> <47A1A441-952C-4AC3-859C-5A8E405767E0@gmail.com> <20141124194759.GG2757@atomide.com> <47749B61-5924-4E56-9931-77B0CFC0AAA0@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <47749B61-5924-4E56-9931-77B0CFC0AAA0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


24 =CE=CF=D1=C2. 2014 =C7., =D7 23:05, Alexander Kochetkov <al.kochet@g=
mail.com> =CE=C1=D0=C9=D3=C1=CC(=C1):

> Something (u-boot, may be) leave the bus in the wrong state.
> Really strange.

Actually something wrong with i2c-pullups on i2c.1 bus on fault boards.
May be these are boards without pull-ups?
All beagles doesn't have internal pull-ups on i2c.1 since u-boot 2011.x=
=2E

Here is the bug in the u-boot related to beagle:
http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3D04e2a13336f0e507ef416=
bbede3be92b79c46594

Yes, I made fix, but keep that in mind.

=46or example one of the boards (omap3-beagle):
http://status.armcloud.us/boot/omap3-beagle/job/next/kernel/next-201411=
24/defconfig/arm-omap2plus_defconfig/
http://status.armcloud.us/boot/omap3-beagle,legacy/job/next/kernel/next=
-20141124/defconfig/arm-omap2plus_defconfig/
http://status.armcloud.us/boot/omap3-beagle/job/next/kernel/next-201411=
24/defconfig/arm-multi_v7_defconfig/

has following warning message in the u-boot log:
> U-Boot 2014.07 (Aug 21 2014 - 11:03:05)
>=20
> OMAP3530-GP ES3.0, CPU-OPP2, L3-165MHz, Max CPU Clock 600 MHz
> OMAP3 Beagle board + LPDDR/NAND
> ....
> Beagle Rev C1/C2/C3
> Timed out in wait_for_event: status=3D1000
> Check if pads/pull-ups of bus 1 are properly configured

Also beagle schematic has following log entry for A3:
4. Added optional pullup resistors on I2C2_SCL and I2C_SDA into the lay=
out.

Is the fault beagle is pre A3 revision?

I can't tell anything about second one board (omap3-overo-tobi), becaus=
e I could not get it schematic.

And how you have i2c.1 working without pull-ups I don't know.

Alexander.
