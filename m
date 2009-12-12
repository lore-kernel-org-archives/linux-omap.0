From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization
 delay
Date: Fri, 11 Dec 2009 22:43:54 -0600
Message-ID: <4B231F8A.2080706@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B50@dbde02.ent.ti.com> <7A436F7769CA33409C6B44B358BFFF0C012B9F49BC@dlee02.ent.ti.com> <4B223BA3.4000402@ti.com> <4B224C5B.3080808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45398 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761178AbZLLEns (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Dec 2009 23:43:48 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBC4htPZ011975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 22:43:55 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id nBC4htH6002676
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 22:43:55 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBC4htDi018768
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 22:43:55 -0600 (CST)
In-Reply-To: <4B224C5B.3080808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Menon, Nishanth had written, on 12/11/2009 07:42 AM, the following:
> Dasgupta, Romit had written, on 12/11/2009 06:31 AM, the following:
>>> Also Richard indicated that there might be a few tricky things with perf
>>> Counters with specific devices - like EMU/HS/GP devices. It might need EMU
>>> Domain for the values to pass through and there might be a yet-not-measured increase In power which could impact usage numbers and may need additional 
>>> Code to switch off the domain correctly while hitting OFF/RET..
>>>
>> Yes someone with EMU/HS could run and let us know. OTOH there won't be any
>> increase in power as it is done only once during boot time after which the
>> perfcounters are stopped.
>>
>> By the way can you run this in 3630 and help us find what is the SRAM access
>> delay? I am sure it should be lesser since it has a process improvement over 34xx.
>>
>>
> will try on SDP3630 among the boards that I have around. meanwhile, 
> would like an explanation to my previous comments also esp on the black 
> magic "6" ;) - thanks.
> 
Just realized -> clock framework changes are not in yet, anyways, with 
3630SDP (without my OPP series and on pm branch):
Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
SRAM delay: 54 

Reprogramming SDRC clock to 400000000 Hz

-- 
Regards,
Nishanth Menon
