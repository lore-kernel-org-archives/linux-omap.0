From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] kexec issue with v4.15-rc on N8x0
Date: Wed, 24 Jan 2018 23:21:33 +0200
Message-ID: <20180124212133.qyav5w36meljaakq@darkstar.musicnaut.iki.fi>
References: <20180111194747.k5qwz66mfntj6v2g@darkstar.musicnaut.iki.fi>
 <20180115181508.GM4821@atomide.com>
 <20180122220654.k6atriweesf2qmw4@darkstar.musicnaut.iki.fi>
 <20180123204544.GM28231@n2100.armlinux.org.uk>
 <20180123212327.GN28231@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180123212327.GN28231@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Jan 23, 2018 at 09:23:27PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 23, 2018 at 08:45:44PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 23, 2018 at 12:06:54AM +0200, Aaro Koskinen wrote:
> > > On Mon, Jan 15, 2018 at 10:15:08AM -0800, Tony Lindgren wrote:
> > > > * Aaro Koskinen <aaro.koskinen@iki.fi> [180111 11:48]:
> > > > > When booting v4.15-rc kernel with kexec (kexec-tools 2.0.16) on N8x0, I get:
> > > > > 
> > > > >     Uncompressing Linux... done, booting the kernel.
> > > > >     no ATAGS support: can't continue
> > > > > 
> > > > > v4.14 kernel works OK.
> > > > > 
> > > > > I bisected this to:
> > > > > 
> > > > > commit c772568788b5f0cbaac7c8d4111d7173bfc90673
> > > > > Author: Russell King <rmk+kernel@armlinux.org.uk>
> > > > > Date:   Thu Sep 21 18:10:19 2017 +0100
> > > > > 
> > > > >     ARM: add additional table to compressed kernel
> > > > > 
> > > > > If I revert the commit, kexec booting starts to work. Interesting,
> > > > > the patch mentions "This is necessary for correct behaviour of kexec.",
> > > > > so I wonder what could be wrong...
> > > > 
> > > > So care to post what you get if you load with kexec -d -l options
> > > > before and after this commit?
> > > 
> > > See below. I guess the interesting part is the "zImage has tags" with the
> > > bad kernel.
> > > 
> > > Bad (plain v4.15-rc9)
> > > ---------------------
> > > kernel: 0xb6a25008 kernel_size: 0x3ce605
> > > MEMORY RANGES
> > > 0000000080000000-0000000087ffffff (0)
> > > zImage header: 0x016f2818 0x00000000 0x003c59d0
> > > zImage size 0x3c59d0, file size 0x3ce605
> > 
> > This looks like you've appended a DTB blob to the zImage as the file
> > is larger than the zImage says it should be.

Yes. I have now disabled/removed the appended DTB, just in case, but it
doesn't seem to make any difference.

> > Right, so this says that this is a "modern" kernel that's being loaded
> > with the additional tags in that tell kexec how much space the
> > decompressed kernel requires.
> > 
> > > kernel image size: 0x00c5c6ec
> > 
> > and it requires this amount of space.
> > 
> > > kexec_load: entry = 0x80008000 flags = 0x280000
> > > nr_segments = 2
> > > segment[0].buf   = 0xb6a25008
> > > segment[0].bufsz = 0x3c59d0
> > > segment[0].mem   = 0x80008000
> > > segment[0].memsz = 0x3c6000
> > 
> > This is the kernel, with the appended dtb removed.
> > 
> > > segment[1].buf   = 0x1ed52b8
> > > segment[1].bufsz = 0x8c35
> > > segment[1].mem   = 0x80c66000
> > > segment[1].memsz = 0x9000
> > 
> > This is the DTB, placed out of the way from the kernel (the highest
> > address the kernel will use while decompressing is 0x00c5c6ec +
> > 0x80008000.  Everything here looks correct.

But something is still corrupting the DTB...

> > > [    4.850341] kexec_core: Starting new kernel
> > > [    4.854766] Bye!
> > > 
> > > (kernel fails to boot)
> > > 
> > > Good (v4.15-rc9 and c772568788b5f0cbaac7c8d4111d7173bfc90673 reverted)
> > > -----------------------------
> > > kernel: 0xb6999008 kernel_size: 0x3ce9bd
> > > MEMORY RANGES
> > > 0000000080000000-0000000087ffffff (0)
> > > zImage header: 0x016f2818 0x00000000 0x003c5d88
> > > zImage size 0x3c5d88, file size 0x3ce9bd
> > > kexec_load: entry = 0x80008000 flags = 0x280000
> > > nr_segments = 2
> > > segment[0].buf   = 0xb6999008
> > > segment[0].bufsz = 0x3c5d88
> > > segment[0].mem   = 0x80008000
> > > segment[0].memsz = 0x3c6000
> > 
> > Here we have the same thing for the kernel.
> > 
> > > segment[1].buf   = 0x14192b8
> > > segment[1].bufsz = 0x8c35
> > > segment[1].mem   = 0x812e7000
> > > segment[1].memsz = 0x9000
> > 
> > Here, the DTB is placed much further away.

So, the "compression ratio 4 calculation" works better.

> > It really doesn't help that it took ages for the kexec-tools patches
> > to get merged, and when they did get merged, the wrong patch set was
> > taken.  Consequently, the debug above does not match my local source
> > tree, and neither does the code.
> > 
> > Sorry, but I'm afraid I can't debug this at the moment.
> 
> Here's the delta between what _was_ merged and what I intended to be
> merged:
> 
> 8<=====
> From: Russell King <rmk@armlinux.org.uk>
> Subject: [PATCH] ARM: read kernel size from zImage

I tried this, output looks different but the kernel is still unbootable.
I also tried switching from XZ to GZIP decompressor, but it didn't help
either.

kernel: 0xb68e7008 kernel_size: 0x56cdf0
MEMORY RANGES
0000000080000000-0000000087ffffff (0)
zImage header: 0x016f2818 0x00000000 0x0056cdf0
zImage size 0x56cdf0, file size 0x56cdf0
  offset 0x000039c0 tag 0x5a534c4b size 8
Kernel: address=0x80008000 size=0x010b4d90
DT    : address=0x810be000 size=0x00008c35
kexec_load: entry = 0x80008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0xb68e7008
segment[0].bufsz = 0x56cdf0
segment[0].mem   = 0x80008000
segment[0].memsz = 0x56d000
segment[1].buf   = 0x7622b8
segment[1].bufsz = 0x8c35
segment[1].mem   = 0x810be000
segment[1].memsz = 0x9000
[    5.070251] kexec_core: Starting new kernel
[    5.074676] Bye!

Then I played around with kexec_arm_image_size in kexec-tools, and
noticed that adding only 0x2000 gets booting to work:

kernel: 0xb681f008 kernel_size: 0x56cdf0
MEMORY RANGES
0000000080000000-0000000087ffffff (0)
zImage header: 0x016f2818 0x00000000 0x0056cdf0
zImage size 0x56cdf0, file size 0x56cdf0
  offset 0x000039c0 tag 0x5a534c4b size 8
Kernel: address=0x80008000 size=0x010b6d90
DT    : address=0x810c0000 size=0x00008c35
kexec_load: entry = 0x80008000 flags = 0x280000
nr_segments = 2
segment[0].buf   = 0xb681f008
segment[0].bufsz = 0x56cdf0
segment[0].mem   = 0x80008000
segment[0].memsz = 0x56d000
segment[1].buf   = 0x9412b8
segment[1].bufsz = 0x8c35
segment[1].mem   = 0x810c0000
segment[1].memsz = 0x9000
[    5.070312] kexec_core: Starting new kernel
[    5.074737] Bye!
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.15.0-rc9-n8x0-los_a513f+ (aaro@amd-fx-6350) (gcc version 6.4.0 (GCC)) #1 Wed Jan 24 21:30:47 EET 2018
[...]

So something is missing from the size calculation...?

A.
