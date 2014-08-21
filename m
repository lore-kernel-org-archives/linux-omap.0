From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/15] tty: serial: Add 8250-core based omap driver
Date: Thu, 21 Aug 2014 11:38:20 -0700
Message-ID: <20140821183820.GE10066@atomide.com>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-6-git-send-email-bigeasy@linutronix.de>
 <20140815210716.GE9239@atomide.com>
 <53F5D16B.4030007@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53F5D16B.4030007@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140821 04:04]:
> On 08/15/2014 11:07 PM, Tony Lindgren wrote:
> > Nice, now it mostly works for me with off-idle too :) That is as lo=
ng
> > as I have the DMA channels commented out in the .dts file.
> >=20
> > And I'm still seeing an occasional hang with pstore console just
> > showing:
> >=20
> > [  289.076538] In-band Error seen by MPU  at address 0
> > [  289.076538] ------------[ cut here ]------------
> > [  289.076568] WARNING: CPU: 0 PID: 99 at drivers/bus/omap_l3_smx.c=
:162 omap3_l3_app_irq+0xdc/0x134()
> > [  289.076599] Modules linked in:
> > [  289.076599] CPU: 0 PID: 99 Comm: test-idle-off-8 Tainted: G     =
   W      3.16.0+ #510
> > [  289.076629] [<c0016c44>] (unwind_backtrace) from [<c00129c8>] (s=
how_stack+0x20/0x24)
> > [  289.076660] [<c00129c8>] (show_stack) from [<c0714cd4>] (dump_st=
ack+0x88/0xa4)
>=20
> Okay. So this backtrace does not show more like from where the access
> is happening?

No, or if the omap_l3_smx.c can show the address it's not implemented.
=20
> > Which most likely means there's still some glitch with the
> > runtime PM somewhere and registers are being accessed when
> > not clocked. I _think_ I did not see it when I did not have
> > console=3DttyS2,115200 in my cmdline but was using just pstore
> > console.
> >=20
> >> The device name is ttyS based instead of ttyO. If a ttyO based nod=
e name
> >> is required please ask udev for it. If both driver are activated (=
this
> >> and omap-serial) then this serial driver will take control over th=
e
> >> device due to the link order
> >=20
> > That's still not going to help with the existing kernel cmdlines
> > and existing installs.. I wonder if we can just do a minimal
> > dummy serial-omap.c that just proxies all the ttyO read/write
> > access to ttyS?
>=20
> Hmm. So you are not a friend of the udev solution?. For now the drive=
r
> is "default n" and you have to explicit enable it and _then_ you shou=
ld
> be able to update your command line, etc.
> If I introduce a kernel proxy for compatibility I assume that people
> will wake up once that compatibility piece is gone.

The udev solution will not help with all the existing cases of
console=3DttyO2,115200. But maybe we just need to translate the
cmdline to ttS2 in those cases?

Then the udev rules could fix up most of the distro issues, but
not all of them. And still requires the userspace to be updated.
=20
> However, if you insist=E2=80=A6 I tried to make a symlink but nobody =
does this
> in kernel. The "rtc -> rtc0" and friends seem to come from udev _or_
> distro. So I sff could a second device node with the same major/minor=
=2E
> That would work for userland but not for the kernel console=E2=80=A6 =
So we need
> a proxy-console for this.

Yeah the symlinks won't work, think read-only rootfs for example :)
=20
> Before I spent time on this proxy-console I would like to hear from G=
reg
> that he is okay with this.

Yeah me too.

Tony
