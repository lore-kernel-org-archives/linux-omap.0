From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 6/8] OMAP: PM CONSTRAINTS: implement the devices wake-up latency constraints
Date: Fri, 16 Sep 2011 08:56:49 -0700
Message-ID: <87k498scou.fsf@ti.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
	<1314969204-21704-7-git-send-email-j-pihet@ti.com>
	<878vpptlku.fsf@ti.com>
	<CAORVsuWH+MjOL-VYWZQt_Lxpp1=7Emw=ZXfeMCW8TofuX1u_vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:60648 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755236Ab1IPP4y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 11:56:54 -0400
Received: by mail-yw0-f53.google.com with SMTP id 2so3906494ywt.26
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 08:56:53 -0700 (PDT)
In-Reply-To: <CAORVsuWH+MjOL-VYWZQt_Lxpp1=7Emw=ZXfeMCW8TofuX1u_vw@mail.gmail.com>
	(Jean Pihet's message of "Fri, 16 Sep 2011 17:43:10 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Kevin,
>
> On Fri, Sep 16, 2011 at 1:47 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
>>> Implement the devices wake-up latency constraints using the global
>>> device PM QoS notification handler which applies the constraints to=
 the
>>> underlying layer by calling the corresponding function at hwmod lev=
el.
>>>
>>> Note: the bus throughput function is implemented but currently is
>>> a no-op. A new PM QoS class for the bus throughput needs to be
>>> added.
>>>
>>> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using w=
ake-up
>>> latency constraints on MPU, CORE and PER.
>>>
>>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>
>> This patch does 2 things.
>>
>> 1) removes the MPU lat stuff from the OMAP PM layer (since it's now
>> =C2=A0 available in a generic form
>> 2) implements device wake-up latency constraints
>>
>> This should be broken up into two parts.
>>
>> Also, this patch seems to remove a bunch of stuff that was just adde=
d in
>> patch 2/8. =C2=A0Probably best to create the new OMAP PM layer after=
 remving
>> the unused stuff.
>>
>> It think the code using the new per-device PM QoS API should also li=
ve
>> outside the OMAP PM layer, since it's not related, and we want to ge=
t
>> rid of the OMAP PM layer eventually.
>>
>> Speaking of which..., the more I think about it, the more I think we
>> should take this opportunity to clean and/or remove the OMAP PM laye=
r
>> completely.
>
>
> I agree completely, the OMAP PM 'plugin' layer is useless and anyway
> an empty implementation for now.

Great, let's wait for Paul's view on this since he's the maintainer of
the OMAP PM layer.

>> With your work, other than the no-op bus throughput API, it's basica=
lly
>> unused. =C2=A0I think that rather than creating a new OMAP PM layer =
just to
>> have a a no-op bus throughput function here, I think it's time
>> to remove OMAP PM completely.
>
> Ok. The only useful code is to register a PM QoS notifier in order to
> apply the constraints to the power domains.
> Are you suggesting to move this code to e.g. pmxxx.c?

Yes, or simply pm-constraints.c since I guess it should be
SoC-independent.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
