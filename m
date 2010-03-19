From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 1/4] omap3: pm: cpufreq: BUG_ON cleanup
Date: Fri, 19 Mar 2010 14:56:40 -0500
Message-ID: <4BA3D6F8.4000709@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>	<1268937891-19445-2-git-send-email-nm@ti.com>	<87tysdi6tq.fsf@deeprootsystems.com> <4BA3886E.9070906@ti.com>	<871vfgxkz5.fsf@deeprootsystems.com> <20100319175213.GC3836@gandalf> <87iq8sw3uf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50240 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab0CST44 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 15:56:56 -0400
In-Reply-To: <87iq8sw3uf.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Kevin Hilman had written, on 03/19/2010 01:42 PM, the following:
> Felipe Balbi <me@felipebalbi.com> writes:
> 
>> On Fri, Mar 19, 2010 at 10:46:54AM -0700, Kevin Hilman wrote:
>>> IMO, Using BUG* macros usually indicates improper or incomplete error
>>> handling rather than a real catastrophic system failure.
>> on the other hand a kernel oops and system hang will always get
>> noted. Rather than a WARN() which simply sits in the log buffer.
> 
> Of course, but what I'm trying to avoid is making other people deal
> with a BUG inserted by a developer when proper error checking and
> recovery is what is really needed.
> 
I respect your views. but a few moments of thoughts:
how would the recovery look like? I can think of 2 options here.. do 
share your views:

Option 1:
if (opp_init_list(OPP_MPU, omap3_opp_def_list[0])) {
	WARN("dsp OPP table registration failed");
	return;
}
if (opp_init_list(OPP_L3, omap3_opp_def_list[1])) {
	WARN("dsp OPP table registration failed");
	return;
}
if (opp_init_list(OPP_DSP, omap3_opp_def_list[2])) {
	WARN("dsp OPP table registration failed");
	return;
}

Option 2:
	if (opp_init_list(OPP_MPU, omap3_opp_def_list[0]))
		return;
	if (opp_init_list(OPP_L3, omap3_opp_def_list[1]))
		goto mpu_disable;
	if (opp_init_list(OPP_DSP, omap3_opp_def_list[2]))
		goto l3_disable;
	return;

l3_disable:
	freq = 0;
	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_L3, &freq)) {
		opp_disable(opp);
		freq++;
	}
mpu_disable:
	freq = 0;
	while (!IS_ERR(opp = opp_find_freq_ceil(OPP_MPU, &freq)) {
		opp_disable(opp);
		freq++;
	}
	WARN("Registration of OPP tables failed!!");
	return;

Option 1 is a bad idea as it leaves the system in an invalid state
Option 2 is the better idea as we dont have a opp_delete option(not 
required usually).

All that code for something that will almost never happen?	
-- 
Regards,
Nishanth Menon
