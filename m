From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: public git l2 cache off.
Date: Sat, 10 May 2008 10:14:42 +0200
Message-ID: <48255972.6040500@googlemail.com>
References: <1209575641-25613-1-git-send-email-tony@atomide.com> <20080505131403.93d0a64d.jarkko.nikula@nokia.com> <3B6D69C3A9EBCA4BA5DA60D9130274290439AAD8@dlee13.ent.ti.com> <A9503EED-55EA-4656-AABD-A6DA28F717DA@student.utwente.nl> <3B6D69C3A9EBCA4BA5DA60D9130274290439AD2F@dlee13.ent.ti.com> <4BE5184F-5D21-4487-B19A-DCA436A9C77E@student.utwente.nl> <3B6D69C3A9EBCA4BA5DA60D9130274290439AE8F@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:39404 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYEJIOt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2008 04:14:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1094110fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 10 May 2008 01:14:47 -0700 (PDT)
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290439AE8F@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org

Richard,

Woodruff, Richard wrote:
>>Beagleboard (omap3530)
>>
>>
>>>I'll try the latest from here on SDP with this and see if it works.
>>>There is also a difference in CR handling.  I had submitted long
>>>back a fix to Russell but let it get by me as I didn't have the time
>>>to fix per his comments.  I think our version was more correct then
>>>the one in place but was still lacking a bit.
>>>
>>>[*] It seems possible you could have an issue depending on what your
>>>boot loader is or isn't doing for you.
>>
>>U-boot (both 1.1.4 and 1.3.2) calls l2disable() before booting linux,
>>so linux needs to enable it. I vote for removing the l2disable() in u-
>>boot, but I can see that people might be stuck with broken binary
>>bootloaders...
> 
> 
> Yes, this 'might' help for some users if it works.  Traditionally things usually have had some complications here at multiple levels in both hardware and software.  And yes not everyone can upgrade a boot loader.  However, with expanding boot from MMC/SD support things are getting safer.
> 
> The bit I was more worried about was the boot loader may not be invalidating secure L2 tags correctly.  The method to do this correctly is a little different between EMU/HS and GP devices.  Also these base methods changed some between ES1 and ES2 of the chip.  I hope no one is using an ES1 anymore but I'm sure code remnants exist.
> 
> The working code variants did some work in u-boot and some in the kernel to handle these conditions.  The current balance today in working variants today has u-boot doing more work.  This probably merges with fewer conflicts with the arm-kernel.  Last I checked u-boot on Beagle was a based on an older version of the code and probably even a wider range of versions exist in the community.  As such it's a good bet some of this is at the root of the problems you are seeing.

On Beagle, we use ES2 GP device. From discussion on ARM kernel list 
[1] we learned that it's the job of bootloader to initialize L2 cache 
correctly. Thanks to Khasim we have a patch to enable L2 cache in 
kernel [2], but this is only to work around "broken" bootloaders. So, 
we need fixed bootloader (e.g. U-Boot) doing L2 cache initialization 
correctly.

Currently, in U-Boot used for Beagle we have the following (L2) cache 
handling (cleaned up for easier reading). Do you think this is 
correct? Can we simply add a l2cache_enable() at the end of following 
code or do we have to do/fix/change more to pass correctly configured 
caches from U-Boot to kernel?

-- cut --
At U-Boot start:

l2cache_enable() for CPU_3430_ES2:

__asm__ __volatile__("mrc p15, 0, %0, c1, c0, 1":"=r" (i));
__asm__ __volatile__("orr %0, %0, #0x2":"=r"(i));
__asm__ __volatile__("mcr p15, 0, %0, c1, c0, 1":"=r" (i));

...
do U-Boot work
...
then just before kernel is called:

cleanup_before_linux():

/* turn off I/D-cache */
asm ("mrc p15, 0, %0, c1, c0, 0":"=r" (i));
i &= ~(C1_DC | C1_IC);
asm ("mcr p15, 0, %0, c1, c0, 0": :"r" (i));

/* invalidate I-cache */
mcr	p15, 0, r1, c7, c5, 0	@ invalidate I cache

/* turn off L2 cache */
__asm__ __volatile__("mrc p15, 0, %0, c1, c0, 1":"=r" (i));
__asm__ __volatile__("bic %0, %0, #0x2":"=r"(i));
__asm__ __volatile__("mcr p15, 0, %0, c1, c0, 1":"=r" (i));

/* invalidate L2 cache also */
v7_flush_dcache_all(get_device_type()):

	mov	r7, r0				@ take a backup of device type
	cmp	r0, #0x3			@ check if the device type is GP
	moveq r12, #0x1				@ set up to invalide L2	
smi: 	.word 0x01600070			@ Call SMI monitor (smieq)
	cmp	r7, #0x3			@ compare again in case its lost
	beq	finished_inval			@ if GP device, inval done above

	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
	ands	r3, r0, #0x7000000		@ extract loc from clidr
	mov	r3, r3, lsr #23			@ left align loc bit field
	beq	finished_inval			@ if loc is 0, then no need to clean
	mov	r10, #0				@ start clean at cache level 0
inval_loop1:
	add	r2, r10, r10, lsr #1		@ work out 3x current cache level
	mov	r1, r0, lsr r2			@ extract cache type bits from clidr
	and	r1, r1, #7			@ mask of the bits for current cache only
	cmp	r1, #2				@ see what cache we have at this level
	blt	skip_inval				@ skip if no cache, or just i-cache
	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
	isb					@ isb to sych the new cssr&csidr
	mrc	p15, 1, r1, c0, c0, 0		@ read the new csidr
	and	r2, r1, #7			@ extract the length of the cache lines
	add	r2, r2, #4			@ add 4 (line length offset)
	ldr	r4, =0x3ff
	ands	r4, r4, r1, lsr #3		@ find maximum number on the way size
	clz	r5, r4				@ find bit position of way size increment
	ldr	r7, =0x7fff
	ands	r7, r7, r1, lsr #13		@ extract max number of the index size
inval_loop2:
	mov	r9, r4				@ create working copy of max way size
inval_loop3:
	orr	r11, r10, r9, lsl r5		@ factor way and cache number into r11
	orr	r11, r11, r7, lsl r2		@ factor index number into r11
	mcr	p15, 0, r11, c7, c6, 2		@ invalidate by set/way
	subs	r9, r9, #1			@ decrement the way
	bge	inval_loop3
	subs	r7, r7, #1			@ decrement the index
	bge	inval_loop2
skip_inval:
	add	r10, r10, #2			@ increment cache number
	cmp	r3, r10
	bgt	inval_loop1
finished_inval:
	mov	r10, #0				@ swith back to cache level 0
	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
	isb

i = 0;
/* mem barrier to sync up things */
asm ("mcr p15, 0, %0, c7, c10, 4": :"r" (i));

??? Insert here l2cache_enable()  ???
...
Start kernel
-- cut --

Many thanks and best regards

Dirk

[1] 
http://lists.arm.linux.org.uk/lurker/message/20080506.204317.a16f4c73.en.html

[2] http://marc.info/?l=linux-omap&m=121014615706359&w=2

