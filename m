From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Mon, 22 Nov 2010 17:08:30 +0100
Message-ID: <AANLkTimO_xVC-=ZaXR6J4ZoL9OJh8cEmWGohyHg_yq8Q@mail.gmail.com>
References: <1290091906-32539-2-git-send-email-j-pihet@ti.com>
	<d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
	<87tyjey6h3.fsf@deeprootsystems.com>
	<4CE55A88.6010300@ti.com>
	<20101118175215.GE9264@atomide.com>
	<AANLkTi=bhULQsXhnN9ugDm7k=2P4E7-SvXEnx06pBwmu@mail.gmail.com>
	<20101118182752.GI9264@atomide.com>
	<AANLkTi=m1MXATmUzXNxbggoUS01AbyeGZm9WMgWUqdNo@mail.gmail.com>
	<AANLkTikztB6aSir83P4odPznmvXGvq0uzYhRN2UWC1Dr@mail.gmail.com>
	<92CDD168D1E81F4F9D3839DC45903FC6A5E5A085@dlee03.ent.ti.com>
	<20101122100716.GC26003@nokia.com>
	<87bp5hz6og.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51331 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab0KVQIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 11:08:31 -0500
Received: by qyk11 with SMTP id 11so388727qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 08:08:31 -0800 (PST)
In-Reply-To: <87bp5hz6og.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, "ext Derrick, David" <dderrick@ti.com>, Tony Lindgren <tony@atomide.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Pihet-XID, Jean" <j-pihet@ti.com>

On Mon, Nov 22, 2010 at 5:03 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
>
>> On Fri, Nov 19, 2010 at 05:14:15PM +0100, ext Derrick, David wrote:
>>> >-----Original Message-----
>>> >From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
>>> >Sent: Friday, November 19, 2010 9:37 AM
>>>
>>> >On Thu, Nov 18, 2010 at 7:34 PM, Jean Pihet <jean.pihet@newoldbits.com> >wrote:
>>> >> On Thu, Nov 18, 2010 at 7:27 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> >>> * Jean Pihet <jean.pihet@newoldbits.com> [101118 10:06]:
>>> >>>> On Thu, Nov 18, 2010 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> >>>>
>>> >>>> About the DPLL lock:
>>> >>>> 1) wait_sdrc_ok is only called when back from the non-OFF modes,
>>> >>>> 2) I checked that when running wait_sdrc_ok the CORE is already out of
>>> >>>> idle and the DPLL is already locked. Note: l-o code has no support for
>>> >>>> the voltages OFF and the external clocks OFF.
>>> >>>>
>>> >>>> What to conclude from 1) and 2)? In my test setup ot looks like
>>> >>>> wait_sdrc_ok is of no use, but I agree this a premature conclusion.
>>> >>>
>>> >>> Yeah we should figure out in which cases wait_sdrc_ok is needed.
>>> >>>
>>> >>> BTW, are you sure you're hitting core idle in your tests?
>>> >> Yes it is OK from the console messages and the counters values in
>>> >> /debug/pm_debug/count.
>>> >>
>>> >> Let me confirm asap with the PRCM registers dump.
>>>
>>> >Here is what I experimented:
>>> >1) added a cache flush (v7_flush_kern_cache_all) just before WFI, in all >cases,
>>> >2) checked the real state entered in low power mode from the console
>>> >messages, the output of /debug/pm_debug/count and PRCM registers dump
>>>
>>> >2) is OK, which means that the RET and OFF modes are correctly hit.
>>>
>>> >Can I conclude from 1) that the wake-up code is not running from the
>>> >cache in RETention?
>>>
>>> [Derrick, David]
>>>
>>> To add some context to the wait_sdrc_ok function and why it was added:
>>>
>>> wait_sdrc_ok was added because the DLL takes 500 L3 clock cycles
>>> to lock. So you do not want to go back to DDR before DLL is locked. Also, we
>>> found some times DLL never locked so we introduced the DLL kick procedure to
>>> force it to lock.
>>>
>>
>> The root cause for the DLL not locking has been found though and a
>> workaround implemented. So it should work now :)
>
> Is the workaround for this reflected in Nishanth's series?
Yes the patch is '[PATCH 02/13] OMAP3: PM: Errata i581 suppport: dll
kick strategy'

>
> Kevin
>
>> That still leaves the
>> 500 L3 cycle delay though.
>>
>> Cheers,
>>
>> Peter.
>
