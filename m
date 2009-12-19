From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 5/9] omap3: pm: sr: replace get_opp with freq_to_opp
Date: Sat, 19 Dec 2009 17:05:38 +0530
Message-ID: <4B2CBA8A.5030905@ti.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>	<1258004721-7315-2-git-send-email-nm@ti.com>	<1258004721-7315-3-git-send-email-nm@ti.com>	<1258004721-7315-4-git-send-email-nm@ti.com>	<1258004721-7315-5-git-send-email-nm@ti.com>	<1258004721-7315-6-git-send-email-nm@ti.com> <87eimrx4em.fsf@deeprootsystems.com>
Reply-To: <nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42353 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZLSLft (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 06:35:49 -0500
In-Reply-To: <87eimrx4em.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "K, Ambresh" <ambresh@ti.com>

Kevin Hilman said the following on 12/19/2009 04:42 AM:
> Nishanth Menon <nm@ti.com> writes:
>
>   
>> SmartReflex implements a get_opp to search through the opp table,
>> replace it with the accessor function as it is a duplicate of
>> freq_to_opp
>>     
>
> SmartReflex is not quite working with this version which is in
> pm-wip-opp.  My (untested) theory below...
>
> [...]
>   
Ambresh and I  just tested the very latest of the pm-wip-opp branch and 
checked. Voltage transitions and SR adjustments are happily happening on 
SDP3430 ES3.1 at the very least (verified with a scope on vdd1).

and if you look closely in the code, sr2.vdd_opp_clk->rate and 
sr1.vdd_opp_clk->rate are based on
sr1.vdd_opp_clk = clk_get(NULL, "dpll1_ck")
sr2.vdd_opp_clk = clk_get(NULL, "l3_ick");

now, if the dpll1_ck ->rate and l3_ick->rate are not exact frequencies 
as the opp tables, I think we have a clockframework bug and the code 
here is correct. we should fix the clockframework/find the rootcause 
elsewhere.

Now is the clockframework wrong? we added a patch to print the 
frequencies and checked if IS_ERR(opp) is true -> not a single call 
while using cpu_freq transitions resulted in an error value and all the 
frequencies we printed were from the OPP table

Might be good to hear your rationale for saying this result..

Regards,
Nishanth Menon
