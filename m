From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] omap:hwmod-remove prm header from prm-regbits-xxxx headers
Date: Thu, 20 May 2010 23:30:00 +0200
Message-ID: <4BF5A9D8.8050100@ti.com>
References: <1274307029-22032-1-git-send-email-h-kanigeri2@ti.com> <87bpcafqf2.fsf@deeprootsystems.com> <8F7AF80515AF0D4D93307E594F3CB40E4BD7717A@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40037 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665Ab0ETVaF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 17:30:05 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4BD7717A@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Linux Omap <linux-omap@vger.kernel.org>

On 5/20/2010 8:25 PM, Kanigeri, Hari wrote:
> Hi Kevin
>
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Thursday, May 20, 2010 12:13 PM
>> To: Kanigeri, Hari
>> Cc: Paul Walmsley; Linux Omap
>> Subject: Re: [PATCH] omap:hwmod-remove prm header from prm-regbits-xxxx
>> headers
>>
>> Hari Kanigeri<h-kanigeri2@ti.com>  writes:
>>
>>> The prm-regbits-xxxx.h header files are not dependent on prm.h
>>> header file.
>>>
>>> Signed-off-by: Hari Kanigeri<h-kanigeri2@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
>>
>> This file is not in mailine, or linux-omap master.  Please
>> state any dependencies in this part of the changelog.
>>
>
> This is based on the latest omap4_next branch on dev.omapzoom.org, so most probably didn't make it to linux omap yet.

These patches were posted recently as well, so you can refer to them, 
but then your patch might get stuck in a wip branch.

> I came to know through Benoit that this file is auto-generated using Perl script, so I guess this change can be handled in the generator script.

In fact, it is Python scripts... I hate Perl (special note for Nishanth 
M :-))
But yes, I can take care of the change, and then your patch will not 
have any dependency with the omap4 hwmod data patches and can be 
potentially accepted sooner.

Benoit

>
> Thank you,
> Best regards,
> Hari
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

