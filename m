From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP][PATCH] OMAP3 PM: Fix issue with opp_find_freq_floor
Date: Tue, 06 Apr 2010 11:39:45 -0700
Message-ID: <876344pgr2.fsf@deeprootsystems.com>
References: <1270576596-8761-1-git-send-email-vishwanath.bs@ti.com>
	<4BBB5DDC.3050000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49854 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104Ab0DFSjs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 14:39:48 -0400
Received: by pva18 with SMTP id 18so160318pva.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 11:39:48 -0700 (PDT)
In-Reply-To: <4BBB5DDC.3050000@ti.com> (Nishanth Menon's message of "Tue\, 6 Apr 2010 11\:14\:20 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> Sripathy, Vishwanath had written, on 04/06/2010 12:56 PM, the following:
>> opp_find_freq_floor should return the lower "enabled* OPP from a starting freq
>> from a start opp list. But current code returns next lower opp. This patch fixes
>> this issue.
>>
>> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
>> ---
>> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
>> index bb8120e..13da451
>> --- a/arch/arm/plat-omap/opp.c
>> +++ b/arch/arm/plat-omap/opp.c
>> @@ -208,7 +208,7 @@ struct omap_opp *opp_find_freq_floor(enum opp_t opp_type, unsigned long *freq)
>>   	*freq = prev_opp->rate;
>>  -	return oppl;
>> +	return prev_opp;
>>  }
>>  
> Thanks. yep. since we return *freq with the right rate, we should
> point also to the right opp.
>
> Acked-by: Nishanth Menon <nm@ti.com>

Thanks, pushed to pm-wip-opp

Kevin
