From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/11] OMAP2/3: PM: push core PM code from linux-omap
Date: Mon, 18 May 2009 10:08:36 -0700
Message-ID: <878wku8hkb.fsf@deeprootsystems.com>
References: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
	<1242412851-16606-2-git-send-email-khilman@deeprootsystems.com>
	<20090518133241.GH3067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:44865 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZERRIh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 13:08:37 -0400
Received: by pxi29 with SMTP id 29so2037693pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 10:08:38 -0700 (PDT)
In-Reply-To: <20090518133241.GH3067@n2100.arm.linux.org.uk> (Russell King's message of "Mon\, 18 May 2009 14\:32\:41 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Richard Woodruff <r-woodruff2@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

[ adding Richard W. to To: since he can probably shed some light here ]

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, May 15, 2009 at 11:40:41AM -0700, Kevin Hilman wrote:
>> This patch is to sync the core linux-omap PM code with mainline.  This
>> code has evolved and been used for a while the linux-omap tree, but
>> the attempt here is to finally get this into mainline.

[...]

[excerpt of sleep34xx.S]
>> +	/* IRQ mode */
>> +	bic    r0, r7, #0x1F
>> +	orr    r0, r0, #0x12
>> +	msr    cpsr, r0	/*go into IRQ mode*/
>> +	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM*/
>> +	mov    sp, r4	/*update the SP */
>> +	mov    lr, r5	/*update the LR */
>> +	msr    spsr, r6	/*update the SPSR */
>> +
>> +	/* ABORT mode */
>> +	bic    r0, r7, #0x1F
>> +	orr    r0, r0, #0x17
>> +	msr    cpsr, r0	/* go into ABORT mode */
>> +	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM */
>> +	mov    sp, r4		/*update the SP */
>> +	mov    lr, r5		/*update the LR */
>> +	msr    spsr, r6		/*update the SPSR */
>> +
>> +	/* UNDEEF mode */
>> +	bic    r0, r7, #0x1F
>> +	orr    r0, r0, #0x1B
>> +	msr    cpsr, r0		/*go into UNDEF mode */
>> +	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM */
>> +	mov    sp, r4		/*update the SP*/
>> +	mov    lr, r5		/*update the LR*/
>> +	msr    spsr, r6		/*update the SPSR*/
>> +
>> +	/* SYSTEM (USER) mode */
>> +	bic    r0, r7, #0x1F
>> +	orr    r0, r0, #0x1F
>> +	msr    cpsr, r0		/*go into USR mode */
>> +	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM*/
>> +	mov    sp, r4		/*update the SP */
>> +	mov    lr, r5		/*update the LR */
>> +	msr    spsr, r6		/*update the SPSR */
>> +	msr    cpsr, r7		/*back to original mode*/
>
> There is a function which re-initializes the abort mode registers already -
> cpu_init().  Please use that if possible instead.

Upon a quick glance, using cpu_init() would not cover all the things
that this code does.  cpu_init() only handles the init of sp for the
various modes, where this code saves/resores all the banked registers:
sp, lr and spsr as well as r8-r12 of FIQ mode.

The question in my mind however is whether the lr and spsr need to be
saved/restored?  Do we really need to preserve the context of these
handlers across idle?  Presumably we should not hit idle/suspend in
the middle of one of these handlers, so do we need to save anything
other than the stp?  Maybe Richard can shed some light here as to why
that was added.

Kevin
