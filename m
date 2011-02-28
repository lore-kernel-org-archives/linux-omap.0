From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of individual
 hwmods
Date: Mon, 28 Feb 2011 12:17:46 +0100
Message-ID: <4D6B845A.9000900@ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <4D651998.3040002@ti.com> <alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab1B1LRx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 06:17:53 -0500
In-Reply-To: <alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Gopinath, Thara" <thara@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

Salut Paul,

On 2/28/2011 3:31 AM, Paul Walmsley wrote:
> Salut Beno=C3=AEt,
>
> On Wed, 23 Feb 2011, Cousson, Benoit wrote:
>
>> On 2/23/2011 8:11 AM, Paul Walmsley wrote:
>>> This series adds the ability to late-initialize individual
>>> hwmods.  The goal here is for clockevent (and eventually
>>> clocksource) hwmods to be late-initialized individually, and
>>> right before they are needed, in the timer init code.  Then
>>> omap_hwmod_late_init(), which late-inits the rest of the hwmods,
>>> is intended to run as an initcall -- much later in the boot
>>> process.
>>>
>>> This series includes the OMAP2/3 hwmod data for the GPTIMERs that
>>> Tarun posted earlier.  This data is necessary for this new code
>>> to avoid warnings during boot.
>>>
>>> Boot-tested on N800, OMAP34xx Beagleboard and OMAP4430ES2 Panda.
>>
>> I'm testing it on 4430sdp, and I have the following warning:
>>
>> [    0.000000] omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for d=
pll_mpu_m2_ck.
>> [    0.000000] ------------[ cut here ]------------
>> [    0.000000] WARNING: at arch/arm/mach-omap2/timer-gp.c:157 omap2_=
gp_timer_init+0x80/0x190()
>> [    0.000000] timer-gp: omap_dm_timer_set_source() failed
>> [    0.000000] Modules linked in:
>> [    0.000000] [<c0062a6c>] (unwind_backtrace+0x0/0xec) from [<c0094=
22c>] (warn_slowpath_common+0x4c/0x64)
>> [    0.000000] [<c009422c>] (warn_slowpath_common+0x4c/0x64) from [<=
c00942c4>] (warn_slowpath_fmt+0x2c/0x3c)
>> [    0.000000] [<c00942c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00=
10e30>] (omap2_gp_timer_init+0x80/0x190)
>> [    0.000000] [<c0010e30>] (omap2_gp_timer_init+0x80/0x190) from [<=
c000c0dc>] (time_init+0x20/0x30)
>> [    0.000000] [<c000c0dc>] (time_init+0x20/0x30) from [<c0008cbc>] =
(start_kernel+0x1a4/0x30c)
>> [    0.000000] [<c0008cbc>] (start_kernel+0x1a4/0x30c) from [<800080=
38>] (0x80008038)
>> [    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
>> [    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
>
> This is due to commit 3b03b58dab847883e6b9a431558c7d8e43fa94c6 ("OMAP=
4:
> hwmod data: Prevent timer1 to be reset and idle during init").  Could=
 you
> please try reverting this and see if the warning disappears?

Thanks, this is indeed fixing this warning. I didn't see these two=20
patches were exclusive.

Thanks,
Benoit

>
> Tony, I guess the omap-for-linus branch will probably need to get reb=
uilt
> to drop that patch, once this series is merged...
>
> - Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
