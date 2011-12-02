From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
Date: Fri, 02 Dec 2011 09:39:49 -0800
Message-ID: <87zkfaj2je.fsf@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<1321809555-13833-4-git-send-email-hvaibhav@ti.com>
	<878vmxump8.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A8047604@DBDE01.ent.ti.com>
	<4ED8641F.7060008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:32966 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757189Ab1LBRjw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 12:39:52 -0500
Received: by mail-gy0-f174.google.com with SMTP id r1so4247541ghr.33
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 09:39:51 -0800 (PST)
In-Reply-To: <4ED8641F.7060008@ti.com> (Rajendra Nayak's message of "Fri, 02
	Dec 2011 11:07:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Mohammed, Afzal" <afzal@ti.com>, "Patil, Rachna" <rachna@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Rajendra Nayak <rnayak@ti.com> writes:

> [..]
>>> First some general comments:
>>>
>>> At first glance, it seems like there could be much more reuse with OMAP4
>>> code here.  From what I see, AM33x has only one partition compared to
>>> several on OMAP4, but that doesn't mean you couldn't reuse the OMAP4
>>> functions and just use a single partition.
>> Kevin,
>>
>> Indeed it looks close to OMAP4, but it becomes difficult and ugly once you
>> Start getting into implementation details, for example,
>>
>>   - All PRM offsets don't match, you will end up with
>> cpu_is_xxx check and handle this. Applicable to all power domains.
>>
>> 	OMAP4430_PRM_MPU_INST           0x0300
>> 	Vs
>> 	AM33XX_PRM_MPU_MOD              0x0E00
>>
>> 	OMAP4430_PRM_WKUP_INST          0x1700
>> 	Vs
>> 	AM33XX_PRM_WKUP_MOD             0x0D00
>
> The above prcm offsets being different on am33xx doesn't really
> seem to be the issue since its already part of the powerdomain
> struct. See how omap2 and omap3 have different offsets and still end
> up using common code. You won't need any cpu_is_* checks for those.
>
> The real problem however seems to be with the completely different
> PWSTCTRL and PWSTST offsets. They seem to be so messed up that they are
> not even consistent across all powerdomains in the same SoC.
> The only solution I could think of to handle these was if we had
> a provision to specify the offsets on a per powerdomain level by
> adding them to the powerdomain struct. It could be populated only
> on SoC's which have these weirdly different offsets and for the rest
> it could just get initialized with fixed values for all powerdomains
> at init.
>
> Kevin/Paul/Benoit any thoughts?
>

Something tells me that AM33x is not the last device we're going to see
where there clearly wansn't a unified design around PRCM integration.

So I suspect adding this to the powerdomain struct is the best way to
go, but Paul/Benoit should make the final call.

Kevin
