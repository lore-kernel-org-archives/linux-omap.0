From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
Date: Thu, 30 Sep 2010 18:57:35 +0200
Message-ID: <4CA4C17F.7060106@ti.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com> <4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com> <4CA49ADE.6080202@ti.com>,<20100930150713.GG3117@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33203 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab0I3Q6J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 12:58:09 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On 9/30/2010 5:55 PM, Varadarajan, Charulatha wrote:
> Tony/ Benoit,
>
>>>
>>> I think that disabling it should be done only if the CONFIG_OMAP_WDT
>>> is not set.
>>
>> How about disabling is done always unless CONFIG_WATCHDOG_NOWAYOUT
>> is set?
>
> As given in the patch description, this patch does a disable of watchdog
> timer, during init, to avoid the system rebooting that happens due to
> enabling of watchdog timer after a reset of the module (during hwmod init).
>
> According to the default WDT registers values, the system reboot would
> happen in ~10s if watchdog is enabled with default values. Hence, after
> a WDT module reset during init, the watchdog has to be disabled within 10s
> otherwise the system will keep rebooting.
>
> Hence irrespective of CONFIG_WATCHDOG_NOWAYOUT/ CONFIG_OMAP_WDT,
> the watchdog timer needs to be disabled after a WDT reset has happened.

No, not necessarily, this is the whole point about a watchdog, you need 
just need to ping it to prove that the system is alive.

In case you didn't notice, every watchdogs are started during a cold 
reset since OMAP1610. Even Phoenix contains a watchdog that is started 
by default.
This is by construction... and this is done like that for a good reason. 
So stopping a watchdog just after the reset in a bootloader is not 
necessarily the behavior that user of a watchdog are expecting, 
otherwise it will not be started by default at boot time.

In your description, it looks like this behavior is a HW bug that we 
have to fix... It is just the way it is supposed to work.

Regards,
Benoit

>
> Later on, the watchdog timer probe would be called (if CONFIG_OMAP_WDT
> is defined) which takes care of doing the regular the watchdog timer
> settings. After this, normal operations like open, close, ioctl operations
> are supported (if CONFIG_OMAP_WDT is defined).
> Based on CONFIG_WATCHDOG_NOWAYOUT definition, disabling the watchdog
> may/may not be supported.
>
> Hence omap2_disable_wdt() introduced in this patch is not going to affect
> the watchdog operations in anyway execpt that it is fixing the reboot issue
> observed due to a watchdog timer reset. And this has to be done irrespective
> of any OMAP watchdog timer related flags.
>
> I guess, omap_wdt_disable() call during the WDT probe might be due to
> similar reasons.
>
>> That way product kernels can set CONFIG_WATCHDOG_NOWAYOUT
>> and for the rest of us we can let fsck run the standard Linux way.
>>
>> Tony

