From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Fri, 19 Nov 2010 16:37:03 +0100
Message-ID: <AANLkTikztB6aSir83P4odPznmvXGvq0uzYhRN2UWC1Dr@mail.gmail.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
	<1290091906-32539-2-git-send-email-j-pihet@ti.com>
	<d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
	<87tyjey6h3.fsf@deeprootsystems.com>
	<4CE55A88.6010300@ti.com>
	<20101118175215.GE9264@atomide.com>
	<AANLkTi=bhULQsXhnN9ugDm7k=2P4E7-SvXEnx06pBwmu@mail.gmail.com>
	<20101118182752.GI9264@atomide.com>
	<AANLkTi=m1MXATmUzXNxbggoUS01AbyeGZm9WMgWUqdNo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45246 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab0KSPhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 10:37:04 -0500
Received: by qyk32 with SMTP id 32so146789qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 07:37:03 -0800 (PST)
In-Reply-To: <AANLkTi=m1MXATmUzXNxbggoUS01AbyeGZm9WMgWUqdNo@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Jean Pihet-XID <j-pihet@ti.com>

HI Tony,

On Thu, Nov 18, 2010 at 7:34 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> On Thu, Nov 18, 2010 at 7:27 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Jean Pihet <jean.pihet@newoldbits.com> [101118 10:06]:
>>> On Thu, Nov 18, 2010 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>
>>> About the DPLL lock:
>>> 1) wait_sdrc_ok is only called when back from the non-OFF modes,
>>> 2) I checked that when running wait_sdrc_ok the CORE is already out of
>>> idle and the DPLL is already locked. Note: l-o code has no support for
>>> the voltages OFF and the external clocks OFF.
>>>
>>> What to conclude from 1) and 2)? In my test setup ot looks like
>>> wait_sdrc_ok is of no use, but I agree this a premature conclusion.
>>
>> Yeah we should figure out in which cases wait_sdrc_ok is needed.
>>
>> BTW, are you sure you're hitting core idle in your tests?
> Yes it is OK from the console messages and the counters values in
> /debug/pm_debug/count.
>
> Let me confirm asap with the PRCM registers dump.

Here is what I experimented:
1) added a cache flush (v7_flush_kern_cache_all) just before WFI, in all cases,
2) checked the real state entered in low power mode from the console
messages, the output of /debug/pm_debug/count and PRCM registers dump

2) is OK, which means that the RET and OFF modes are correctly hit.

Can I conclude from 1) that the wake-up code is not running from the
cache in RETention?

Thanks,
Jean

>
>>
>> Regards,
>>
>> Tony
>>
>
> Thanks,
> Jean
>
>>
>
