From: Tony Lindgren <tony@atomide.com>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Mon, 27 Oct 2014 12:52:09 -0700
Message-ID: <20141027195209.GP2560@atomide.com>
References: <20141019090107.GA19132@amd>
 <201410262222.39892@pali>
 <20141026215548.GA9004@amd>
 <201410262323.17891@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201410262323.17891@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [141026 15:24]:
> On Sunday 26 October 2014 22:55:48 Pavel Machek wrote:
> > > > I have root prepared on /dev/mmcblk0p6. I tried 3.17 with
> > > > rx51_defconfig, but no, it refuses to mount it.
> > > >=20
> > > > VFS: Cannot open root device "mmcblk0p6" or ....: error
> > > > -19.
> > > >=20
> > > > And then it proceeds to list mmcblk0p6 as one of available
> > > > options
> > > >=20
> > > > :-(.
> > > >=20
> > > > Ideas welcome.
> > >=20
> > > Try to add rootdelay=3D30 or rootwait to kernel cmdline.
> >=20
> > I had rootdelay=3D3. Will try rootwait... no change. This is
> > v3.17 with rx51_defconfig. CONFIG_MACH_NOKIA_RX51=3Dy =3D> device
> > tree will not be used AFAICT.
> >=20
> > Now I'm back at 3.14 without device tree; same setup works
> > there. I tried disabling RX51 support in 3.14 (to make it
> > boot using device tree) but that did not work.
> > 								Pavel
>=20
> I remember that there was some problem with initializing mmc=20
> device. Sometimes something failed and reading from eMMC was not=20
> possible. Try to boot kernel from uboot. Maybe it can help.

Would be nice to have both the USB and the MMC issues sorted
out in the mainline kernel naturally and get rid of any bootloader
dependencies.

I think the USB issue because usb_gadget_probe_driver() bails
out with -ENODEV before the USB controller is found. Felipe, got
any ideas how to fix this to work with -EPROBE_DEFER? Should this
get called only from the USB controller probe?

Regards,

Tony
