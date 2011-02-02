From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V2] OMAP3: PM: Set/reset T2 bit for Smartreflex on TWL.
Date: Wed, 02 Feb 2011 13:39:07 -0800
Message-ID: <87y65y9kw4.fsf@ti.com>
References: <1295847446-20667-1-git-send-email-shweta.gulati@ti.com>
	<87wrljnzri.fsf@ti.com> <4D48C1A4.6040600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:58149 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753534Ab1BBVjL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 16:39:11 -0500
Received: by pxi15 with SMTP id 15so85266pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Feb 2011 13:39:10 -0800 (PST)
In-Reply-To: <4D48C1A4.6040600@ti.com> (Nishanth Menon's message of "Wed, 02
	Feb 2011 07:59:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman wrote, on 02/02/2011 04:11 AM:
>> Shweta Gulati<shweta.gulati@ti.com>  writes:
>>
>>> From: Thara Gopinath<thara@ti.com>
>>>
>>> The smartreflex bit on twl4030 needs to be enabled by default irrespective
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
>
> The smartreflex bit on twl4030 specifies if the setting of voltage
> is done over the I2C_SR path. Given that there are platforms that
> do not use I2C_SR path for voltage scaling, a new function
> 'omap3_twl_set_sr_bit' with parameter to set/clear SR bit has been
> provided for flexibility. 

So far so good.

> It is called with appropriate param
> for platforms where voltage is not scaled using I2C_SR path
> from board file, to make sure this bit is not overwritten in
> 'omap3_twl_init'.

-ENOPARSE

>
>
>>
>>> This patch is based on LO PM Branch and Smartreflex has been
>>> tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
>>> OMAP2430 SDP.
>
> this belongs into the diffstat.
>
> Attached is a modified version of this patch - i'vent tested it
> though.. but basically improves the logic a little:
>
> *) made the comments more generic to ensure that this is more of
> I2C_SR path as far as TWL is concerned(yes, from OMAP perspective it
> is vp forceupdate/bypass), but it is more of an OMAP problem than
> omap_twl.c problem.
> *) modified the function call sequences to prevent rentry even if
> board file calls with various other params
> *) shifted to using bool
> *) use init and initdata to free up the space once we are done with
> init sequence

All good changes, but I don't think they're incorporated in V3.

> etc...
>
>
> Do let me know if this is good enough.

Not quite yet,

Kevin



