From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PM-WIP-OPP] [PATCH] cleaner ceil function for uv to vsel conversion
Date: Tue, 12 Jan 2010 17:43:47 +0530
Message-ID: <4B4C677B.9070809@ti.com>
References: <1263189218.16324.3.camel@boson> <876378mg2a.fsf@deeprootsystems.com> <4B4C39BB.5090409@ti.com> <4B4C6629.2040100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33649 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab0ALMNy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jan 2010 07:13:54 -0500
In-Reply-To: <4B4C6629.2040100@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>> The description of the problem is "Cleaner ceil function for uv to vsel
>> conversion".
>>
>> I think this patch is simple enough for people on this list to understand the
>> optimization. I am sorry I cant be more descriptive.
>>
>>   
> here is a try:
> -----
> 
>  From patchwork Thu Dec 31 13:29:05 2009
> Content-Type: text/plain; charset="utf-8"
> MIME-Version: 1.0
> Content-Transfer-Encoding: 7bit
> Subject: [pm-wip-opp] [PATCH] opp: twl/tps: optimize uv to vsel function
> Date: Thu, 31 Dec 2009 13:29:05 -0000
> From: Dasgupta, Romit <romit@ti.com>
> X-Patchwork-Id: 70374
> 
> 
> For integer values x and y; int div x / y causes truncation. Current
> omap_twl_uv_to_vsel function implements an equivalent of ceil which
> is based on an if condition to check truncation and round up.
> We can do this in a more optimal manner without the if condition.
> The round up is handled by adding the round off factor prior to
> truncation as:
> (x + (y - 1)) / y
> 
Wow that is nice... Please send it if you can and add your Signed-off  for the work!

