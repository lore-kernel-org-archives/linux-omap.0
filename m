From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/5] omap: Implement common omap_has_feature
Date: Fri, 9 Jul 2010 11:53:39 -0500
Message-ID: <4C375413.7070608@ti.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com> <20100708093755.16352.75290.stgit@baageli.muru.com> <4C35E630.4070204@ti.com> <20100709070811.GD24913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58569 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab0GIQxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 12:53:41 -0400
In-Reply-To: <20100709070811.GD24913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren had written, on 07/09/2010 02:08 AM, the following:
> * Nishanth Menon <nm@ti.com> [100708 17:46]:
>> Tony Lindgren had written, on 07/08/2010 04:37 AM, the following:
>>> @@ -112,6 +114,12 @@ void omap_get_die_id(struct omap_die_id *odi)
>>> 	odi->id_3 = read_tap_reg(OMAP_TAP_DIE_ID_3);
>>> }
>>> +u32 omap2_has_feature(u32 feat_mask)
>>> +{
>>> +	/* REVISIT: Add necessary omap2 feature tests here */
>>> +	return ((feat_mask & omap_features) == feat_mask);
>>> +}
>>> +
>> I did consider this path initially,
>> a) Additional functional call overhead here. some of the calls to
>> has_feature() will get called through pretty active paths, we would
>> like it to be minimized to compile time optimized inline function as
>> much as possible.(no reason why this cant me a inline macro in
>> cpu.h?) -
> 
> Well it should not matter how slow this code is, it should only be
> used to initialize things during __init.
> 
> Any code doing detection after initialization is wrong.
couple of reasons why this may not make sense:
a) drivers can be modules -e.g. lets say dss driver would like to know 
if vrfb OR tiler is used -> __init wont make sense
b) has_feature could be used as part of data flow to make decision what 
is to be done.

e.g.

lets say dma chaining as a feature OR dma list as a feature, we should 
allow for usage such as the following:
int chain_dma(...)
{
	if (!omap_has_feature(OMAP_HAS_DMA_CHAINING)) {
		return -EINVAL;
	}
}

this means that we would prefer these kind of path to be high 
performance paths (data paths) - aka inline functions make more sense 
than incurring a function call overhead.

-- 
Regards,
Nishanth Menon
