From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv4 4/6] ARM: OMAP3+: PRM: Enable IO wake up
Date: Tue, 06 Mar 2012 10:26:03 +0530
Message-ID: <4F5598E3.4050506@ti.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com> <1330701475-22576-5-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1203052001240.6649@utopia.booyaka.com> <4F55978C.7030407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:49041 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757943Ab2CFE4L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 23:56:11 -0500
Received: by ghrr18 with SMTP id r18so2439444ghr.0
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 20:56:09 -0800 (PST)
In-Reply-To: <4F55978C.7030407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, Mohan V <mohanv@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>, dnilesh@ti.com, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tuesday 06 March 2012 10:20 AM, Rajendra Nayak wrote:
> On Tuesday 06 March 2012 09:51 AM, Paul Walmsley wrote:
>> added Rajendra, Nilesh, Vishwa, Mohan
>>
>> Hi
>>
>> On Fri, 2 Mar 2012, Tero Kristo wrote:
>>
>>> Enable IO Wake up for OMAP3/4 as part of PRM Init. Currently this h=
as
>>> been
>>> managed in cpuidle path which is not the right place. Subsequent pa=
tch
>>> will remove IO Daisy chain handling in cpuidle path once daisy chai=
n is
>>> handled as part of hwmod mux. This patch also moves the OMAP4 IO wa=
keup
>>> enable code from the trigger function to init time setup.
>>>
>>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
>>
>> Should we keep the I/O wakeups enabled all the time?
>>
>> Seems like that could result in at least one spurious wake-up event =
--
>> and
>> thus a PRCM interrupt -- for each I/O pad that has WAKEUPENABLE set.
>> Seems like these interrupts could recur every time the I/O chain is
>> reset.
>> And that the I/O chain is now reset in every hwmod idle and enable
>> operation for an IP block that contains dynamic mux data?
>>
>> Thinking about the problem na=EFvely... maybe you all can think thro=
ugh
>> this
>> with me:
>>
>> Consider an IP block 'A' that has a signal (like the UART rx_irrx si=
gnal)
>> that's mux'ed to a pad with WAKEUPENABLE set. (Some examples of 'A' =
might
>> include a UART, a GPIO, or a McBSP.)
>>
>> Shouldn't we enable I/O wakeups (by setting EN_IO/GLOBAL_WUEN) only
>> immediately before the powerdomain containing IP block 'A' is going =
to
>> transition into RETENTION or OFF?
>
> Hi Paul,
>
> I completely agree with your observations and we knew we would have
> additional wakeups with this design. Like I mentioned in the other
> thread, we went ahead with this approach knowing we need to optimize
> with some kind of powerdomain level usecounting in the future, becaus=
e
> it didn't exist back then when we did it this way.
> But now that we already have it, maybe we can fix this and do
> it such that we completely avoid an additional wakeup interrupt.
>
>>
>> If we do that, then we can avoid needlessly resetting the I/O chain
>> when a
>> powerdomain is not going to go into a low-power state.
>>
>> I haven't measured the time it takes for the I/O chain to be reset.
>> Maybe one of you have. But that 100 microsecond timeout that was
>> specified in two of the other patches in this series has me a little
>> worried.
>
> I haven't profiled it myself but I am guessing the delay isn't much.

Having said that, I do agree with you that, however small the delay,
we end up doing needless IO trigger when the powerdomain isn't
really entering a low power state.

> The 100us comes from the fact that there is no documentation on the
> exact delay, so went around asking whats the *real worst case* delay,
> and we got an answer, 100us should be really big enough :)
>
> regards,
> Rajendra
>
>>
>>
>> - Paul
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
