From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: opp layer query apis (was RE: omap3 pm: dependency between opp
 layer and cpufreq)
Date: Tue, 8 Jun 2010 09:59:28 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03232DAFDD@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>
	<4BFE9D7E.8020602@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C0132DE0A84@dlee02.ent.ti.com>
	<068A0169-7F7B-46D6-B3B6-462EEFB66026@student.utwente.nl>
	<4BFFC622.90904@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E71FE512@dbde02.ent.ti.com>
	<4BFFCB6B.50005@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E71FE537@dbde02.ent.ti.com>
	<1275065163.10319.5.camel@Nokia-N900-51-1>
	<B85A65D85D7EB246BE421B3FB0FBB59301E5828FC2@dbde02.ent.ti.com>
	<4C0338B6.6070803@gmail.com> <87sk552ddx.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB03232DA8BC@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C013305AA83@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53280 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab0FHE3i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 00:29:38 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C013305AA83@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Tuesday, June 08, 2010 9:45 AM
>>To: Gopinath, Thara; Kevin Hilman; Nishanth Menon
>>Cc: Premi, Sanjeev; Koen Kooi; linux-omap@vger.kernel.org; eduardo.valentin@nokia.com
>>Subject: opp layer query apis (was RE: omap3 pm: dependency between opp layer and cpufreq)
>>
>>> -----Original Message-----
>>> From: Gopinath, Thara
>>> Sent: Friday, June 04, 2010 3:35 PM
>>> To: Kevin Hilman; Nishanth Menon
>>> Cc: Premi, Sanjeev; Menon, Nishanth; Koen Kooi; linux-
>>
>>
>>> Slightly off the topic but considering we are discussing opp layer here, I
>>> do not find API's
>>> that take the OPP type (OPP_MPU or OPP_L3) and voltage/frequency as
>>> parameters and returns back the associated frequency/voltage. I do not
>>> want to get the opp table entry every time I do this. Any chance of
>>> introducing this in the framework? I could send a patch for the same.
>>Am curios on the usage that combination of
>>opp_find_freq_exact
>>opp_find_freq_ceil
>>opp_find_freq_floor
>>
>>and opp_get_freq, opp_get_voltage is unable to cater to? Would be interested
>>in seeing a patch for the same.

Ok here is the need. Let us suppose I know the opp type (OPP_MPU, OPP_L3 ...) etc and the frequency and I need to get the voltage. Today I have to do the following 
	struct omap_opp *opp = opp_find_freq_exact/opp_find_freq_floor/opp_find_freq_ceil(type, freq);
	u32 volt = opp_get_voltage(opp).

As a user of opp layer it would be much simpler for me to do
	opp_get_volt(type, freq, exact/ceil/floor) as  I really do not care about the opp struct at all.

Now let us suppose I have the opp type and the voltage I need to put the vdd associated with it to. Today there is no way to retrieve the frequency from the opp layer.

Again as a user of the opp layer I would like to have an API
	u32 freq = opp_get_freq(type, volt) 

Regards
Thara
>>
>>Regards,
>>Nishanth Menon
