From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 09:43:01 -0500
Message-ID: <4C922CF5.3090406@ti.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com> <1284587799-9637-2-git-send-email-khilman@deeprootsystems.com> <4C9221AF.9000804@nokia.com> <4C922347.7050509@ti.com> <4C922798.1000304@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48372 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab0IPOnY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 10:43:24 -0400
In-Reply-To: <4C922798.1000304@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <roger.quadros@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Roger Quadros had written, on 09/16/2010 09:20 AM, the following:
[...]
>>>> +/**
>>>> + * opp_get_freq() - Gets the frequency corresponding to an opp
>>>> + * @opp:       opp for which frequency has to be returned for
>>>> + *
>>>> + * Return frequency in hertz corresponding to the opp, else
>>>> + * return 0
>>>> + */
>>>> +unsigned long opp_get_freq(const struct omap_opp *opp)
>>>> +{
>>>> +       if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {
>>> ditto.
>> Yes, the intent here was for opp operational apis to function ONLY on
>> the enabled opps - this helps to pull out any bugs in the users
>> who might be unintentionally using bad params.
>>
> OK.
> 
>> do you have any usecase you can think of where we might want to use
>> these on a disabled opp?
> 
> Not really. Based on what is an OPP enabled/disabled? Is it possible for 
> an initially enabled OPP to be disabled at some point in time? What 
> triggers this disable?
> OR  does an OPP enabled at boot time remain enabled throughout the power 
> session?
At this point - enable/disable is done at init time - there is 
flexibility for board files to define their own custom OPPs (as some 
custom boards need to). they dont change once this initial definition is 
done. there are plans to do dynamic enable disable based on previous 
discussion in l-o - the framework to use opp layer in that manner is yet 
to go up yet.

-- 
Regards,
Nishanth Menon
