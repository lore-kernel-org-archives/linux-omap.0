From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store data
 per opp
Date: Fri, 19 Mar 2010 09:27:12 -0500
Message-ID: <4BA389C0.10207@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com> <1268937891-19445-2-git-send-email-nm@ti.com> <1268937891-19445-3-git-send-email-nm@ti.com> <1268937891-19445-4-git-send-email-nm@ti.com> <74583B8642AB8841B30447520659FCA9EBAC2649@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32881 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984Ab0CSO1R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 10:27:17 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA9EBAC2649@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Cousson, Benoit had written, on 03/19/2010 05:14 AM, the following:
> Hi Nishanth,
> 
>> From: Menon, Nishanth
>> Sent: Thursday, March 18, 2010 7:45 PM
>>
>> Many modules seem to need some sort of flexible storage mechanism
>> which is corresponds to a specific opp. To cater to this need, we
>> provide store, restore and removal apis.
> 
> Do we really need that level of flexibility for the moment?
> The type of information that belong to an OPP are kind of static for a dedicated SoC (i.e. SR gain, Ntarget, ABB).
> Cannot a simple pointer to a static struct do the job?
> 
> That's just my two cents.
The follow on patch shows why that flexibility is needed. this is 
important IMHO from a multiple-OMAP boot perspective -> the data is 
static for *each* dedicated SOC, but the nature of the data and the type 
of information stored will vary between SOCs themselves. as an example - 
There is no need to store NTarget on OMAP2/OMAP1 platform, while OMAP4 
or beyond may have additional data to store.

This allows an unified store and retrival capability for OPP specific 
data without knowing or constraining the exact type of data stored.

consider(hypothetically) how u'd implement dependency using resource 
framework across OMAPs in a uniform way -> we'd need custom apis 
get_vdd1_threshold and get_vdd2_threshold etc.. which are pretty much 
custom api implementation

in the case of 3630 vs 3430 the nTargets are different. for 3430 ABB 
data is probably irrelevant - for that matter nTarget may or maynot be 
programmed for a specific OPP (hypothetically again)..

But in short, there is some custom SOC data tied down to a specific OPP 
- this data may or maynot be present based on SOC and OPPs - today's OPP 
layer lacks this flexibility and with it, we can better optimize the 
logic we write. hence this introduction to it.

[...]
-- 
Regards,
Nishanth Menon
