From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-OPP][PATCH 0/4] OMAP: Clean up series for generic opp layer.
Date: Wed, 14 Jul 2010 06:09:50 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323A2BD71@dbde02.ent.ti.com>
References: <1279000026-24042-1-git-send-email-thara@ti.com>
 <4C3C8BE8.30108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57258 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab0GNAkB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jul 2010 20:40:01 -0400
In-Reply-To: <4C3C8BE8.30108@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Tuesday, July 13, 2010 9:23 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com; paul@pwsan.com; tony@atomide.com;
>>Cousson, Benoit; Sawant, Anand; Sripathy, Vishwanath; Premi, Sanjeev
>>Subject: Re: [PM-OPP][PATCH 0/4] OMAP: Clean up series for generic opp layer.
>>
>>Thara Gopinath had written, on 07/13/2010 12:47 AM, the following:
>>> This patch series does some clean up of the opp layer
>>> including removal of compilation warnings, avoiding wrong inclusioin
>>> of header files, correcting some srror checks and removing the dependency
>>> of opp layer on cpu freq layer.
>>>
>>> Apart from all these there is still one more concern i have in this generic
>>> opp layer. This is regarding the separate PMIC opp file opp_twl_tps.c which
>>> today caters to only twl4030 and twl5030 pmic. What is the approach to be
>>> taken if the PMIC changes? I am already facing this issue with OMAP4 where
>>> the PMIC is twl6030 and the formulas for converting vsel into voltage and
>>> vice versa are different. I am against adding another file for twl6030. The
>>> approach is not scalable. We need to keep these vsel to uV and vice versa
>>> convertion in one place or make them functions pointers.
>>why is opp_twl_tps.c unable to decide the vsel conversion routines based
>>on twl version? it seems to me (only watching l-o - not dug inside
>>twl6030 datamanual), that rest of 6030 code seem to share 5030 codebase
>>mostly..
>>
>>on a side note - this is a bigger problem for voltage.c which seem to
>>have some ingrained idea that each step is 12.5mV and delays are coded
>>in.. but not related to opp layer at all.
Nope voltage.c ideally uses the opp_tpl_twl layer to get the vsel to uV and uV to vsel conversion. I think today there a couple of places where it does a manual calculation but that will be removed in the next version.
All the delays are #defines and can be changed whenever needed. Also I am no sure if u saw the latest implementation where I have a hook to get the step size and slew rate from the PMIC.

Regards
Thara

>>
>>>
>>> Thara Gopinath (4):
>>>   OMAP: Fix the compilation warning in the opp layer
>>>   OMAP: Correct the return value check after call into find_device_opp
>>>   OMAP: Remove inclusion of PMIC specific header file in generic opp
>>>     layer.
>>>   OMAP: Remove dependency of generic opp layer on cpufreq.
>>
>>This specific series once the minor comment provided is looking good to me.
>>
>>>
>>>  arch/arm/plat-omap/Makefile           |    4 ++--
>>>  arch/arm/plat-omap/include/plat/opp.h |    4 ++--
>>>  arch/arm/plat-omap/opp.c              |    7 +++----
>>>  3 files changed, 7 insertions(+), 8 deletions(-)
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>--
>>Regards,
>>Nishanth Menon
