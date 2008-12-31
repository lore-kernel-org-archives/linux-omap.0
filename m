From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] OMAP2: gptimer min_delta_ns should be rounded up
Date: Wed, 31 Dec 2008 17:22:03 +0200
Message-ID: <495B8E1B.9050302@nokia.com>
References: <> <1230570868-25078-1-git-send-email-Aaro.Koskinen@nokia.com> <13B9B4C6EF24D648824FF11BE8967162036D3BCB12@dlee02.ent.ti.com> <495A5165.1040105@nokia.com> <13B9B4C6EF24D648824FF11BE8967162036D3BCD0B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47103 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760AbYLaPWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Dec 2008 10:22:13 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036D3BCD0B@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

Woodruff, Richard wrote:
>>>         clockevent_delta2ns(3, &clockevent_gpt);
>>>
>>> min_delta_ns stops the frame work from trying to program an expiry time
>> which may not be achievable due to timer costs.
>>> A write to the timer when it has a 32KHz F-Clock can take ~3 32Khz clock
>> cycles to complete.  Hence the cost of '3' not '1'.
>>
>> I'm not sure if I see any problem. If the timer programming cost is
>> bigger than min_delta_ns, the framework should adapt to it.
> 
> By setting this value to the cost of the timer operation you allow the frame work to adapt.
> 
> If 5 users call into this api and try and set wake ups at an rate the hardware can't support,  you end up wasting time writing wake ups which can't be met.

Yes, I actually made a test case with hrtimers too see the difference 
(though I think I'm also seeing hrtimer/oneshot code still doing some 
unnecessary programming...)

Thanks for you patience, I will try to send a new patch.

A.
