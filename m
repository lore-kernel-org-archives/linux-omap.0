From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] arm: Fix build error with context tracking calls
Date: Sun, 22 Sep 2013 11:59:35 -0500
Message-ID: <CAFTL4hzccoaUinQ37bpbqXDv-bbNkuww8FURQMwD_zEb9RqSMA@mail.gmail.com>
References: <522CB0DE.2010102@roeck-us.net>
	<20130909105115.GL25647@n2100.arm.linux.org.uk>
	<522DB86A.8010207@roeck-us.net>
	<alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
	<20130909160348.GB18975@roeck-us.net>
	<20130909203141.GM25647@n2100.arm.linux.org.uk>
	<20130909210203.GC28416@roeck-us.net>
	<alpine.LFD.2.03.1309091714420.20709@syhkavp.arg>
	<87y574g1fi.fsf@linaro.org>
	<20130913170331.GA8453@somewhere>
	<20130914143213.GN25647@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:62014 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab3IVQ7g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Sep 2013 12:59:36 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so1788497lab.14
        for <linux-omap@vger.kernel.org>; Sun, 22 Sep 2013 09:59:35 -0700 (PDT)
In-Reply-To: <20130914143213.GN25647@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

2013/9/14, Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Sep 13, 2013 at 07:03:34PM +0200, Frederic Weisbecker wrote:
>> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
>> index 247091b..859c8df 100644
>> --- a/kernel/context_tracking.c
>> +++ b/kernel/context_tracking.c
>> @@ -51,6 +51,15 @@ void context_tracking_user_enter(void)
>>  	unsigned long flags;
>>
>>  	/*
>> +	 * Repeat the user_enter() check here because some archs may be calling
>> +	 * this from asm and if no CPU needs context tracking, they shouldn't
>> +	 * go further. We can remove that check here once these archs support
>> the static key
>> +	 * check.
>
> The only (minor) comment on this is that the above would fail checkpatch,
> but that's not a good enough reason to respin it if you've already applied
> it IMHO.
>

Ah I haven't yet pushed that patch anywhere so I can definetly fix
that. Thanks for the review. BTW, I initially first thought this fix
could go through your tree but if you prefer I can push it through
Ingo to the context tracking bits.

Just tell me either way.

Thanks!
