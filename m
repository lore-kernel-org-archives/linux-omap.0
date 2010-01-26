From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: PM: VDD2 OPPs
Date: Tue, 26 Jan 2010 23:02:43 +0100
Message-ID: <74583B8642AB8841B30447520659FCA9E761EEC1@dnce01.ent.ti.com>
References: <0C997DD87CC88A4F86C897F52650B52B02807701@MOLSON.mpc-data.co.uk>
 <4B5F5378.9020800@ti.com>
 <0C997DD87CC88A4F86C897F52650B52B02807703@MOLSON.mpc-data.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51080 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab0AZWDB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 17:03:01 -0500
Content-Class: urn:content-classes:message
In-Reply-To: <0C997DD87CC88A4F86C897F52650B52B02807703@MOLSON.mpc-data.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Murray <amurray@mpc-data.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Andrew Murray
>
>Thanks for the pointer to the pm-wip-opp branch - I'm not familiar with
>the new opp layer so I'll take a look.
>
>I currently have no need to directly control the VDD2 frequency - though
>after browsing the code I was interested to find out if my understanding
>was correct or if I was missing something. I guess if there was a need
>the framework is already in place such that a kernel module could simply
>use the API.
>
>I apologise for all these questions - I've spent the past couple of
>weeks getting to grips with power management in the OMAP and wanted to
>understand the level of kernel support for the various features. Though
>I do have a final question: I understood OPP's to be pairs of voltage
>and frequency and there were only a certain number of discrete OPP steps
>for each domain, i.e. 5 for VDD1, 2/3 for VDD2. However from reading the
>TPM (and the fact that the L3 frequency differs to the white paper
>documentation) it suggests that voltage/frequency can be set to any
>value. Thus leading me to wonder why there aren't more OPP sets? Or is
>it the case that the chosen sets represent a broad range of
>power-efficient OPPs?

The OPP sets in the TRM are the one that were characterized and validated by TI. They provide you the max frequency you can achieve at a certain voltage.
As soon as the frequency is below the one defined in the OPP, you can do whatever you want.

Concerning the 41.5MHz for the core, the issue is that the voltage for that OPP is almost the same than the one at 83MHz thus providing very little gain for the power point of view. In term of energy it will even increase the consumption due to the very negative performance impact that frequency will do to the MPU and the whole system in general.

Regards,
Benoit


>I've noticed that other than using the debugfs there is no way for a
>user to configure sleep_when_idle, enable_off_mode,
>voltage_off_when_idle. Do you think it would be worthwhile to add these
>options to the KConfigs? I'd be happy to make these modifications if so.
>:)
>
>Many Thanks,
>
>Andrew Murray
>
>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

>From: Nishanth Menon [mailto:nm@ti.com]
>Sent: 26 January 2010 20:41
>To: Andrew Murray
>Cc: linux-omap@vger.kernel.org
>Subject: Re: PM: VDD2 OPPs
>
>Andrew Murray had written, on 01/26/2010 02:34 PM, the following:
>> Hello,
>>
>> With regards to the OMAP2 (or at least the 3530 EVM) -the TRM and
>> various whitepapers suggest that they are 3 OPP levels available for
>> VDD2 (L3). However, from looking at the sources (linux-omap-pm / pm
>> branch) it seems that only 2 OPP levels are supported (@166Mhz and
>> @83Mhz) and used. I also notice that these rates are different to
>those
>> in a whitepaper (166, 100 and 41.5). Is there any particular reason
>why
>on OMAP34/35xx, I believe it should be s/100/83/.
>> only 2 OPPs are used?
>to my knowledge 41.5Mhz is not known to provide any performance
>benefits. you can also see [1] and add 41.5 (pm-wip-opp is the new
>branch where we are introducing opp layer.
>
>>
>> I understand that the OPP level of VDD2 may be set by changes to the
>OPP
>> level of VDD1 (i.e. resource34xx.c:set_opp) - and modifying VDD1's OPP
>> via cpufreq seems to be the only way to adjust the VDD2 OPP from
>> user-land - is this correct?
>The old /sys/power/vdd2_[opp|lock] was deprecated out. currently the
>control is for vdd1 OPP using cpufreq and indirect dependency for VDD2,
>is there a need for direct control of VDD2 freq?
>--
>Regards,
>Nishanth Menon
>
>Ref:
>[1]
>http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=bl
>ob;f=arch/arm/mach-omap2/cpufreq34xx.c;h=07873e87ffc0fef97b4554efc3f17dc
>696cb25e3;hb=4f54a09e0ed9b2ee8e1adfe1716297792310d1c6#l46
>
>
>No virus found in this incoming message.
>Checked by AVG - www.avg.com
>Version: 8.5.432 / Virus Database: 271.1.1/2641 - Release Date: 01/25/10
>19:36:00
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

