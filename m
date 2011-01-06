From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430SDP boot failure
Date: Thu, 6 Jan 2011 12:40:54 -0800
Message-ID: <20110106204053.GA7771@atomide.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
 <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com>
 <20110106203238.GH1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53899 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab1AFUlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 15:41:06 -0500
Content-Disposition: inline
In-Reply-To: <20110106203238.GH1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 12:32]:
> On Thu, Jan 06, 2011 at 10:20:23AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 10:00]:
> > > can't be in the BSS section?
> > 
> > BSS works too, got a patch for that?
> 
> Yes.
> 
> sed -i '/\.pushsection \.data/,/\.popsection/ {
> 	s/\.data/.bss/;
> 	s/.word\t0/.space\t4/;
> }' arch/arm/mach-omap2/include/mach/debug-macro.S

That does not work as BSS gets cleared in head-common.S.. See my other patch.
 
> > Can you please check if you have some older bootloader that passes
> > some wrong machine ID? 
> 
> If previous kernels didn't explicitly force the SDP4430 platform ID
> number (which they didn't for OMAP back to 2007), then it must be
> correct as previous kernels booted fine when only configured for
> the SDP4430.
> 
> It must also be correct as the decompressor can select the correct port
> for outputting the "Decompressing kernel..." message.
> 
> So by implication I think we can say that the ID number is correct.

OK thanks.
 
> I've just tried forcing it to use OMAP4 UART3, which seems to be what
> the decompressor is using for its output:
> 
> 0000090c <puts>:
>      90c:       e3a03802        mov     r3, #131072     ; 0x20000
>      910:       e38314fa        orr     r1, r3, #-100663296     ; 0xfa000000
>      914:       e3833312        orr     r3, r3, #1207959552     ; 0x48000000
>      918:       e4d02001        ldrb    r2, [r0], #1
>      91c:       e3320000        teq     r2, #0  ; 0x0
>      920:       01a0f00e        moveq   pc, lr
>      924:       e5c32000        strb    r2, [r3]
>      928:       e3a01802        mov     r1, #131072     ; 0x20000
>      92c:       e2511001        subs    r1, r1, #1      ; 0x1
>      930:       1afffffd        bne     92c <puts+0x20>
>      934:       e332000a        teq     r2, #10 ; 0xa
>      938:       03a0200d        moveq   r2, #13 ; 0xd
>      93c:       0afffff8        beq     924 <puts+0x18>
>      940:       e3300000        teq     r0, #0  ; 0x0
>      944:       1afffff3        bne     918 <puts+0xc>
>      948:       e1a0f00e        mov     pc, lr
> 
> 0x48020000 is the only UART address contained within the disassembly for
> the decompressor to use, so that must be the correct address.
> 
> However, even with that, it causes the 'X-Loader hangs' before producing
> any output.  No idea what to try next - and it's soo much hastle to keep
> moving SD cards around - which the laptop sometimes doesn't recognise -
> just to try new kernels that I'm wasting quite a bit of effort on each
> iteration it's untrue.
> 
> As I said previously, I think someone else can look into this - someone
> who understands the hardware quirks of OMAP, who has a decent test setup,
> and has the tools necessary to do hardware debug on OMAP.

I think I got it fixed, see the other patch I just posted.
 
> (If it could do dhcp/tftp - and be configured to do that from powerup
> without interruption, then I might feel differently as that would
> significantly reduce the hastle factor and amount of time involved with
> testing each iteration.)

Yes these new boards badly need the Ethernet working in u-boot..

Anyways, I can debug the DEBUG_LL booting issue further if the patch
I posted does not help.

Regards,

Tony
