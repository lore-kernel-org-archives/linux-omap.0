From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP3: clock: fix boot breakage in legacy mode
Date: Mon, 15 Dec 2014 09:56:07 +0200
Message-ID: <548E9417.50502@ti.com>
References: <1418390521-7541-1-git-send-email-t-kristo@ti.com>	<1418390521-7541-3-git-send-email-t-kristo@ti.com> <7hvblgk7q0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52113 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaLOHzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2014 02:55:06 -0500
In-Reply-To: <7hvblgk7q0.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

On 12/12/2014 09:07 PM, Kevin Hilman wrote:
> Hi Tero,
>
> Tero Kristo <t-kristo@ti.com> writes:
>
>> The new usage of determine_rate and set_rate_and_parent calls for
>> OMAP DPLLs assumes the DPLLs must have two parents defined, even
>> if it is the same clock. Legacy clock data did not fullfill this
>> requirement and caused a boot crash. Fixed by adding the missing
>> parent information to the DPLL clocks.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Fixes: 2e1a7b014f ("ARM: OMAP3+: DPLL: use determine_rate() and...")
>> Cc: Kevin Hilman <khilman@kernel.org>
>
> I tested this on linux-next (next-20141210, same version where I found
> the bug) and this doesn't fix the boot problem.
>
> BTW, in testing this, I noticed that the OMAP clock code is still
> spitting out compile warnings[1].  These should cleaned up too.

Did you apply both of my patches from this set?

I think the DPLL fix might be required also to get this working properly 
on OMAP3 legacy.

-Tero

>
> Kevin
>
> [1]
> ../arch/arm/mach-omap2/cclock3xxx_data.c:263:2: warning: initialization from incompatible pointer type [enabled by default]
> ../arch/arm/mach-omap2/cclock3xxx_data.c:263:2: warning: (near initialization for 'dpll1_ck_ops.determine_rate') [enabled by default]
> ../arch/arm/mach-omap2/cclock3xxx_data.c:376:2: warning: initialization from incompatible pointer type [enabled by default]
> ../arch/arm/mach-omap2/cclock3xxx_data.c:376:2: warning: (near initialization for 'dpll4_ck_ops.determine_rate') [enabled by default]
>

