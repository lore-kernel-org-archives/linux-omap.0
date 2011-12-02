From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
Date: Fri, 02 Dec 2011 11:07:35 +0530
Message-ID: <4ED8641F.7060008@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com> <1321809555-13833-4-git-send-email-hvaibhav@ti.com> <878vmxump8.fsf@ti.com> <79CD15C6BA57404B839C016229A409A8047604@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:42064 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703Ab1LBFhm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 00:37:42 -0500
Received: by mail-yx0-f175.google.com with SMTP id r11so2476094yen.6
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 21:37:42 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A8047604@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Mohammed, Afzal" <afzal@ti.com>, "Patil, Rachna" <rachna@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[..]
>> First some general comments:
>>
>> At first glance, it seems like there could be much more reuse with OMAP4
>> code here.  From what I see, AM33x has only one partition compared to
>> several on OMAP4, but that doesn't mean you couldn't reuse the OMAP4
>> functions and just use a single partition.
> Kevin,
>
> Indeed it looks close to OMAP4, but it becomes difficult and ugly once you
> Start getting into implementation details, for example,
>
>   - All PRM offsets don't match, you will end up with
> cpu_is_xxx check and handle this. Applicable to all power domains.
>
> 	OMAP4430_PRM_MPU_INST           0x0300
> 	Vs
> 	AM33XX_PRM_MPU_MOD              0x0E00
>
> 	OMAP4430_PRM_WKUP_INST          0x1700
> 	Vs
> 	AM33XX_PRM_WKUP_MOD             0x0D00

The above prcm offsets being different on am33xx doesn't really
seem to be the issue since its already part of the powerdomain
struct. See how omap2 and omap3 have different offsets and still end
up using common code. You won't need any cpu_is_* checks for those.

The real problem however seems to be with the completely different
PWSTCTRL and PWSTST offsets. They seem to be so messed up that they are
not even consistent across all powerdomains in the same SoC.
The only solution I could think of to handle these was if we had
a provision to specify the offsets on a per powerdomain level by
adding them to the powerdomain struct. It could be populated only
on SoC's which have these weirdly different offsets and for the rest
it could just get initialized with fixed values for all powerdomains
at init.

Kevin/Paul/Benoit any thoughts?

>
>   - Also there are some differences in logic states of domains as well.
>
> Another important point is, we have considered AM33xx as OMAP3
> family of device (ARCH_OMAP3).
> So you may end up with number of cpu_is_xxx checks in code.
>
>>
>> IOW, it seems to me that all the pwrdm_ops could be shared with OMAP4.
>>
>>  From what I read (after an admittedly quick glance), the main thing you
>> need is a way to override the PRM offsets due to the fact that some
>> crazy person decided to make each instance different.
>>
> This was one of the major reason why I had chosen and implemented separately
> for AM33xx.
>
>
