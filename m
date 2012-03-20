From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] CPUIdle: Reevaluate C-states under CPU load to favor deeper C-states
Date: Tue, 20 Mar 2012 10:49:45 -0700
Message-ID: <878viv17t2.fsf@ti.com>
References: <1316475315-5905-1-git-send-email-khilman@ti.com>
	<87d3d75zo6.fsf@ti.com> <4EBA6046.2060305@linux.vnet.ibm.com>
	<37CAE120BAE10B42A790DD1418C8021D0136C7@DNCE02.ent.ti.com>
	<CAHSGOuuexpCDNoP1G1Gyge2DCep0rsPmUwrVyZFDQ1_tH+Du7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:51910 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751677Ab2CTRtr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 13:49:47 -0400
Received: by dakl33 with SMTP id l33so325201dak.31
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 10:49:46 -0700 (PDT)
In-Reply-To: <CAHSGOuuexpCDNoP1G1Gyge2DCep0rsPmUwrVyZFDQ1_tH+Du7Q@mail.gmail.com>
	(melwyn lobo's message of "Tue, 20 Mar 2012 20:19:02 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: melwyn lobo <linux.melwyn@gmail.com>
Cc: "Chalhoub, Nicole" <n-chalhoub@ti.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arjan van de Ven <arjan@infradead.org>

melwyn lobo <linux.melwyn@gmail.com> writes:

> Hey Kevin,
> I would like to try out this patch in my platform see the benefits
> that you are reporting. But there is one issue in this patch. You hav=
e
> not initialized "hrtimer_timeout" variable.
> This will always be 0 right ?.

Correct.

The generic code defaults to zero so that the default behavior with thi=
s
patch is unchanged from previous behavior.  In order to use this
feature, your platform-specific code which creates your C-states sets
the per-C-state timer values.

Kevin

> Thanks,
> -M
>
> On Wed, Nov 9, 2011 at 11:36 PM, Chalhoub, Nicole <n-chalhoub@ti.com>=
 wrote:
>> Hi Deepthi,
>>
>>>
>> Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve=
 Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920
>>
>> -----Original Message-----
>>> From: Deepthi Dharwar [mailto:deepthi@linux.vnet.ibm.com]
>>> Sent: Wednesday, November 09, 2011 12:13 PM
>>> To: Hilman, Kevin
>>> Cc: linux-kernel@vger.kernel.org; Arjan van de Ven; linux-arm-
>>> kernel@lists.infradead.org; linux-omap@vger.kernel.org; linux-
>>> pm@lists.linux-foundation.org; Chalhoub, Nicole
>>> Subject: Re: [PATCH] CPUIdle: Reevaluate C-states under CPU load to=
 favor
>>> deeper C-states
>>
>> [...]
>>> By setting timers when we enter non-deepest C-state possible, such =
that
>>> when it fires we
>>> can re-evaluate and try moving into deeper and deeper C-states enha=
ncing
>>> the
>>> power savings is a good feature to have.
>>>
>>> Looking at the current implementation, is it possible to have it as
>>> configurable option
>>> where one can enable/disable this functionality through the backhan=
d
>>> driver ?
>>
>> The timeout values of the c state timers are set in the backhand dri=
ver.
>> By setting the timeout to 0 the timers will not fire so you'll not h=
ave this functionality enabled
>>
>>> Also I am thinking, instead of having them in governor
>>> wouldnt it be a good idea to have it implemented in
>>> the backhand driver itself ?
>>> --Deepthi
>>
>>
>> In fact each C-state had its own configurable timer, so it is a para=
meter characterizing a C-state as it is for the exit_latency and target=
_residency parameters.
>> And we wanted the timer to fire only when we do not go in deep Cstat=
e due to a high load. This decision is made in the CPU idle governor. S=
o the functionality should be seen from the governor..
>>
>> Thanks and Regards
>> Nicole
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
