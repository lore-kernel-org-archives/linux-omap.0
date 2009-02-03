From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: BUG: LDP - smc911x region too small
Date: Tue, 03 Feb 2009 17:01:26 +0800
Message-ID: <498807E6.4090503@windriver.com>
References: <20090119223750.GL18301@n2100.arm.linux.org.uk> <1232433403.31748.8.camel@localhost> <20090120083121.GA11157@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620376E9B0F3@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63602 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbZBCIwL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Feb 2009 03:52:11 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620376E9B0F3@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Woodruff, Richard wrote:
>>> Here should be 0x100. Fixing this won't cause problems with smsc911x
>>> patches.
>>>       
>> Yes it will - if it gets fixed in the -rc series for the smc911x driver
>> your patches will conflict.
>>
>> There's more which needs fixing though - no platform data is being passed
>> so the smc911x driver still fails to initialise.
>>     
>
> Data sheet shows addressable range as 0x50 from base --> 0xFC.  So 0xFF should be good.
>
> I tried to send Russell data sheet but his emails is rejecting it.
>
> Regards,
> Richard W.
>
>   
It has been fixed.

http://marc.info/?l=linux-arm-kernel&m=123307584619895&w=2


Stanley.

