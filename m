From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 17/19] ARM: OMAP4: put cpu1 back to sleep if no wake request
Date: Tue, 29 May 2012 13:17:09 -0700
Message-ID: <87likag2t6.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-18-git-send-email-t-kristo@ti.com>
	<87396z3axv.fsf@ti.com> <1337595695.28274.32.camel@sokoban>
	<CAMQu2gy0Lwga0gDhT7+iOFM6ZLPnW4Q0qo_r4=cW6L4s5fbLZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:40211 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755122Ab2E2URM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 16:17:12 -0400
Received: by dady13 with SMTP id y13so6726144dad.33
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 13:17:11 -0700 (PDT)
In-Reply-To: <CAMQu2gy0Lwga0gDhT7+iOFM6ZLPnW4Q0qo_r4=cW6L4s5fbLZw@mail.gmail.com>
	(Santosh Shilimkar's message of "Mon, 21 May 2012 16:10:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> Tero,
>
> On Mon, May 21, 2012 at 3:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
>> On Wed, 2012-05-16 at 17:31 -0700, Kevin Hilman wrote:
>>> Tero Kristo <t-kristo@ti.com> writes:
>>>
>>> > If AUX_CORE_BOOT0 does not indicate wakeup request for cpu1, put =
it back
>>> > to off.
>>>
>>> Why is it waking up then? =C2=A0(I know the answer, but will forget=
=2E =C2=A0The
>>> changelog serves as my long-term memory.)
>>
>> Will add comment. (Both cpus will wake-up after device-off reset.)
>>
>>>
>>> > This is needed during wakeup from device off to prevent cpu1
>>> > from being stuck indefinitely in the wakeup loop
>>>
>>> Why does it get stuck?
>>
>> Related to the above, if the AUX_CORE_BOOT0 is not set, the code wil=
l
>> wait for it indefinitely in busy loop.
>>
>>>
>>> > and also to prevent wakeup problem on GP chips with device off mo=
de.
>>>
>>> What wakeup problem?
>>
>> This is apparently related to the GIC restore issue addressed with p=
atch
>> 3/8 of the core-ret set (workaround for the ROM bug because of CA9 r=
2pX
>> gic register change), the interrupts get disabled. Maybe Santosh has
>> some comments on this one.
>>>
> Not sure what you mean wakeup issue on GP device.
>
> IIUC, the issue is:
> Wakeup from device OFF, hardware releases the reset for both CPUs,
> This is special case and applicable only for device OFF. The reason
> CPU1 needs to be hold back, because the security SW is affined with
> CPU0 which needs to be up and running for any of the ROM code APIs
> to work. Like setting up SMP bit, AUX control etc. Without CPU0 boote=
d,
> CPU1 won't be able to execute those ROM functions and hence won't be
> able to boot properly.

That's a nice description of the problem.  Please incorporate a summary
like this into the changlog to describe the problem, then describe the
solution.

Thanks,

Kevin


> I think the limitation is applicable to all OMAP4 devices as well as =
OMAP5
> devices.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
