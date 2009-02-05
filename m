From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch updates: 3430sdp and omap3evm results
Date: Thu, 05 Feb 2009 06:34:32 -0800
Message-ID: <87eiyd6jgn.fsf@deeprootsystems.com>
References: <87fxj4ty1l.fsf@deeprootsystems.com>
	<3a2dabf50902010605n4f642d21p35d76f1eef8fa908@mail.gmail.com>
	<3a2dabf50902032134tf769d73m5fe7837e6d6c79a2@mail.gmail.com>
	<877i46ahcn.fsf@deeprootsystems.com>
	<3a2dabf50902032144i24a539a4i887b0153e81d1e9e@mail.gmail.com>
	<871vueag1z.fsf@deeprootsystems.com>
	<3a2dabf50902032224u740e0039t4f16f5aa0952d0d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:43217 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbZBEOeh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 09:34:37 -0500
Received: by qyk4 with SMTP id 4so340693qyk.13
        for <linux-omap@vger.kernel.org>; Thu, 05 Feb 2009 06:34:35 -0800 (PST)
In-Reply-To: <3a2dabf50902032224u740e0039t4f16f5aa0952d0d7@mail.gmail.com> (Ramesh Gupta Guntha's message of "Wed\, 4 Feb 2009 11\:54\:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ramesh Gupta Guntha <grgupta77@gmail.com>
Cc: linux-omap@vger.kernel.org

Ramesh Gupta Guntha <grgupta77@gmail.com> writes:

> Hi Kevin,
>
>
> On 2/4/09, Kevin Hilman <khilman@deeprootsystems.com> wrote:
>> Ramesh Gupta Guntha <grgupta77@gmail.com> writes:
>>
>> > Kevin,
>> >
>> >
>> > On 2/4/09, Kevin Hilman <khilman@deeprootsystems.com> wrote:
>> >> Ramesh Gupta Guntha <grgupta77@gmail.com> writes:
>> >>
>> >> > Hi,
>> >> >
>> >> >  I am able to resolve all other issues with this pm branch except one issue,
>> >> >
>> >> > I am not able to enable the iva2 clock once system is suspended and
>> >> > resumed, I am getting below messages.
>> >> >>
>> >> >> <3>clock: dpll2_ck failed transition to 'locked'
>> >> >> clock: dpll2_ck failed transition to 'locked'
>> >> >> <3>clock: dpll2_ck failed transition to 'locked'
>> >> >> clock: dpll2_ck failed transition to 'locked'
>> >> >
>> >> > Once after booting ( without adding bridgedriver/ installing bridgedriver)
>> >> > CM_CLKEN_PLL_IVA2 value shows as 0x37 indicates IVA2 DPLL in locked mode.
>> >> >
>> >> > once after system suspend the value is not restored I am seeing that as
>> >> >  0x11 indicates IVA2 DPLL is low power stop mode.
>> >> >
>> >> > Can any one please provide your inputs on the above error? I tried
>> >> > reconfiguring the CM_CLKEN_PLL_IVA2 to lock mode but still I am seeing
>> >> > the same messages as above while enabling iva2 clock.
>> >>
>> >> Are you suspending into retention or off-mode?
>> >
>> > I am suspending into Off mode.
>> >
>>
>> Do you see this problem when only going into retention?
>>
>> If not, sounds like we're missing some registers being saved/restored
>> across off-mode.
>
> I am seeing this issue only with OFF mode , retention works fine for me,
> yeah, looks like some registers are not restored properly across off mode.
> please let me know your inputs on this.
>

I have just updated the PM branch with a fix from Jouni to
save/restore CM_CLKSEL1_PLL_IVA2.

Can you try the latest PM branch?

Thanks,

Kevin
