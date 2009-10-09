From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3:PM: introduce enabled flag to omap_opp
Date: Fri, 9 Oct 2009 16:25:24 -0500
Message-ID: <4ACFAA44.80901@ti.com>
References: <1255120059-10768-1-git-send-email-nm@ti.com> <A24693684029E5489D1D202277BE89444CC6CD18@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34806 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755176AbZJIV0C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Oct 2009 17:26:02 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444CC6CD18@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Premi, Sanjeev" <premi@ti.com>

Madhu, Sergio,
Aguirre Rodriguez, Sergio Alberto had written, on 10/09/2009 04:17 PM, 
the following:
>> -	{S125M, VDD1_OPP1, 0x1E},
>> +	{true, S125M, VDD1_OPP1, 0x1E, true},
> 
> The last "true" here is wrong.
> 
> Should just be:
> 	{true, S125M, VDD1_OPP1, 0x1E},
thanks.. that is thanks to my hasty patch hand edition... apologies on 
the noise. :( I will send out a v2.


Madhu,
 >> We used to enable and disable OPPs based on
 >> rate being set to 0, this has been confusing in
 >> general. So, allow specific OPPs to be now
 >> enabled/disabled by an explicit enabled flag.
 >>
 >
 > A dumb question, what is the intention of this flag?
 >

the idea was to allow a field to properly disable the OPP instead of 
reusing rate flag itself.

-- 
Regards,
Nishanth Menon
