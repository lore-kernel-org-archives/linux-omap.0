From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] AM35xx: disable checking for reserved feature bits
Date: Wed, 04 Jan 2012 17:18:29 -0800
Message-ID: <87lipn9cbe.fsf@ti.com>
References: <1320796298-7202-1-git-send-email-yanok@emcraft.com>
	<87d3d2kt83.fsf@ti.com> <20111207235825.GS31337@atomide.com>
	<87ty59gr25.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A8062B59@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:37610 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751923Ab2AEBSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 20:18:34 -0500
Received: by mail-gy0-f169.google.com with SMTP id r18so14172ghr.0
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 17:18:33 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A8062B59@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Tue, 20 Dec 2011 10:55:08 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Ilya Yanok <yanok@emcraft.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "wd@denx.de" <wd@denx.de>, "dzu@denx.de" <dzu@denx.de>, "sasha_d@emcraft.com" <sasha_d@emcraft.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Hilman, Kevin
>> Sent: Saturday, December 10, 2011 6:51 AM
>> To: Tony Lindgren
>> Cc: Ilya Yanok; linux-omap@vger.kernel.org; wd@denx.de; dzu@denx.de;
>> sasha_d@emcraft.com; Hiremath, Vaibhav
>> Subject: Re: [PATCH] AM35xx: disable checking for reserved feature bits
>> 
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> [...]
>> 
>> >> This "feature" selection mechanism is clearly not scaling to newer SoCs.
>> >> While this patch works around the problem, IMO, we need a more scalable
>> >> solution.
>> >
>> > Agreed.
>> >
> <snip>
>> >
>> > This should be coordinated with the splitting of feature detection
>> > as posted by Vaibhave in thread "[RFC PATCH] arm:omap: cleanup & split
>> > omap2/3/4_check_revision function" thread.
>> 
>> Vaibhav,
>> 
>> Feel free to take my proposed patch and develop it further and include
>> it in your rework of the SoC/feature detection.
>> 
> Kevin,
>
> I spend some time on this, and I think it is not possible to use HWMOD 
> Entries for feature check. Reason being,
>
> 	- The whole revision story is built upon howkeye and silicon rev.
>         And both remains same for different devices in same family, 
>         For example,
>           omap3430, omap3503 and omap3515 (for that matter all AM37x) all
>           will have same howkeye and silicon revision no.

I see now.

>         Also, in the kernel we have something like.
>
> # define cpu_is_omap3515()              (cpu_is_omap3430() &&           \
>                                                  (!omap3_has_iva()) &&   \
>                                                  (omap3_has_sgx()))
> # define cpu_is_omap3525()              (cpu_is_omap3430() &&           \
>                                                  (!omap3_has_sgx()) &&   \
>                                                  (omap3_has_iva()))
>
>         Which means, you can not do IP detection before check_feature
>         function.
> 	- The current omap_hwmod_xxxx_data.c uses silicon version alone
>         and only differentiate between silicon versions. We do not 
>         differentiate between different family of devices while registering
>         hwmod data.
>
> So the conclusion is, we have to stick to check_feature function.

I don't fully agree.

I still think we need to rework how we're using cpu_is_* checks.

Specifially, we need to start separating the checking for SoC family
(based on die ID) and specific IP blocks.

I spent some time on this today and just posted a series for RFC to
hopefully move in that direction.   Let me know what you think.

Kevin


