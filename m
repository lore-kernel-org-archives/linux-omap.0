From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Fri, 09 Sep 2011 11:34:48 -0700
Message-ID: <87hb4lwomv.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
	<20110909080416.GF31581@S2100-06.ap.freescale.net>
	<4E69C9CF.6090709@ti.com>
	<20110909141321.GC32138@S2100-06.ap.freescale.net>
	<CAMQu2gxeDzFGyhsXK-wDkyiJRoD6_GN58m=3_=NC8yKa_ThJnQ@mail.gmail.com>
	<20110909152729.GG32138@S2100-06.ap.freescale.net>
	<4E6A4605.3050305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:37766 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759390Ab1IISev (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 14:34:51 -0400
Received: by mail-gy0-f170.google.com with SMTP id 11so621288gyb.1
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 11:34:51 -0700 (PDT)
In-Reply-To: <4E6A4605.3050305@ti.com> (Santosh's message of "Fri, 09 Sep 2011
	22:29:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, Dave Martin <dave.martin@linaro.org>

Santosh <santosh.shilimkar@ti.com> writes:

> On Friday 09 September 2011 08:57 PM, Shawn Guo wrote:
>> On Fri, Sep 09, 2011 at 07:41:08PM +0530, Shilimkar, Santosh wrote:
>>> On Fri, Sep 9, 2011 at 7:43 PM, Shawn Guo<shawn.guo@freescale.com>  wrote:
>>>> On Fri, Sep 09, 2011 at 01:39:51PM +0530, Santosh wrote:
>>>>> On Friday 09 September 2011 01:34 PM, Shawn Guo wrote:
>>>>>> Hi Santosh,
>
> [...]
>
>>> #ifdef CONFIG_CACHE_L2X0
>>> 	/*
>>> 	 * Clean and invalidate the L2 cache.
>>> 	 * Common cache-l2x0.c functions can't be used here since it
>>> 	 * uses spinlocks. We are out of coherency here with data cache
>>> 	 * disabled. The spinlock implementation uses exclusive load/store
>>> 	 * instruction which can fail without data cache being enabled.
>>> 	 * OMAP4 hardware doesn't support exclusive monitor which can
>>> 	 * overcome exclusive access issue. Because of this, CPU can
>>> 	 * lead to deadlock.
>>> 	 */
>>> l2x_clean_inv:
>>> 	bl	omap4_get_sar_ram_base
>>> 	mov	r8, r0
>>> 	mrc	p15, 0, r5, c0, c0, 5		@ Read MPIDR
>>> 	ands	r5, r5, #0x0f
>>> 	ldreq	r0, [r8, #L2X0_SAVE_OFFSET0]
>>> 	ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]
>>> 	cmp	r0, #3
>>> 	bne	do_WFI
>>
>> It looks like you are bypassing L2 clean and invalidate for cases
>> "1" and "2" here.  But I really do not understand how you get r0
>> back here.
>>
> The value which is passed in R0 is also stored in scratch patch memory
> and retrieved using L2X0_SAVE_OFFSET0.
> Simple :)

Sounds like some in-code documentation needs to be added to make this a
bit more understandable.

Thanks,

Kevin
