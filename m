From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH 3/7] AM3517: rename the i2c boardinfo to make it more
 readable
Date: Thu, 13 May 2010 14:05:05 +0800
Message-ID: <4BEB9691.7080404@windriver.com>
References: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com> <1271745212-4474-4-git-send-email-stanley.miao@windriver.com> <19F8576C6E063C45BE387C64729E7394044E13781B@dbde02.ent.ti.com> <20100511231904.GN13931@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41451 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab0EMFzE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 01:55:04 -0400
In-Reply-To: <20100511231904.GN13931@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Govindarajan, Sriramakrishnan" <srk@ti.com>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [100420 00:03]:
>   
>> <snip>
>>>
>>> There are three i2c buses on am3517, now rename these three boardinfo
>>> structure name to am3517evm_i2c1_boardinfo, am3517evm_i2c2_boardinfo,
>>> and am3517evm_i2c3_boardinfo, to make it more readable.
>>>
>>>       
>> [Hiremath, Vaibhav] Since we haven't had any objection/suggestion to follow naming convention based on i2C indexes, I think we can merge this patch.
>>
>> Acked-By: Vaibhav Hiremath <hvaibhav@ti.com>
>>     
>
> Looks like this needs to be refreshed against the current
> omap-for-linus branch to apply.
>   

OK, I will re-send it soon.

Stanley.

> Regards,
>
> Tony
>
>   

