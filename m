From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 17/19] ARM: OMAP4: put cpu1 back to sleep if no wake request
Date: Mon, 21 May 2012 16:10:10 +0530
Message-ID: <CAMQu2gy0Lwga0gDhT7+iOFM6ZLPnW4Q0qo_r4=cW6L4s5fbLZw@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-18-git-send-email-t-kristo@ti.com> <87396z3axv.fsf@ti.com> <1337595695.28274.32.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46792 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757698Ab2EUKkd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 06:40:33 -0400
Received: by qcsq13 with SMTP id q13so3810194qcs.31
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 03:40:31 -0700 (PDT)
In-Reply-To: <1337595695.28274.32.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero,

On Mon, May 21, 2012 at 3:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Wed, 2012-05-16 at 17:31 -0700, Kevin Hilman wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>> > If AUX_CORE_BOOT0 does not indicate wakeup request for cpu1, put i=
t back
>> > to off.
>>
>> Why is it waking up then? =A0(I know the answer, but will forget. =A0=
The
>> changelog serves as my long-term memory.)
>
> Will add comment. (Both cpus will wake-up after device-off reset.)
>
>>
>> > This is needed during wakeup from device off to prevent cpu1
>> > from being stuck indefinitely in the wakeup loop
>>
>> Why does it get stuck?
>
> Related to the above, if the AUX_CORE_BOOT0 is not set, the code will
> wait for it indefinitely in busy loop.
>
>>
>> > and also to prevent wakeup problem on GP chips with device off mod=
e.
>>
>> What wakeup problem?
>
> This is apparently related to the GIC restore issue addressed with pa=
tch
> 3/8 of the core-ret set (workaround for the ROM bug because of CA9 r2=
pX
> gic register change), the interrupts get disabled. Maybe Santosh has
> some comments on this one.
>>
Not sure what you mean wakeup issue on GP device.

IIUC, the issue is:
Wakeup from device OFF, hardware releases the reset for both CPUs,
This is special case and applicable only for device OFF. The reason
CPU1 needs to be hold back, because the security SW is affined with
CPU0 which needs to be up and running for any of the ROM code APIs
to work. Like setting up SMP bit, AUX control etc. Without CPU0 booted,
CPU1 won't be able to execute those ROM functions and hence won't be
able to boot properly.

I think the limitation is applicable to all OMAP4 devices as well as OM=
AP5
devices.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
