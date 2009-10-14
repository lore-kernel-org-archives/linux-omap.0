From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: Discussion: OMAP: PM: opp table handling
Date: Wed, 14 Oct 2009 19:26:51 +0200
Message-ID: <74583B8642AB8841B30447520659FCA9DDC3EB8A@dnce01.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA0D3D0D@dbde02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA9DDC3EB01@dnce01.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012A909B24@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50389 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbZJNR1f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 13:27:35 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012A909B24@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Nataraju, Kiran" <knataraju@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>, "Joshi, Rhishi" <rhishi@ti.com>, "Giles, Rick" <rgiles@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>

>-----Original Message-----
>From: Menon, Nishanth
>
>> -----Original Message-----
>> From: Cousson, Benoit
>> Sent: Wednesday, October 14, 2009 11:06 AM
>> To: Pandita, Vikram; linux-omap@vger.kernel.org
>>
>> >From: Pandita, Vikram
>> >
>> >
>> >Proposals for OPP table handling for OMAP34xx/35xx/36xx/44xx
>> >
>> >Thanks to all the community members for taking time for this discussion.
>> >This will aid upsteaming of 35xx/36xx/44xx in coming future.
>> >
>> >Attendees: Kevin Hilman, Paul, Nishant M, Santosh, Madhu, Benoit,
>> Rajendra,
>> >Benoit, Vikram
>> >
>> >Problem Statement:
>> >	OMAP34xx has certain opp requirements (3420/3430/3440)
>> >	OMAP35xx reuses the opp's from 34xx
>> >	OMAP36xx has a totally new set of opps
>> >	OMAP44xx has a totally new set of opps
>> >
>> >Solution:
>> >	Align on a common approach to take for the Opp table definitions.
>> >
>> >Define Separate Tables for each family as follows:
>> >Step 1: Go with this approach:
>> >	3420(65nm) 		: new arrays [defer for now]
>> >	3430/35xx(65nm) 	: new arrays **
>> >	3440(65nm) 		: new arrays [defer for now]
>> >	3630(45nm) 		: new arrays
>> >	Omap4(45nm)		: new arrays
>> >
>> >	* new arrays = (mpu, dsp, l3)
>> >	** Check this valid flag. Kevin can take this base on comments
>> >		http://marc.info/?l=linux-omap&m=125512448216071&w=2
>> >		between 3430/35xx, opp's can be managed with a flag and same
>> >table re-used
>> >		35xx has requirement for 720Mhz opp
>> >
>> >Step 2:
>> >Kevin suggestion:
>> >Define accessor APIs get the OPPs
>> >Check Users of accessor API
>> >	DVFS
>> >	constraints
>> >	sysfs debug
>> >	Define accessor api's eg:
>> >		index = get_opp(VDD1_OPP1);
>> >		num = get_max_opp(VDD1);
>> >		set_opp(index);
>>
>> I think we should as well change the naming and use the less confusing
>> naming we are using on OMAP3630/4430.
>> OPPs are now named using the performance delta from the nominal frequency.
>> OPP25, OPP50, OPP80, OPP100, OPP120...
>NAK for two reasons:
>a) h/w changes language of OPP definitions every other silicons -> OPP100
>is not more informative than OPP1 or OPPX for that matter - with proper
>comments, even something like
>/* OPP25 - 25% of nominal performance */
>#define VDD1_OPP_REAAAALLLY_SLOW_OPP 1
>Makes sense.

Well, this is your point of view, but having a define named OPP100 is a little bit more informative, for my point of view, than OPP3 especially when the same OPP was named OPP1 in previous ES.
Nevermind, it was just a quick and non intrusive fix to do but the next point will make it useless. 

>b) if you look at discussion - we really DON'T want to use OPP definitions
>anymore - we would like folks to use frequency for precisely that reason -
>it is frequency that matters in the system.

I agree it is even better.

FYI, and if you look at the discussion, that direction is not obvious at all... There is even a get_opp(VDD1_OPP1) in the email...
What part of the email is explaining that? Maybe I missed it.

>c) the field for OPP idx is probably redundant once we have proper APIs in
>place.

Agree.

Regards,
Benoit

>>
>> >Step 3:
>> >	Paul suggestion:
>> >	VSEL values in opp table should be in terms of voltage
>> >	Non TWL IC's need this
>> >
>> >Step4:
>> >	Paul suggestion:
>> >	VDD1 VDD2 dependencies for different chips
>> >	Inter-connect load predictor is absent on omap3 and hence VDD1-vdd2
>> >dependency
>> >	OMAP4
>> >		interconnect loading can be measured from registers
>> >		Multi-cores dependency
>> >
>> >Step 5:
>> >	Paul suggestion:
>> >	Board files adding OPPs, Modifying OPPs
>> >	Eg: Pendora passing its own opp
>>
>>
>
>
>Regards,
>Nishanth Menon

