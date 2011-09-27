From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Tue, 27 Sep 2011 09:22:54 -0700
Message-ID: <87wrcu2bvl.fsf@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<87mxdwm8pk.fsf@ti.com>
	<CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
	<4E7D99CB.7090004@ti.com>
	<CAC83ZvLfCOjKja1rZ6GB4bmn_KrcjitTJZJsa5jy01QVj2OXXw@mail.gmail.com>
	<8739fi99yq.fsf@ti.com>
	<CAC83ZvJ4qdyvGfJGXbhf8SsGOuvwuDzBFx-f8NZX1209KAVOYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:60213 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751175Ab1I0QW7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 12:22:59 -0400
Received: by mail-iy0-f175.google.com with SMTP id x2so6944977iad.20
        for <linux-omap@vger.kernel.org>; Tue, 27 Sep 2011 09:22:58 -0700 (PDT)
In-Reply-To: <CAC83ZvJ4qdyvGfJGXbhf8SsGOuvwuDzBFx-f8NZX1209KAVOYw@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Tue, 27 Sep 2011 20:01:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, charu@ti.com

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Tue, Sep 27, 2011 at 4:40 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>>
>> [...]
>>
>>> As pointed out by Kevin, debounce clock was not getting disabled.
>>> In my testing I was somehow grepping CORE power domain instead
>>> of PER power domain and hence missed it. The fix for the debounce
>>> clock issue is at the end of the email.
>>>
>>> - Have re-based the for_3.2/gpio-cleanup branch against 3.1-rc6.
>>> - Dropped [PATCH 26/26] gpio/omap: add dbclk aliases for all gpio m=
odules
>>> as suggested by Kevin since it's already taken care by hwmod.
>>> - Added the debounce clock fix in the end.
>>
>> That debounce fix definitely makes things look better, but it's not
>> solving the problem...
>>
>>> With above, PER is hitting low power state in Suspend and Idle path=
=2E
>>>
>>> Have pushed a branch at below URL with mentioned changes.
>>> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
>>> for_3.2/kevin/gpio-cleanup
>>
>> I tested your branch on my 3430/n900 and PER is still not hitting
>> retention. =C2=A0Setting all debounce values in the board file to ze=
ro using
>> the patch below[1] makes PER hit retention again.
>>
>> Assuming you don't have an n900 to test with, I suggest you just cop=
y
>> the GPIO keys init from board-rx51-peripherals.c (or some of it) int=
o
>> the board file you are testing with.
>>
>> The problem is most likely be related to having more than one GPIO i=
n a
>> bank with debounce enabled, or more than one bank with GPIOs enabled=
 and
>> your current test is not be catching it.
>>
> As per commit c8c9fda506945 {OMAP: PM: disable idle on suspend for
> GPIO and UART}, the gpio code needs to be fixed once GPIO driver is
> run-time adapted. =20

Great, good catch.

> So I did below change as per the commit and now suspend is working
> fine even with board files change for debounce functionality. So the
> last series + below one line change is whats needed for suspend to
> work. Can you please see if this does help on your board ?

Yeah, with your patch, PER is hitting retention in suspend on my
3430/n900.

> I am not finished my idle testing yet but just reporting the suspend
> results.

=46or me, PER is not hitting retention on idle.

Also, your repost of v7 doesn't included any of the comments I made on
it yesterday.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
