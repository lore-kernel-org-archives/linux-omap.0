From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Wed, 28 Sep 2011 05:12:34 +0530
Message-ID: <CAC83ZvKye5k=L-gd2TzXvWrkfPmfG8pWnctYohtpuY0yDkGtjQ@mail.gmail.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<87mxdwm8pk.fsf@ti.com>
	<CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
	<4E7D99CB.7090004@ti.com>
	<CAC83ZvLfCOjKja1rZ6GB4bmn_KrcjitTJZJsa5jy01QVj2OXXw@mail.gmail.com>
	<8739fi99yq.fsf@ti.com>
	<CAC83ZvJ4qdyvGfJGXbhf8SsGOuvwuDzBFx-f8NZX1209KAVOYw@mail.gmail.com>
	<87wrcu2bvl.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39996 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750803Ab1I0Xmh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 19:42:37 -0400
Received: by mail-bw0-f43.google.com with SMTP id s6so8547654bka.2
        for <linux-omap@vger.kernel.org>; Tue, 27 Sep 2011 16:42:35 -0700 (PDT)
In-Reply-To: <87wrcu2bvl.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, charu@ti.com

On Tue, Sep 27, 2011 at 9:52 PM, Kevin Hilman <khilman@ti.com> wrote:
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>
>> On Tue, Sep 27, 2011 at 4:40 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>>>
>>> [...]
>>>
>>>> As pointed out by Kevin, debounce clock was not getting disabled.
>>>> In my testing I was somehow grepping CORE power domain instead
>>>> of PER power domain and hence missed it. The fix for the debounce
>>>> clock issue is at the end of the email.
>>>>
>>>> - Have re-based the for_3.2/gpio-cleanup branch against 3.1-rc6.
>>>> - Dropped [PATCH 26/26] gpio/omap: add dbclk aliases for all gpio =
modules
>>>> as suggested by Kevin since it's already taken care by hwmod.
>>>> - Added the debounce clock fix in the end.
>>>
>>> That debounce fix definitely makes things look better, but it's not
>>> solving the problem...
>>>
>>>> With above, PER is hitting low power state in Suspend and Idle pat=
h.
>>>>
>>>> Have pushed a branch at below URL with mentioned changes.
>>>> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
>>>> for_3.2/kevin/gpio-cleanup
>>>
>>> I tested your branch on my 3430/n900 and PER is still not hitting
>>> retention. =A0Setting all debounce values in the board file to zero=
 using
>>> the patch below[1] makes PER hit retention again.
>>>
>>> Assuming you don't have an n900 to test with, I suggest you just co=
py
>>> the GPIO keys init from board-rx51-peripherals.c (or some of it) in=
to
>>> the board file you are testing with.
>>>
>>> The problem is most likely be related to having more than one GPIO =
in a
>>> bank with debounce enabled, or more than one bank with GPIOs enable=
d and
>>> your current test is not be catching it.
>>>
>> As per commit c8c9fda506945 {OMAP: PM: disable idle on suspend for
>> GPIO and UART}, the gpio code needs to be fixed once GPIO driver is
>> run-time adapted.
>
> Great, good catch.
>
>> So I did below change as per the commit and now suspend is working
>> fine even with board files change for debounce functionality. So the
>> last series + below one line change is whats needed for suspend to
>> work. Can you please see if this does help on your board ?
>
> Yeah, with your patch, PER is hitting retention in suspend on my
> 3430/n900.
>
>> I am not finished my idle testing yet but just reporting the suspend
>> results.
>
> For me, PER is not hitting retention on idle.
I am working on this right now.

>
> Also, your repost of v7 doesn't included any of the comments I made o=
n
> it yesterday.
That's right. By the time I received the comments the series was alread=
y posted.
Anyways, I will include them along with the PER retention issue in the
Idle path.
--
Tarun
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
