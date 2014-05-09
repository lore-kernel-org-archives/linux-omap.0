From: Roger Quadros <rogerq@ti.com>
Subject: Re: omap4-panda-es boot issues with v3.15-rc4
Date: Fri, 9 May 2014 11:20:33 +0300
Message-ID: <536C8FD1.4050407@ti.com>
References: <536B7E44.2040303@ti.com> <7hppjos2w2.fsf@paris.lan> <CAGa+x84VB3CXDm71JWxHx1-Qk1xVNeXdwUjZnb42_wg+piOzzA@mail.gmail.com> <20140508165558.GB2198@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41157 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753951AbaEIIVC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 04:21:02 -0400
In-Reply-To: <20140508165558.GB2198@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>
Cc: "Menon, Nishanth" <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>

On 05/08/2014 07:55 PM, Tony Lindgren wrote:
> * Kevin Hilman <khilman@linaro.org> [140508 08:40]:
>> On Thu, May 8, 2014 at 8:31 AM, Kevin Hilman <khilman@linaro.org> wrote:
>>> Roger Quadros <rogerq@ti.com> writes:
>>>
>>>> Hi,
>>>>
>>>> Nishant pointed me to a booting issue with omap4-panda-es on linux-next but I'm observing
>>>> similar issues, although less frequent, with v3.15-rc4 as well.
>>>>
>>>> Configuration:
>>>>
>>>> - kernel v3.15-rc4 or linux-next (20140507)
>>>> - multi_v7_defconfig with LEDS_TRIGGER_HEARTBEAT and LEDS_GPIO enabled
>>>> - u-boot/master       173d294b94cf
>>>>
>>>> Observations:
>>>>
>>>> - Out of 10 boots a few may not succeed and hang midway without any warnings. Heartbeat LED stops.
>>>> e.g. http://www.hastebin.com/ebumojegoq.vhdl
>>>>
>>>> - Hang more noticeable on linux-next (20140507) than on v3.15-rc4
>>>
>>> I've beeen noticing the same thing for awhile with my boot tests.  For
>>> me, next-20140508 is failing most of the time now.
>>>
>>>> - Hang more noticeable with USB_EHCI_HCD enabled but hang observed even without USB_EHCI_HCD.
>>>> Maybe related to when high speed interrupts occur in the boot process.
>>>>
>>>> - On successful boots following warning is seen
>>>> [    4.010375] gic_timer_retrigger: lost localtimer interrupt
>>>>
>>>> - On successful boots heartbeat LED stops blinking after boot process and left idle. LED can remain stuck in
>>>> ON state as well. It does blink again when doing activity on console.
>>>>
>>>> Workaround:
>>>>
>>>> - Disabling CPU_IDLE or even just disabling C3 (MPU OSWR) seems to fix all the above issues.
>>>>
>>>> I don't really know what exactly is the issue but it seems to be specific to OMAP4, GIC, MPU OSWR.
>>>
>>> I can confirm that disabling CONFIG_CPU_IDLE seems to make the problem
>>> go away.  Hmm....
>>
>> Another finger pointing in the same direction: omap2plus_defconfig +
>> CONFIG_CPU_IDLE=y also fails to boot rather consistently in today's
>> -next.
> 
> Booting today's next with multi_v7_defconfig (so cpuidle enabled) on
> omap4 sdp seems to boot reliably. And it's not producing these:
> 
> gic_timer_retrigger: lost localtimer interrupt 
> 
> while panda is producing those errors like Roger mentioned.
> 
> It seems that the USB networking is the main difference between
> omap4 sdp and panda?

Is your sdp using omap4430?

To confirm 4430 vs 4460 I ran 10 tests each on omap4430 panda and omap4460 panda.

4430panda fails 2/10 times.
4460panda fails 7/10 times.

cheers,
-roger
