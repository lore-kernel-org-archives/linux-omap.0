From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/7] OMAP2+: hwmod: remove unused voltagedomain pointer
Date: Mon, 21 Mar 2011 08:32:02 -0700
Message-ID: <87vczcfq19.fsf@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
	<1300493932-17362-2-git-send-email-khilman@ti.com>
	<4D874DC9.6020203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:37412 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751287Ab1CUPcG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 11:32:06 -0400
Received: by mail-iw0-f180.google.com with SMTP id 6so11443370iwn.25
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 08:32:05 -0700 (PDT)
In-Reply-To: <4D874DC9.6020203@ti.com> (Benoit Cousson's message of "Mon, 21
	Mar 2011 14:08:25 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsely <paul@pwsan.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Kevin,
>
> On 3/19/2011 1:18 AM, Hilman, Kevin wrote:
>> The voltage domain pointer currently in struct omap_hwmod is not used
>> and does not belong here.  Instead, voltage domains will be associated
>> with powerdomains in forthcoming patches.
>
> Technically speaking, an IP, and thus the hwmod does belong to a
> voltage domain, a power domain and a clock domain.
>
> What is maybe important to add is that since clkdm < pwrdm < voltdm,
> we can potentially avoid providing the information for the each domain
> type.
>
> At some point the hwmod will have to contain a clkdm instead of
> relying on the main_clk to get it... but that's another topic...
>
>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>> ---
>>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 -
>>   1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> index 1adea9c..a5fa7c1 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> @@ -520,7 +520,6 @@ struct omap_hwmod {
>>   	struct clk			*_clk;
>>   	struct omap_hwmod_opt_clk	*opt_clks;
>>   	char				*vdd_name;
>
> And what about vdd_name? It should probably be removed as well.
>

Yes, but it's currently used by the SR layer (currently the only user.)

Removing it required cleaning up the SR layer as well, so I decided to
leave the SR cleanups for someone else for the moment while I focus on
the voltage layer(s)

Kevin

