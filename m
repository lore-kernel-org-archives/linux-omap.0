From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] arm: Fix build error with context tracking calls
Date: Wed, 25 Sep 2013 10:38:58 -0700
Message-ID: <874n986bt9.fsf@linaro.org>
References: <522CB0DE.2010102@roeck-us.net>
	<20130909105115.GL25647@n2100.arm.linux.org.uk>
	<522DB86A.8010207@roeck-us.net>
	<alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
	<20130909160348.GB18975@roeck-us.net>
	<20130909203141.GM25647@n2100.arm.linux.org.uk>
	<20130909210203.GC28416@roeck-us.net>
	<alpine.LFD.2.03.1309091714420.20709@syhkavp.arg>
	<87y574g1fi.fsf@linaro.org> <20130913170331.GA8453@somewhere>
	<20130914143213.GN25647@n2100.arm.linux.org.uk>
	<CAFTL4hzccoaUinQ37bpbqXDv-bbNkuww8FURQMwD_zEb9RqSMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63686 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab3IYRjA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Sep 2013 13:39:00 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so6397464pdi.14
        for <linux-omap@vger.kernel.org>; Wed, 25 Sep 2013 10:39:00 -0700 (PDT)
In-Reply-To: <CAFTL4hzccoaUinQ37bpbqXDv-bbNkuww8FURQMwD_zEb9RqSMA@mail.gmail.com>
	(Frederic Weisbecker's message of "Sun, 22 Sep 2013 11:59:35 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

Frederic Weisbecker <fweisbec@gmail.com> writes:

> 2013/9/14, Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> On Fri, Sep 13, 2013 at 07:03:34PM +0200, Frederic Weisbecker wrote:
>>> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
>>> index 247091b..859c8df 100644
>>> --- a/kernel/context_tracking.c
>>> +++ b/kernel/context_tracking.c
>>> @@ -51,6 +51,15 @@ void context_tracking_user_enter(void)
>>>  	unsigned long flags;
>>>
>>>  	/*
>>> +	 * Repeat the user_enter() check here because some archs may be calling
>>> +	 * this from asm and if no CPU needs context tracking, they shouldn't
>>> +	 * go further. We can remove that check here once these archs support
>>> the static key
>>> +	 * check.
>>
>> The only (minor) comment on this is that the above would fail checkpatch,
>> but that's not a good enough reason to respin it if you've already applied
>> it IMHO.
>>
>
> Ah I haven't yet pushed that patch anywhere so I can definetly fix
> that. Thanks for the review. BTW, I initially first thought this fix
> could go through your tree but if you prefer I can push it through
> Ingo to the context tracking bits.
>
> Just tell me either way.

Frederic, I suggest you queue it directly for v3.12-rc.  Thanks,

Kevin
