From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Regression with arm in next with stack protector
Date: Tue, 27 Mar 2018 18:20:27 +0100
Message-ID: <20180327172027.GA14598@n2100.armlinux.org.uk>
References: <20180323181452.GJ5799@atomide.com>
 <20180327090409.GA10990@n2100.armlinux.org.uk>
 <20180327153525.GI1436@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180327153525.GI1436@brightrain.aerifal.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: Rich Felker <dalias@libc.org>
Cc: Tony Lindgren <tony@atomide.com>, Huacai Chen <chenhc@lemote.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <james.hogan@mips.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 27, 2018 at 11:35:25AM -0400, Rich Felker wrote:
> On Tue, Mar 27, 2018 at 10:04:10AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Mar 23, 2018 at 11:14:53AM -0700, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > Looks like commit 5638790dadae ("zboot: fix stack protector in
> > > compressed boot phase") breaks booting on arm.
> > > 
> > > This is all I get from the bootloader on omap3:
> > > 
> > > Starting kernel ...
> > > 
> > > data abort
> > > pc : [<810002d0>]          lr : [<100110a8>]
> > > reloc pc : [<9d6002d0>]    lr : [<2c6110a8>]
> > > sp : 81467c18  ip : 81466bf0     fp : 81466bf0
> > > r10: 80fc2c40  r9 : 81000258     r8 : 86fec000
> > > r7 : ffffffff  r6 : 81466bf8     r5 : 00000000  r4 : 80008000
> > > r3 : 81466c14  r2 : 81466c18     r1 : 000a0dff  r0 : 00466bf8
> > > Flags: nZCv  IRQs off  FIQs off  Mode SVC_32
> > > Resetting CPU ...
> > > 
> > > resetting ...
> > 
> > The reason for this is the following code that was introduced by the
> > referenced patch:
> > 
> > +               ldr     r0, =__stack_chk_guard
> > +               ldr     r1, =0x000a0dff
> > +               str     r1, [r0]
> > 
> > This uses the absolute address of __stack_chk_guard in the decompressor,
> > which is a self-relocatable image.  As with all constructs like the
> > above, this absolute address doesn't get fixed up, and so it ends up
> > pointing at invalid memory (in this case 0x466bf8) vs RAM at 0x80000000,
> > and the decompressor looks to be around 0x81000000.
> > 
> > Such constructs can not be used in the decompressor for exactly this
> > reason - they need to use PC-relative addressing instead just like
> > everything else does in head.S.
> 
> Can someone please answer why this is even needed to begin with? I
> don't see any compelling reason __stack_chk_guard needs a particular
> value in the decompressor, which is not dealing with any non-constant
> input.

Untrue - it can do some parsing of the DT and updating/appending
information from ATAGs.  However, all that should be coming from
a trusted environment, so I don't see much of a "trust" issue here.
(If the parent environment is not trusted, then the environment we're
running in is not trusted.)

> Just putting __stack_chk_guard in its bss should be fine and
> would eliminate all the risks of wrong code to load a value into it.
> Alternatively put it in initialized data with the desired value.

I'm no expert with this, so I can't comment.  I build my kernels
with gcc 4.7.4, which I don't think supports this feature.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
