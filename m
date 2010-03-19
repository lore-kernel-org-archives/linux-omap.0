From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 1/4] omap3: pm: cpufreq: BUG_ON cleanup
Date: Fri, 19 Mar 2010 16:53:57 -0500
Message-ID: <4BA3F275.3010101@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>	<1268937891-19445-2-git-send-email-nm@ti.com>	<87tysdi6tq.fsf@deeprootsystems.com> <4BA3886E.9070906@ti.com>	<871vfgxkz5.fsf@deeprootsystems.com> <20100319175213.GC3836@gandalf>	<87iq8sw3uf.fsf@deeprootsystems.com> <4BA3D6F8.4000709@ti.com> <87pr30ujdv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37404 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863Ab0CSVyJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 17:54:09 -0400
In-Reply-To: <87pr30ujdv.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Kevin Hilman had written, on 03/19/2010 03:49 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Kevin Hilman had written, on 03/19/2010 01:42 PM, the following:
>>> Felipe Balbi <me@felipebalbi.com> writes:
>>>
>>>> On Fri, Mar 19, 2010 at 10:46:54AM -0700, Kevin Hilman wrote:
>>>>> IMO, Using BUG* macros usually indicates improper or incomplete error
>>>>> handling rather than a real catastrophic system failure.
>>>> on the other hand a kernel oops and system hang will always get
>>>> noted. Rather than a WARN() which simply sits in the log buffer.
>>> Of course, but what I'm trying to avoid is making other people deal
>>> with a BUG inserted by a developer when proper error checking and
>>> recovery is what is really needed.
>>>
>> I respect your views. but a few moments of thoughts:
>> how would the recovery look like? I can think of 2 options here.. do
>> share your views:
>>
>> Option 1:
>> if (opp_init_list(OPP_MPU, omap3_opp_def_list[0])) {
>> 	WARN("dsp OPP table registration failed");
>> 	return;
>> }
>> if (opp_init_list(OPP_L3, omap3_opp_def_list[1])) {
>> 	WARN("dsp OPP table registration failed");
>> 	return;
>> }
>> if (opp_init_list(OPP_DSP, omap3_opp_def_list[2])) {
>> 	WARN("dsp OPP table registration failed");
>> 	return;
>> }
>>
>> Option 2:
>> 	if (opp_init_list(OPP_MPU, omap3_opp_def_list[0]))
>> 		return;
>> 	if (opp_init_list(OPP_L3, omap3_opp_def_list[1]))
>> 		goto mpu_disable;
>> 	if (opp_init_list(OPP_DSP, omap3_opp_def_list[2]))
>> 		goto l3_disable;
>> 	return;
>>
>> l3_disable:
>> 	freq = 0;
>> 	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_L3, &freq)) {
>> 		opp_disable(opp);
>> 		freq++;
>> 	}
>> mpu_disable:
>> 	freq = 0;
>> 	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_MPU, &freq)) {
>> 		opp_disable(opp);
>> 		freq++;
>> 	}
>> 	WARN("Registration of OPP tables failed!!");
>> 	return;
>>
>> Option 1 is a bad idea as it leaves the system in an invalid state
>> Option 2 is the better idea as we dont have a opp_delete option(not
>> required usually).
> 
> I'm OK with either actually, as either is better than BUG_ON()
> instead of error checking.
> 
> With option 1, the system is not really in an invalid state, just and
> untested state.  What will happen is users of the OPP API will error
> codes when trying to get OPPs and they should fail gracefully as well.
except if L3/DSP reg fails, you allow MPU freqs configured by no DSP or 
L3 freq.. prefer the option 2 in that respect.. it is binary - you get 
all the configurations done right OR you dont.
> 
> Once again, this is about proper error checking, and robustness, not
> about causing a panic() when something (relatively) minor happens.
> 
>> All that code for something that will almost never happen?	
> 
> Yes.  That's what error checking is all about.
> 
> Kevin
> 
> P.S. I can't find the ref atm, but I mentioned not liking the BUG_ON
>      early in the review of the OPP layer, and it would need to be
>      cleaned up before upstream merge.
alrite alrite.. i am black and blue with the beatings ;). I am going 
with option 2 if there are no other objections.. will send out the patch 
after collating other comments.

-- 
Regards,
Nishanth Menon
