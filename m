From: John Sarman <johnsarman@gmail.com>
Subject: Re: Fwd: MMC3 Overo
Date: Wed, 5 Aug 2009 12:35:28 -0400
Message-ID: <bb2708720908050935s6602d76dq2dbaa00195008132@mail.gmail.com>
References: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
	 <6ed0b2680908050132n33abc45bgd4e91690c43ba277@mail.gmail.com>
	 <bb2708720908050901lbc67b1cx5a75a7667fa36fd1@mail.gmail.com>
	 <bb2708720908050902o39c67430pbdcd12e9b835ab70@mail.gmail.com>
	 <873a866xdo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:63508 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934655AbZHEQfs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 12:35:48 -0400
Received: by yxe5 with SMTP id 5so272146yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 09:35:48 -0700 (PDT)
In-Reply-To: <873a866xdo.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, Aug 5, 2009 at 12:25 PM, Kevin
Hilman<khilman@deeprootsystems.com> wrote:
> John Sarman <johnsarman@gmail.com> writes:
>
>> ---------- Forwarded message ----------
>> From: John Sarman <johnsarman@gmail.com>
>> Date: Wed, Aug 5, 2009 at 12:01 PM
>> Subject: Re: MMC3 Overo
>> To: Grazvydas Ignotas <notasas@gmail.com>
>>
>>
>> On Wed, Aug 5, 2009 at 4:32 AM, Grazvydas Ignotas<notasas@gmail.com>=
 wrote:
>>>> <u-boot_snip>
>>>> =A0MUX_VAL(CP(ETK_CLK_ES2), =A0 =A0 =A0 (IDIS | PTU | EN =A0| M2))=
 /*MMC3_CLK*/\
>>>
>>> You must have input enable on CLK line for MMC3 or it won't work fo=
r
>>> some reason (MMC 1 and 2 doesn't need that). Without this part of t=
he
>>> host controller hardware doesn't get the clock I guess, or somethin=
g
>>> like that. You won't believe how much time we've wasted on this!
>>>
>> MUX_VAL(CP(ETK_CLK_ES2), =A0 =A0 =A0 (IEN | PTU | EN =A0| M2)) /*MMC=
3_CLK*/\
>>
>> Works Beautifully, Thank you so much. =A0I have also burnt too much
>> midnight oil on this problem.
>> So looks like Overo MMC3 works like a champ!
>
> Might I suggest a kernel patch for this rather than fixing u-boot so =
that
> all the midnight oil you've burnt does not have to be duplicated by o=
thers.
Well I dont know how to answer that.  Because the Mux architecture is
slightly on the scary side.  I personally have had success with it,
but everytime you need to add a new pin functionality you have to
update mux.h.  I finally decided to just focus on having the MUX
correct at boot up via u-boot.

I could just add the code to update the mux without using the mux archi=
tecture.

I would appreciate some opinions on this.
>
> Thanks,
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
