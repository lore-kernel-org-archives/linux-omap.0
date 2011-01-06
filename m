From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 20:32:38 +0000
Message-ID: <20110106203238.GH1198@n2100.arm.linux.org.uk>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk> <20110106182023.GV7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50137 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab1AFUcq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 15:32:46 -0500
Content-Disposition: inline
In-Reply-To: <20110106182023.GV7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jan 06, 2011 at 10:20:23AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 10:00]:
> > On Thu, Jan 06, 2011 at 05:08:05PM +0000, Russell King - ARM Linux wrote:
> > > This looks like something's rather broken on OMAP4 too - even with the
> > > DEBUG_LL stuff enabled and my printk hack, I get nothing more, same with
> > > vanilla 2.6.37.  So, no OMAP platform I have seems to be usable with
> > > 2.6.37...
> > > 
> > > It's worth noting that the kernel which was originally supplied with the
> > > board works fine (2.6.31-00682-g49ab82a-dirty) with this uboot, as have
> > > previous kernels I've built.
> > > 
> > > Is there yet an updated uboot for this platform which works with ethernet,
> > > and which has the uboot environment saving implemented?  Or are we stuck
> > > with having to catch uboot before it runs the default settings and paste
> > > the commands in each time?  Also, if possible please extend the default
> > > timeout - I can only just get from the board to the terminal to stop it
> > > booting the default environment.
> > > 
> > > For TI folk: it may be an idea to make X-loader say why it's hanging so
> > > that we know what is going on.
> > 
> > And another thing: turning on DEBUG in the decompressor breaks the build
> > on OMAP:
> > 
> > `.data' referenced in section `.text' of arch/arm/boot/compressed/head.o: defined in discarded section `.data' of arch/arm/boot/compressed/head.o
> > `.data' referenced in section `.text' of arch/arm/boot/compressed/head.o: defined in discarded section `.data' of arch/arm/boot/compressed/head.o
> > 
> > Is there a reason why this:
> > 
> >                 .pushsection .data
> > omap_uart_phys: .word   0
> > omap_uart_virt: .word   0
> > omap_uart_lsr:  .word   0
> >                 .popsection
> > 
> > can't be in the BSS section?
> 
> BSS works too, got a patch for that?

Yes.

sed -i '/\.pushsection \.data/,/\.popsection/ {
	s/\.data/.bss/;
	s/.word\t0/.space\t4/;
}' arch/arm/mach-omap2/include/mach/debug-macro.S

> > With that fixed, and a debug version of the decompressor built, when I
> > load and run this I get the same results - without the debugging output.
> > If I put additional debugging earlier in the decompressor, I don't see
> > it decompressing the kernel at all.
> > 
> > Therefore, I believe the debugging address calculation stuff in
> > arch/arm/mach-omap2/include/mach/debug-macros.S to be rather broken,
> > causing an abort when it tries to access the serial port.
> 
> Can you please check if you have some older bootloader that passes
> some wrong machine ID? 

If previous kernels didn't explicitly force the SDP4430 platform ID
number (which they didn't for OMAP back to 2007), then it must be
correct as previous kernels booted fine when only configured for
the SDP4430.

It must also be correct as the decompressor can select the correct port
for outputting the "Decompressing kernel..." message.

So by implication I think we can say that the ID number is correct.

I've just tried forcing it to use OMAP4 UART3, which seems to be what
the decompressor is using for its output:

0000090c <puts>:
     90c:       e3a03802        mov     r3, #131072     ; 0x20000
     910:       e38314fa        orr     r1, r3, #-100663296     ; 0xfa000000
     914:       e3833312        orr     r3, r3, #1207959552     ; 0x48000000
     918:       e4d02001        ldrb    r2, [r0], #1
     91c:       e3320000        teq     r2, #0  ; 0x0
     920:       01a0f00e        moveq   pc, lr
     924:       e5c32000        strb    r2, [r3]
     928:       e3a01802        mov     r1, #131072     ; 0x20000
     92c:       e2511001        subs    r1, r1, #1      ; 0x1
     930:       1afffffd        bne     92c <puts+0x20>
     934:       e332000a        teq     r2, #10 ; 0xa
     938:       03a0200d        moveq   r2, #13 ; 0xd
     93c:       0afffff8        beq     924 <puts+0x18>
     940:       e3300000        teq     r0, #0  ; 0x0
     944:       1afffff3        bne     918 <puts+0xc>
     948:       e1a0f00e        mov     pc, lr

0x48020000 is the only UART address contained within the disassembly for
the decompressor to use, so that must be the correct address.

However, even with that, it causes the 'X-Loader hangs' before producing
any output.  No idea what to try next - and it's soo much hastle to keep
moving SD cards around - which the laptop sometimes doesn't recognise -
just to try new kernels that I'm wasting quite a bit of effort on each
iteration it's untrue.

As I said previously, I think someone else can look into this - someone
who understands the hardware quirks of OMAP, who has a decent test setup,
and has the tools necessary to do hardware debug on OMAP.

(If it could do dhcp/tftp - and be configured to do that from powerup
without interruption, then I might feel differently as that would
significantly reduce the hastle factor and amount of time involved with
testing each iteration.)
