From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
Date: Thu, 15 Sep 2011 17:32:00 +0530
Message-ID: <CAMQu2gy0VX5wQVJRjpjMwtNqM5h2Te4FtoFnyZfphFyP+uSXmQ@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
 <20110913203616.GG24252@atomide.com> <CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
 <20110914152116.GM24252@atomide.com> <4E70DB33.5070501@ti.com>
 <20110914170803.GN24252@atomide.com> <4E70E0CC.80300@ti.com>
 <20110914171800.GO24252@atomide.com> <4E70E2DE.2030006@ti.com> <4E71C702.40206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42461 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933385Ab1IOMCZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 08:02:25 -0400
Received: by mail-gx0-f177.google.com with SMTP id 23so2828424gxk.8
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 05:02:24 -0700 (PDT)
In-Reply-To: <4E71C702.40206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Woodruff, Richard" <r-woodruff2@ti.com>

On Thu, Sep 15, 2011 at 3:06 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Santosh,
>
> On 9/14/2011 7:22 PM, Shilimkar, Santosh wrote:
>>
>> On Wednesday 14 September 2011 10:48 PM, Tony Lindgren wrote:
>>>
>>> * Santosh<santosh.shilimkar@ti.com> =A0 [110914 09:40]:
>>>>
>>>> On Wednesday 14 September 2011 10:38 PM, Tony Lindgren wrote:
>>>>>
>>>>> * Santosh<santosh.shilimkar@ti.com> =A0 =A0[110914 09:16]:
>>>>>
>>>>> Thanks for the clarification. It seems to me the spec is most lik=
ely
>>>>> wrong as we've had the GIC working for over two years now without
>>>>> doing anything with the wakeup gen registers :)
>>>>>
>>>> It's working because CPU clockdomain are never put under HW
>>>> supervised mode and they are kept in force wakeup. Clock-domain
>>>> never idles on mainline code. PM series will put the clock-domains
>>>> under HW supervison as needed to achieve any low power states and
>>>> then all sorts of corner cases will come out.
>>>
>>> But again the wakeup gen triggers only do something when hitting
>>> idle. There should be no use for them during runtime, right?
>>>
>> You missed my point in the description. Clockdomain inactive
>> doesn't depend on idle or WFI execution. Under HW supervison
>> CPU clock domain can get into inactive when CPU is stalled and
>> waiting for a read response from slow interconnect.
>
> I'm a little bit confused by that statement...
>
> I'm wondering how the PRCM can gate the CPU/MPU clock and re-enable i=
t if
> the MPU is gated? What kind of event can wakeup the CPU in case of CP=
U
> stalled?
>
> The spec seems to indicate that wakeupgen is needed only if CPU are i=
n WFI.
> It is even written: "CPUx will change power state only when StandbyWF=
I is
> asserted.". Even a WFE is not supposed to trigger a standby.
> How can the CPU be inactive at clock domain level without a WFI?
>
I mean only CPU clock domain and not the power domain inactive
and local CPU clock can be gated without WFI when clock domain
is kept under hardware supervision.

But I agree with you that, for the stalled case, wakeupgen can't
generate any event and it will LPRM state-machine which take
care of un-gating the clock for that local CPU.

I have been discussing today morning with design IP team on the
restriction in the functional specs and they said they will check and
comeback.

=46or now, I would like to go with what specs says. By next merge windo=
w,
am sure we will be clear inputs from IP team on this and if it happens
that the requirement needs to be changed and we need not do
mask/unmask in non-low power scenario, we can start looking
at other aspects as Tony suggested.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
