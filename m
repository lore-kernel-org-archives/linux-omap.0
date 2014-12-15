From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 2/2] ARM: OMAP3: clock: fix boot breakage in legacy mode
Date: Mon, 15 Dec 2014 10:23:38 -0800
Message-ID: <7hfvcgixg5.fsf@deeprootsystems.com>
References: <1418390521-7541-1-git-send-email-t-kristo@ti.com>
	<1418390521-7541-3-git-send-email-t-kristo@ti.com>
	<7hvblgk7q0.fsf@deeprootsystems.com> <548E9417.50502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35868 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbaLOSXm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2014 13:23:42 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so12243158pdj.0
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2014 10:23:41 -0800 (PST)
In-Reply-To: <548E9417.50502@ti.com> (Tero Kristo's message of "Mon, 15 Dec
	2014 09:56:07 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Tero Kristo <t-kristo@ti.com> writes:

> On 12/12/2014 09:07 PM, Kevin Hilman wrote:
>> Hi Tero,
>>
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>>> The new usage of determine_rate and set_rate_and_parent calls for
>>> OMAP DPLLs assumes the DPLLs must have two parents defined, even
>>> if it is the same clock. Legacy clock data did not fullfill this
>>> requirement and caused a boot crash. Fixed by adding the missing
>>> parent information to the DPLL clocks.
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Fixes: 2e1a7b014f ("ARM: OMAP3+: DPLL: use determine_rate() and...")
>>> Cc: Kevin Hilman <khilman@kernel.org>
>>
>> I tested this on linux-next (next-20141210, same version where I found
>> the bug) and this doesn't fix the boot problem.
>>
>> BTW, in testing this, I noticed that the OMAP clock code is still
>> spitting out compile warnings[1].  These should cleaned up too.
>
> Did you apply both of my patches from this set?

No, I didn't.  That wasn't clear (to me) from the changelogs.

> I think the DPLL fix might be required also to get this working
> properly on OMAP3 legacy.

Yup, with both applied, it's now booting fine on omap3-beagle-xm legacy
mode.

Tested-by: Kevin Hilman <khilman@linaro.org>

And, please add:

Reported-by: Kevin Hilman <khilman@linaro.org>

(c.f. Reported-by section in Documentation/SubmittingPatches).  

Thanks,

Kevin
