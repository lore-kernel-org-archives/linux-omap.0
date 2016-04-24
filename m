From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: qemu:beagle no longer booting with omap2plus_defconfig in -next
Date: Sun, 24 Apr 2016 19:14:29 +0200
Message-ID: <20160424191429.48880fdd@bbrezillon>
References: <571BB682.1010806@roeck-us.net>
	<20160423214617.4d0905d2@bbrezillon>
	<571CF780.1080308@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <571CF780.1080308@roeck-us.net>
Sender: linux-next-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 24 Apr 2016 09:42:40 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 04/23/2016 12:46 PM, Boris Brezillon wrote:
> > Hi Guenter,
> >
> > On Sat, 23 Apr 2016 10:53:06 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >  
> >> Hi,
> >>
> >> since next-20160421, I get the following error and hang when trying to boot
> >> an omap2plus_defconfig image with qemu, machine 'beagle' and omap3-beagle.dtb.
> >> multi_v7_defconfig still works, as does machine 'beaglexm' with omap3-beagle-xm.dtb
> >> and omap2plus_defconfig. This is with Linaro's version of qemu.
> >>
> >> nand: timeout while waiting for chip to become ready
> >>
> >> The message repeats until the test times out.
> >>
> >> Bisect points to "Merge remote-tracking branch 'nand/nand/next'" as the offending
> >> commit. However, the nand/nand/next branch itself is fine, as is the merge just
> >> prior to the nand/nand/next merge ("Merge remote-tracking branch 'l2-mtd/master'").
> >>
> >> After some digging, I found that reverting commit "mtd: nand: omap2: Implement
> >> NAND ready using gpiolib" fixes the problem. What I don't know, though, is why
> >> the problem is only seen with omap2plus_defconfig, but not with multi_v7_defconfig,
> >> and why it is only seen with beagle/omap3-beagle.dtb but not with
> >> beaglexm/omap3-beagle-xm.dtb.
> >>
> >> The 'rb-gpios' property is only defined in omap3-beagle.dts, but not in
> >> omap3-beagle-xm.dts, which may be part of the explanation. That still doesn't
> >> explain, though, why multi_v7_defconfig still works, but not omap2plus_defconfig.
> >>
> >> Any ideas, anyone ?  
> >
> > I think you got it right for the DT changes: if rb-gpios is not
> > defined, it's working because the implementation fallback to "status
> > polling" mode, which is not relying on the new GPIO controller
> > implementation.
> > I don't know why it's working when using multi_v7_defconfig and not
> > with omap2_plus though (maybe a different probe order making
> > devm_gpiod_get_optional() return NULL instead of EPROBE_DEFER?).
> >
> > And the other question I have for Roger is, do you see a reason why the
> > rb-gpio mode would not work?
> >  
> 
> Hi Boris,
> 
> Turns out MTD_NAND_OMAP2 is not enabled on multi_v7_defconfig, thus the issue
> does not arise there.

Okay, this explains why you don't see this problem with multi_v7.

> After reverting 'mtd: nand: omap2: Implement NAND ready
> using gpiolib', the driver uses omap_wait(), which as far as I can see is never
> called in my tests. Since dev_ready is NULL in that case, it is never called
> either (the chip is just assumed to be always ready), and thus the problem
> does not arise.

That's not entirely true: the NAND chip is not assumed to be always
ready, the core just uses a different method to get the R/B status (by
reading the STATUS register using the NAND_CMD_STATUS command). But
you're right in that when you revert this commit you end up not using
the new GPIO controller exposed by the GPMC driver.

> 
> So the big difference is that the dev_info callback was not used prior to
> commit 'mtd: nand: omap2: Implement NAND ready using gpiolib', and that
> it is logically different to the wait function which was previously used.

Yes.

> 
> In qemu, it looks like gpmc bit 0 is considered to be the NAND chip select,
> which is distinctly different to a chip ready pin.

Well, if you look at the GPIO controller implementation, you'll see
that gpichip->get() is adding 8 to the GPIO index, so the
implementation is actually testing bit 8 and not bit 0. Maybe this is
not emulated properly in qemu though...

> Guess I would have to try
> finding a chip datasheet to figure out what this pin is supposed to do, and
> what is wrong. Since it is somewhat unlikely that I'll find the time to do that,
> I just disabled MTD_NAND_OMAP2 in my qemu tests instead. Not an ideal solution,
> of course, but the alternative would be to drop the beagle qemu tests entirely.

Long time I haven't looked at qemu code, but IIRC there were no proper
support for the NAND layer (maybe this has changed since then though).
And the R/B pin status emulation is probably much more complicated to
implement than just returning a valid STATUS byte in a generic NAND chip
emulation layer (you have to emulate the GPMC block and all its
external interfaces like the R/B IOs as well as the R/B pin
emulation at the NAND chip emulation level)...


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
