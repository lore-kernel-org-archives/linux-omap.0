From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Sat, 10 Sep 2011 09:09:38 +0530
Message-ID: <CAMQu2gw2raiP19YSztMEGxt-t9bRigNc3u7s5w3Nk08A3xK+rA@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
 <20110909080416.GF31581@S2100-06.ap.freescale.net> <4E69C9CF.6090709@ti.com>
 <20110909141321.GC32138@S2100-06.ap.freescale.net> <CAMQu2gxeDzFGyhsXK-wDkyiJRoD6_GN58m=3_=NC8yKa_ThJnQ@mail.gmail.com>
 <20110909152729.GG32138@S2100-06.ap.freescale.net> <4E6A4605.3050305@ti.com> <87hb4lwomv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:54797 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757112Ab1IJDj7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Sep 2011 23:39:59 -0400
Received: by gxk27 with SMTP id 27so1833894gxk.1
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 20:39:58 -0700 (PDT)
In-Reply-To: <87hb4lwomv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, Dave Martin <dave.martin@linaro.org>

On Sat, Sep 10, 2011 at 12:04 AM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh <santosh.shilimkar@ti.com> writes:
>
>> On Friday 09 September 2011 08:57 PM, Shawn Guo wrote:
>>> On Fri, Sep 09, 2011 at 07:41:08PM +0530, Shilimkar, Santosh wrote:
>>>> On Fri, Sep 9, 2011 at 7:43 PM, Shawn Guo<shawn.guo@freescale.com>=
 =A0wrote:
>>>>> On Fri, Sep 09, 2011 at 01:39:51PM +0530, Santosh wrote:
>>>>>> On Friday 09 September 2011 01:34 PM, Shawn Guo wrote:
>>>>>>> Hi Santosh,
>>
>> [...]
>>
>>>> #ifdef CONFIG_CACHE_L2X0
>>>> =A0 =A0 /*
>>>> =A0 =A0 =A0* Clean and invalidate the L2 cache.
>>>> =A0 =A0 =A0* Common cache-l2x0.c functions can't be used here sinc=
e it
>>>> =A0 =A0 =A0* uses spinlocks. We are out of coherency here with dat=
a cache
>>>> =A0 =A0 =A0* disabled. The spinlock implementation uses exclusive =
load/store
>>>> =A0 =A0 =A0* instruction which can fail without data cache being e=
nabled.
>>>> =A0 =A0 =A0* OMAP4 hardware doesn't support exclusive monitor whic=
h can
>>>> =A0 =A0 =A0* overcome exclusive access issue. Because of this, CPU=
 can
>>>> =A0 =A0 =A0* lead to deadlock.
>>>> =A0 =A0 =A0*/
>>>> l2x_clean_inv:
>>>> =A0 =A0 bl =A0 =A0 =A0omap4_get_sar_ram_base
>>>> =A0 =A0 mov =A0 =A0 r8, r0
>>>> =A0 =A0 mrc =A0 =A0 p15, 0, r5, c0, c0, 5 =A0 =A0 =A0 =A0 =A0 @ Re=
ad MPIDR
>>>> =A0 =A0 ands =A0 =A0r5, r5, #0x0f
>>>> =A0 =A0 ldreq =A0 r0, [r8, #L2X0_SAVE_OFFSET0]
>>>> =A0 =A0 ldrne =A0 r0, [r8, #L2X0_SAVE_OFFSET1]
>>>> =A0 =A0 cmp =A0 =A0 r0, #3
>>>> =A0 =A0 bne =A0 =A0 do_WFI
>>>
>>> It looks like you are bypassing L2 clean and invalidate for cases
>>> "1" and "2" here. =A0But I really do not understand how you get r0
>>> back here.
>>>
>> The value which is passed in R0 is also stored in scratch patch memo=
ry
>> and retrieved using L2X0_SAVE_OFFSET0.
>> Simple :)
>
> Sounds like some in-code documentation needs to be added to make this=
 a
> bit more understandable.
>
Will add a comment
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
