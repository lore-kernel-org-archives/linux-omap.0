From: Rich Felker <dalias@libc.org>
Subject: Re: Regression with arm in next with stack protector
Date: Tue, 27 Mar 2018 11:36:28 -0400
Message-ID: <20180327153628.GJ1436@brightrain.aerifal.cx>
References: <20180323181452.GJ5799@atomide.com>
 <20180327090409.GA10990@n2100.armlinux.org.uk>
 <20180327113453.GC10990@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180327113453.GC10990@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-omap@vger.kernel.org, Huacai Chen <chenhc@lemote.com>, Andrew Morton <akpm@linux-foundation.org>, James Hogan <james.hogan@mips.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 27, 2018 at 12:34:53PM +0100, Russell King - ARM Linux wrote:
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
> Is there any reason we can't do this in misc.c:
> 
> const unsigned int __stack_chk_guard = 0x000a0dff;
> 
> ?  That would save having runtime code to set that value up, and after
> all, it is constant.  Arguments about it potentially ending up at a
> fixed offset into the image need not be said - that's already the case
> with placing it in the early assembly code, and as has been established,
> it needs to be initialised prior to any C code being called.

I've asked this multiple times in this thread and as far as I know
nobody has answered.

Rich
