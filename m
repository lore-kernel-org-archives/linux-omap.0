From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] OMAP3: PM: Set/reset T2 bit for Smartreflex on TWL.
Date: Wed, 02 Feb 2011 08:03:41 +0530
Message-ID: <4D48C285.70503@ti.com>
References: <1295847446-20667-1-git-send-email-shweta.gulati@ti.com> <87wrljnzri.fsf@ti.com> <4D48C1A4.6040600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:36618 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751789Ab1BBClP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 21:41:15 -0500
Received: by vws10 with SMTP id 10so2515017vws.0
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 18:41:14 -0800 (PST)
In-Reply-To: <4D48C1A4.6040600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Nishanth Menon wrote, on 02/02/2011 07:59 AM:
> Kevin Hilman wrote, on 02/02/2011 04:11 AM:
>> Shweta Gulati<shweta.gulati@ti.com> writes:
>>
>>> From: Thara Gopinath<thara@ti.com>
>>>
>>> The smartreflex bit on twl4030 needs to be enabled by default
>>> irrespective
>>> of whether smartreflex module is enabled on the OMAP side or not.
>>> This is because without this bit enabled the voltage scaling through
>>> vp forceupdate does not function properly on OMAP3.API added
>>> 'omap3_twl_set_sr_bit' with parameter to set/clear SR bit. It is cleared
>>> for platforms where voltage is not scaled using vpforceupdate
>>> or vc_bypass Method. In those cases 'omap3_twl_set_sr_bit' is called
>>> from board file, to make sure this bit is not overwritten in
>>> 'omap3_twl_init', a flag 'twl_sr_enable'
>>> is added.
>>
>> As Sanjeev pointed out, the use of 'irrespective' above is confusing, in
>> fact the whole changelog is kind of confusing.
>>
>> The changelog states that it has to always be enabled, but then goes on
>> to describe the situation(s) where it would be disabled.
>>
>> Here's my rephrasing of how I understand the above changelog
>>
>> - enable: *always* be enabled
>> - enable: needed for VP force update
>> - disable: platforms using VP forced update or VP bypass
>>
>> -ECONFUSED
>>
>> Kevin
>
> How about this as the commit log?

my bad - I just saw that Shweta already posted a v3:
http://marc.info/?l=linux-omap&m=129612341602728&w=2

could we have the discussion there instead of beating up this old patch? ;)

-- 
Regards,
Nishanth Menon
