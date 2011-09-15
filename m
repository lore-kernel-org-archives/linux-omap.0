From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 02/25] OMAP4: Redefine mandatory barriers for OMAP to
 include interconnect barriers.
Date: Fri, 16 Sep 2011 01:30:20 +0530
Message-ID: <CAMQu2gwv5y6PY_ooBjYuM497D=QuU54yWB+i6DRdn1YuuocY6Q@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com>
 <20110913202701.GF24252@atomide.com> <4E7080F8.9020302@ti.com>
 <87obyl7mj8.fsf@ti.com> <CAMQu2gy6yVA7zWAPUsnzCtixHkjzkn6UnbapR0mpoJ+AwNMAcQ@mail.gmail.com>
 <20110915175354.GW24252@atomide.com> <CAMQu2gzfU0K0Q1Pta4vX=dNBBYQ6wNg_Kf5EeMTCV_WHTs3Y=w@mail.gmail.com>
 <20110915194330.GC2284@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:42736 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934532Ab1IOUAl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 16:00:41 -0400
Received: by mail-gy0-f175.google.com with SMTP id 8so3140611gyg.34
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 13:00:40 -0700 (PDT)
In-Reply-To: <20110915194330.GC2284@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, Richard Woodruff <r-woodruff2@ti.com>

On Fri, Sep 16, 2011 at 1:13 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [110915 10:49]:
>> On Thu, Sep 15, 2011 at 11:23 PM, Tony Lindgren <tony@atomide.com> w=
rote:
>> >
>> > Please also include the errata in the description and set it up wi=
th
>> > a Kconfig entry with something like ARM_ERRATA_XXXXXX or TI_ERRATA=
_XXXXXX.
>> >
>> Sure.
>> It's a =A0TI ERRATA.
>
> OK
>
>> > Also it would be best to apply this fix at the end of the PM serie=
s so
>> > it is easier to verify the bug and potentially remove the hack if
>> > a better fix is ever available.
>> >
>> As such order doesn't matter much because it can be removed either w=
ay
>> even if it is in the beginning of the series with KCONFIG entry.
>>
>> But I can change the order if you prefer that way.
>
> Well it seems that it's the omap4_finish_suspend in this series that
> can be used to trigger the bug, although the bug has been around for
> few years. So then instead of mentioning random hangups you can have
> a better description with something like "Patch xyz added PM idle
> support for omap4, however bug 123 causes so and so. Fix the issue
> with blah blah".
>
Sounds good .

> Also, if you have some easy way to reproduce the bug maybe mention
> that too? That would make it easy to verify if issue has been fixed.
>
There are some multimedia usecases where the bug was discovered
but on mainline obviously we don't have that support.

I will check with IP folks if any other simple test-case is possible
to reproduce the issue and If I find one, will mention that.

Thanks for the review.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
