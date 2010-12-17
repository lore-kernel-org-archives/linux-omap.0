From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP4: Pandaboard: Fixing MMC card detect gpio line
Date: Fri, 17 Dec 2010 12:06:47 -0600
Message-ID: <4D0BA6B7.3090406@ti.com>
References: <1291723986-24658-1-git-send-email-raghuveer.murthy@ti.com> <4CFFB704.3030905@ti.com> <AANLkTim_vp6VsdZtN+3ehWuDyw2TE4+x_+f0KZ3Mn6EB@mail.gmail.com> <20101217180251.GQ5941@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:44663 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755317Ab0LQSGu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 13:06:50 -0500
Received: by yxm34 with SMTP id 34so803861yxm.25
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 10:06:50 -0800 (PST)
In-Reply-To: <20101217180251.GQ5941@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Anders <x0132446@ti.com>, "Murthy, Raghuveer" <raghuveer.murthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren had written, on 12/17/2010 12:02 PM, the following:
> * Menon, Nishanth <nm@ti.com> [101217 09:50]:
>> On Wed, Dec 8, 2010 at 10:49, David Anders <x0132446@ti.com> wrote:
>>> On 12/07/2010 06:13 AM, Murthy, Raghuveer wrote:
>>>> The .gpio_cd member of omap2_hsmmc_info is not initialized. This
>>>> will default to zero. On Pandaboard this interferes with gpio line
>>>> assigned for powering TFP410 DVI chip.
>>>>
>>>> This fix was missed out in the previous commit bf56f0a6668cd, from
>>>> Nishanth Menon
>>>>
>>>> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
>>>> Signed-off-by: Raghuveer Murthy<raghuveer.murthy@ti.com>
>>>> Acked-by: Nishanth Menon<nm@ti.com>
>>>>
>>> Tested-by: David Anders <x0132446@ti.com>
>> Tony,
>> this is a regression introduced in my commit for .37-rc1. any chance
>> of this making to one of 37 rc cycles? I can re-post this patch
>> including l-a if that is the path you'd like.
> 
> Yes please, and also explain what exactly this breaks.
> 
> If it just breaks MMC card detect with some DVI chip driver that's
> not merged yet, then this would be in the "it never worked before".
The regression is card detect ends up refering to a valid GPIO -> yeah 
as a result the upcoming DVI driver is broken without this patch. given 
that commit bf56f0a6668cd was intended to fix cd, it did not do it 
cleanly - hence my claim of regression. DVI in opinion is just a symptom 
of the wiring of GPIO0 on the board.

ok with considering this a regression?

-- 
Regards,
Nishanth Menon
