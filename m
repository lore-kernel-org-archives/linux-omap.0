From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store data
 per opp
Date: Fri, 19 Mar 2010 13:10:56 -0500
Message-ID: <4BA3BE30.3050701@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com> <1268937891-19445-2-git-send-email-nm@ti.com> <1268937891-19445-3-git-send-email-nm@ti.com> <1268937891-19445-4-git-send-email-nm@ti.com> <20100319144333.GU18995@nokia.com> <4BA3975E.70206@ti.com> <20100319174727.GB3836@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36786 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab0CSSLI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 14:11:08 -0400
In-Reply-To: <20100319174727.GB3836@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Felipe Balbi had written, on 03/19/2010 12:47 PM, the following:
[...]

>> now in the approach I took,
>> you could have:
>> struct sr_ntarget_type{
>> 	unsigned long nTarget;
>> 	something else if needed
>> }
>>
>> And in SR driver, the module doesnot need to care which silicon it is 
>> running on.. it just does opp_get_data(opp,"sr_ntarget") and gets the 
>> correct data for that silicon on that OPP. It is much simpler and 
>> similar to the manner implemented in many other frameworks such as clock 
>> etc..
> 
> the thing is that ideally it would simply:
> 
> opp_get_data(opp);
> 
> and that should be done so that it fits all possibilities, but if it's
> that different per-SoC, then I guess there's nothing to do.
> 
but consider this:
data type1,2,3.. may have been stored w.r.t an opp.. now the module 
who'd query it wants it's own data and does not care about anything 
else... opp_get_data(opp) alone does not help, you'd need 
opp_get_data(opp,some_identfier) :).. hence the implementation..

-- 
Regards,
Nishanth Menon
