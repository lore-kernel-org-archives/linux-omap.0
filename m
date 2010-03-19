From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 4/4] omap3: srf: remove hardcoded opp dependency
Date: Fri, 19 Mar 2010 10:36:45 -0500
Message-ID: <4BA39A0D.5070909@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com> <1268937891-19445-2-git-send-email-nm@ti.com> <1268937891-19445-3-git-send-email-nm@ti.com> <1268937891-19445-4-git-send-email-nm@ti.com> <1268937891-19445-5-git-send-email-nm@ti.com> <20100319144747.GV18995@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56776 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570Ab0CSPgv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 11:36:51 -0400
In-Reply-To: <20100319144747.GV18995@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Felipe Balbi had written, on 03/19/2010 09:47 AM, the following:
> On Thu, Mar 18, 2010 at 07:44:51PM +0100, ext Nishanth Menon wrote:
>> @@ -131,5 +133,16 @@ void __init omap3_pm_init_opp_table(void)
>> 	r |= opp_init_list(OPP_L3, omap3_opp_def_list[1]);
>> 	r |= opp_init_list(OPP_DSP, omap3_opp_def_list[2]);
>> 	BUG_ON(r);
>> +
>> +	/* First get the l3 thresh from highest l3 opp */
>> +	freq = ULONG_MAX;
>> +	opp = opp_find_freq_floor(OPP_L3, &freq);
>> +	l3_thresh = freq * 4 / 1000;
>> +	/* Now setup the L3 bandwidth restrictions for right mpu freqs */
>> +	freq = cpu_is_omap3630() ? 500000000 : 600000000;
> 
> I also don't like this. Don't you have somewhere else you could pick ?

yeah..:) I was hoping someone would comment on it. for multiple reasons 
why i dont like this, but did put it in as a seperate api call - but I 
did not like adding an API call when there is no reason to do that.

a) Essentially the opp bandwidth limit is specific to each cpu - but the 
bandwidth itself is more of a resourceframework implementation -  this 
is the cause of my dislike.
b) if someone were to do an opp_add to l3, the logic I added is crappy! 
ok, I think the code that adds l3 should also ensure to re-store new 
bandwidth data.. (but anyways opp layer's next limitation comes here -> 
lack of a callback mechanism to trigger re-computation etc..).. but that 
is another topic..

I am not entirely sure where to put this registration if not here.. in a 
module independent manner.

> 
>> +	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_MPU, &freq))) {
>> +		opp_store_data(opp, "l3thresh", (void *) l3_thresh);
>> +		freq++;
>> +	}
> 
> this is a good example of what I mean. Instead of saving l3_thresh, why 
> don't you group all those data in a structure (which could even be 
> defined per-cpu really, you already have cpufreq34xx, so you could have 
> cpufreq24xx 36xx 44xx, etc) and just store that in a void * ??
> 
exactly the reason as pointed out in my reply to your email - it is not 
flexible enough to do it as SR and similar modules would be common 
drivers for all silicon - so u'd restrict their implementation by having 
a common structure :).


-- 
Regards,
Nishanth Menon
