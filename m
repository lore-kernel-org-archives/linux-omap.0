From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: Re: [PATCH] [RFC] OMAP4: clock: shrink clock data utilizing preprocessor.
Date: Fri, 13 May 2011 19:48:51 +0300
Message-ID: <BANLkTin+G305L5XBbp2vFd_gY02S=9sPXA@mail.gmail.com>
References: <1305247077-15927-1-git-send-email-vzapolskiy@gmail.com>
	<20110513113013.GP31483@atomide.com>
	<BANLkTinNVbViwjAcrOqfR+-ZJ+i1DF9Hdw@mail.gmail.com>
	<4DCD2260.4090806@ti.com>
	<20110513130441.GH5323@atomide.com>
	<87aaeq3fmt.fsf@ti.com>
	<4DCD3F02.50104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60340 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759568Ab1EMQsw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 12:48:52 -0400
Received: by qwk3 with SMTP id 3so1381261qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 09:48:51 -0700 (PDT)
In-Reply-To: <4DCD3F02.50104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, May 13, 2011 at 5:24 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 5/13/2011 3:16 PM, Hilman, Kevin wrote:
>>
>> Tony Lindgren<tony@atomide.com> =C2=A0writes:
>>
>>> * Cousson, Benoit<b-cousson@ti.com> =C2=A0[110513 15:18]:
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Zapolskiy<vzapolskiy@gmail.com>
>>>>>>
>>>>> Unfortunately I don't have an automated tool, but that would be g=
reat
>>>>> to have such a script. For this time I've checked the correctness=
 of
>>>>> the
>>>>> change comparing the preprocessed output.
>>>>
>>>> In fact these files are already generated automatically, as writte=
n
>>>> in the header file. So changing the output format should
>>>> straightforward. At least for OMAP4... OMAP2 and OMAP3 were done
>>>> manually some time ago.
>>>
>>> Sounds like the important thing to consider here is how these macro=
s
>>> should be set up considering the upcoming generic clock framework
>>> and device tree changes.
>>>
>>> So let's wait a few days for comments from Benoit and Paul on the
>>> format for the macros so we don't need to redo them again later.
>>> Of course there might be other things to consider too..
>>
>> ... like readability.
>>
>> After seeing the patch (thanks Benoit), I think this is bad tradeoff
>> between readability and lines-of-code.
>>
>> Personally, I don't think we should be trading readability for diffs=
tat
>> goodness. =C2=A0I have a strong dislike for these multi-line macros,=
 but
>> it's up to Paul/Benoit to decide how this should look.
>
> I'm sharing the same concern and after seeing the patch, I do thing a=
s well
> that the readability is badly impacted.
There always shall be a price, from my side I've tried to lessen it as =
much as
possible.

> My other concern is that these macros are too low level and does not =
bring a
> real abstraction of clock nodes.
> Any change to the clock structure we will have to do in the near futu=
re with
> the common clock fmwk will probably have an impact on this file.
Right, but without this change the impact won't be less. In the best ca=
se later
for structural changes it might be simpler and less error-prone to modi=
fy one
macro definition instead of hundreds LOCs.

>
> So if we want to reduce the file size using that kind of approach, we=
'd
> better provide improved macros that will help hiding some implementat=
ion
> details. It will ease the transition to the common clock fmwk.
Certainly I'd be glad to get any recommendations about potential improv=
ement
in the change, but for that case I've found quite efficient to exploit =
C
preprocessor for potential removing thousands LOCs without a semantic l=
oss
or even change.

A word about my motivation, I'm just willing to reduce arch/arm/* overa=
ll size
to approach productive ARM/Linux development and integration again. At =
the
moment `du -sb arch/arm/* | sort -n | tail -n1` gives me mach-omap2 as =
the
best candidate to spend some free time with. And that change was such a=
n
attempt, hopefully not completely fruitless and not the last one :)

>
> Last but not least, since we do want to move this file to DT ASAP, is=
 it
> worth it?
>

With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
