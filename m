From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] kexec issue with v4.15-rc on N8x0
Date: Tue, 23 Jan 2018 00:32:59 +0200
Message-ID: <20180122223259.v5qumil2fvw2k7pt@darkstar.musicnaut.iki.fi>
References: <20180111194747.k5qwz66mfntj6v2g@darkstar.musicnaut.iki.fi>
 <20180115181508.GM4821@atomide.com>
 <20180122220654.k6atriweesf2qmw4@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180122220654.k6atriweesf2qmw4@darkstar.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Eric Biederman <ebiederm@xmission.com>, horms@verge.net.au, kexec@lists.infradead.org
Cc: Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

(Adding also kexec people...)

On Tue, Jan 23, 2018 at 12:06:54AM +0200, Aaro Koskinen wrote:
> On Mon, Jan 15, 2018 at 10:15:08AM -0800, Tony Lindgren wrote:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [180111 11:48]:
> > > When booting v4.15-rc kernel with kexec (kexec-tools 2.0.16) on N8x0, I get:
> > > 
> > >     Uncompressing Linux... done, booting the kernel.
> > >     no ATAGS support: can't continue
> > > 
> > > v4.14 kernel works OK.
> > > 
> > > I bisected this to:
> > > 
> > > commit c772568788b5f0cbaac7c8d4111d7173bfc90673
> > > Author: Russell King <rmk+kernel@armlinux.org.uk>
> > > Date:   Thu Sep 21 18:10:19 2017 +0100
> > > 
> > >     ARM: add additional table to compressed kernel
> > > 
> > > If I revert the commit, kexec booting starts to work. Interesting,
> > > the patch mentions "This is necessary for correct behaviour of kexec.",
> > > so I wonder what could be wrong...
> > 
> > So care to post what you get if you load with kexec -d -l options
> > before and after this commit?
> 
> See below. I guess the interesting part is the "zImage has tags" with the
> bad kernel.
> 
> Bad (plain v4.15-rc9)
> ---------------------
> kernel: 0xb6a25008 kernel_size: 0x3ce605
> MEMORY RANGES
> 0000000080000000-0000000087ffffff (0)
> zImage header: 0x016f2818 0x00000000 0x003c59d0
> zImage size 0x3c59d0, file size 0x3ce605
> zImage has tags
>   offset 0x00003be0 tag 0x5a534c4b size 8
> kernel image size: 0x00c5c6ec
> kexec_load: entry = 0x80008000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0xb6a25008
> segment[0].bufsz = 0x3c59d0
> segment[0].mem   = 0x80008000
> segment[0].memsz = 0x3c6000
> segment[1].buf   = 0x1ed52b8
> segment[1].bufsz = 0x8c35
> segment[1].mem   = 0x80c66000
> segment[1].memsz = 0x9000
> [    4.850341] kexec_core: Starting new kernel
> [    4.854766] Bye!
> 
> (kernel fails to boot)
> 
> Good (v4.15-rc9 and c772568788b5f0cbaac7c8d4111d7173bfc90673 reverted)
> -----------------------------
> kernel: 0xb6999008 kernel_size: 0x3ce9bd
> MEMORY RANGES
> 0000000080000000-0000000087ffffff (0)
> zImage header: 0x016f2818 0x00000000 0x003c5d88
> zImage size 0x3c5d88, file size 0x3ce9bd
> kexec_load: entry = 0x80008000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0xb6999008
> segment[0].bufsz = 0x3c5d88
> segment[0].mem   = 0x80008000
> segment[0].memsz = 0x3c6000
> segment[1].buf   = 0x14192b8
> segment[1].bufsz = 0x8c35
> segment[1].mem   = 0x812e7000
> segment[1].memsz = 0x9000
> [    4.860473] kexec_core: Starting new kernel
> [    4.864898] Bye!
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.15.0-rc9-n8x0-los_ecc96+-00001-g0a003b4 (aaro@amd-fx-6350) (gcc version 6.4.0 (GCC)) #1 Mon Jan 22 23:43:19 EET 2018
> [    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387d
> [    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt: Machine model: Nokia N810
> [...]
> 
> (kernel boots fine)
> 
> > Also, I wonder if Linux next commit 55e7cff44c7c ("ARM: verify
> > size of zImage") helps here?
> 
> No difference.

Looks like downgrading kexec-tools from .16 to 2.0.15 helps.

So it seems the latest kexec-tools is incompatible with the latest kernel
on ARM?

A.
