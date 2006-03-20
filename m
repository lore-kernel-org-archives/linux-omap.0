From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP emulation
Date: Mon, 20 Mar 2006 06:19:51 -0800
Message-ID: <20060320141948.GB4980@atomide.com>
References: <fb249edb0603170933m391da937w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0603170933m391da937w@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* andrzej zaborowski <balrog@zabor.org> [060317 09:35]:
> Hi,
> I started adding basic emulation for a OMAP 310 based system (the Palm
> Tungsten E device in particular) to the QEMU project (www.qemu.org)
> taking advantage of its already functional emulation of the ARM
> processor. Now it's already at a point where it lets me boot the some
> of same OMAP kernel builds on my PC using the emulator and on the real
> device using the Garux bootloader (garux.sourceforge.net). If anyone
> is interested, feel free to try it out although the emulator is still
> missing various parts. I'm hoping that it will help me debugging the
> drivers later. Also, QEMU runs linux at about double speed of the real
> device on my desktop PC so it might speed up testing.

Hey, that's cool!

> Here is what I have got working so far, and what the patch contains:
> 
>  - well, the processor: QEMU emulates an ARM 1026 but it turned out to
> be similar  enough to the TI 925. I really only had to change the
> identification numbers it returns to those of TI 925.
> 
>  - some of the basic "MPU subsystems", that is:
>  - the IRQ and FIQ generation from both level 1 and 2 banks of
> interrupts (with the right peripherals connected to the right
> interrupt lines.)
>  - timers: the three general purpose MPU timers.
>  - most of the configuration registers (actually many of them are only
> dummies because the emulator doesn't care about things like voltages,
> clocking schemes, or all the different types of caching.)
>  - the shared GPIO lines plus the 16 MPUIO GPIOs (with the rest of the
> peripherals connected to the right gpio pins like on my Palm.)
>  - a keyboard connected through the MPUI keypad interface (the keymap
> I used is not the one from the real device, it contains all the PC
> keys. You can change that easily.)
> 
>  - the OMAP DMA controller with 9 general channels and one dedicated
> channel for the LCD -- seems to be working but as you can imagine,
> it's difficult to emulate.

Hehe!
 
>  - the OMAP LCD controller with the QEMU display connected to it as
> the actual LCD -- only tested with 8 bit colour, the penguin looks
> fine.
> 
>  - an SD card emulator according to the SD specification (for those
> who don't know, SD cards have a whole little "computer" working in
> each of them.) Implements some security features too.
> 
>  - the OMAP MMC/SD host controller making use of the SD card emulator.
> Also emulates the card eject event and insertion of new cards, and can
> be accessed using either DMA or the registers. Unfortunately there's
> still something wrong with it -- linux panics after a few requests
> (but always reads the partition table fine), strange thing is that it
> panics in the generic block driver when it's trying to allocate memory
> for a new block of data from the card, not anywhere in MMC or OMAP
> drivers.
> 
>  - the microwire ports (only tested with registers access, no dma.)
> 
>  - a (part of the) TSC2301 chipset connected to the MPU using the
> microwire port. Currently only has some of the internal logic plus the
> touchscreen controller with the QEMU mouse input connected as the
> actual touchscreen. TSC2301 can also control audio inputs and outputs,
> a keypad (unused in Palm Tungsten E as the keypad is connected to the
> MPUI interface), temperature (also unused) and battery state monitors
> -- and these are not implemented.
> 
>  - the OMAP RTC with alarm and stuff. Through it the VM can access the
> host's clock.
> 
> The patch is at http://www.zabor.org/balrog/qemu-omap.patch (160 kB).
> The command line I use to launch QEMU is:
>    $ qemu-system-arm -M omap310 -kernel ./zImage
> You can add "-fda ./cardimage".
> Note however that I implemented most parts according to the
> documentation from ti.com (mostly OMAP 5910 docs) and not according to
> what Linux needed to work. Therefore, where linux drivers accessed
> non-existent (or undocumented) registers, or performed writes to
> read-only registers, or wrote values prohibited by the docs, I
> modified the kernel and not the emulator (and there was a number of
> such places). So QEMU is likely to exit with something like "fatal
> error: bad register access at ..." when you try booting Linux. In that
> case it can be:
>  - Linux drivers accessing non-existent registers, or
>  - Linux accessing a peripheral that QEMU doesn't emulate yet (e.g. USB).
> If that happens you can either fix the kernel or add dummy registers
> in QEMU or make QEMU ignore bad register accesses whatsoever (that's
> what the real device does). In the latter case, recompile kernel
> without support for the given peripheral device.
> I know that 310 is practically the simplest of OMAP boards because it
> doesn't have a DSP core and lacks a couple of other things. Almost all
> of the code can be reused for OMAP 1510 or 5910/5912 emulation though.
> Emualting other boards would require more changes.
> The patch is against QEMU 0.8.0 release. I have only tested it on a
> Linux/PC as host -- I'm pretty sure it won't work on little-endian
> machines (even though QEMU in general does work on PPC and other
> archs). It contains a bootloader code for Linux/ARM copied from the
> IntegratorCP board emulator by Paul Brook. It also contains pieces of
> code from Anthony Liguori's patch for WACOM tablet emulation, that
> enables QEMU reporting absolute coordinates (for the TSC2301
> touchscreen).
> 
> The purpose of this emulator was to help me fix a bug in the kernel
> that causes linux userspace to be extremely unstable -- unfortuntaly
> it turned out that the bug is not reproduced in the emulator,
> everything works perfectly fine in it. The bug was already mentioned
> on this list by X-Stranger
> (http://linux.omap.com/pipermail/linux-omap-open-source/2006-February/006399.html).

LOL, that's a lot of work to track down a bug :) Too bad it did not
help. But at least there's an omap emulator now.

> On the real device (Palm Tungsten E) kernel always boots fine but as
> soon as userspace kicks in, programs will hang, segfault or fail
> assertions (in case of glib based programs) to the point of being
> unusable. A given program binary with a given kernel binary always
> fails the same way and in the same moment of execution. However,
> adding or removing a single instruction in either the kernel or the
> program, changes the kind of error and the place where it happens
> (sometimes fixes the problem or breaks new things) -- not depending on
> the actual instruction that was added, more on the size of it and its
> placement in the code.
> Removing the accesses of non-existent registers from the kernel didn't
> help as I hoped it would. Since owners of OMAP 1510 devices don't
> report such problems and the emulator (based on 5910 docs) doesn't
> exhibit the bug either, our conclusion is that the differences between
> OMAP 310 and other boards are in the root of the bug. Alternatively,
> it could be a bootloader problem (we use Garux on the PDA). If anybody
> has an idea about what might be wrong, please tell.

Sounds like you have already verified the memory timings. Does it work
properly with caches disabled?

Regards,

Tony
