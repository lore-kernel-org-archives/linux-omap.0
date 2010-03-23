From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store data
 per opp
Date: Tue, 23 Mar 2010 15:04:46 -0500
Message-ID: <4BA91EDE.2020900@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com> <1268937891-19445-2-git-send-email-nm@ti.com> <1268937891-19445-3-git-send-email-nm@ti.com> <1268937891-19445-4-git-send-email-nm@ti.com> <20100319144333.GU18995@nokia.com> <4BA3975E.70206@ti.com> <74583B8642AB8841B30447520659FCA9EBAC2C6A@dnce01.ent.ti.com> <4BA770D6.9020707@ti.com> <74583B8642AB8841B30447520659FCA9EBAC3458@dnce01.ent.ti.com> <4BA7B601.1060504@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB03220FC0C3@dbde02.ent.ti.com> <4BA8BB57.9030307@ti.com> <74583B8642AB8841B30447520659FCA9EBB4A053@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44919 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157Ab0CWUEt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 16:04:49 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA9EBB4A053@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

Cousson, Benoit had written, on 03/23/2010 11:12 AM, the following:
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
>> Sent: Tuesday, March 23, 2010 2:00 PM
>>
>> Gopinath, Thara had written, on 03/23/2010 12:06 AM, the following:
>>>>> [...] [I am not about to repeat everything I stated in previous
>>>>> threads.. so  snipping the discussion down.]
>>>>>
>>>>>> Otherwise the primary idea to remove OPP ID is good, and the way to go.
>>>>> good. So lets NAK that SR series and see how else we can implement it
>>>>> without OPP ID. I am open to any clean mechanisms you may propose
>>>>> without using OPP ID referencing :).
>>> Ok guys.. In the current V2 series , I have linked N targets with
>> voltage..
>>> Only it does not come from voltage layer but from smartreflex devices
>> layer.
>>> The smartreflex driver does not use opp ids at all.. Also whether you
>> call
>>> it by opp ids or by any other name, we need to know the number of
>> different
>>> voltages supported by VDD1 and VDD2 and form the table.. That is exactly
>>> what I am doing in smartreflex device layer. I am just creating a
>> table with
>>> different voltages and N target values associated with those voltages.
>>> To create this table I need to know there should be 5 voltages for VDD1
>>> and 3 voltages for VDD2 which unfortunately coincides with the number of
>>> different OPP's defined in OMAP3430 today..
>> SR patches should ideally be discussed in SR patch series context
>> anyways, since we are looking at the fundamentals of OPP:
>> 3430: VDD1: 5 voltages+frequencies, VDD2: 3 voltages and frequencies
>> 3630: VDD1: 4 voltages+frequencies, VDD2: 2 voltages and frequencies
>> are there cases where the number of discrete voltage != number of
>> supported frequencies?
> 
> If you'd like to support DPLL bypass or several frequencies for thermal management purpose it can happen. And believe me; it will happen soon, at least on OMAP4.
> 
>> Agreed that for a voltage the characteristic data is unique. but since a
>> voltage is tied to a frequency, does'nt it make sense to tie it to an
>> OPP (my initial point in the first place)?
> 
> Frequency is an IP characteristic, not a voltage one, hence the need to separate them.
> 
[..]

Sigh.. quickly becoming an SR thread, but what the heck..

Trying to brainstorm here: Can we consider an inverse relationship? As 
in: For a given voltage to a voltage rail, there exists a supported 
range of frequencies for specific IP modules? does'nt this make sense? I 
mean for a given voltage to the module, there is only so much range of 
frequencies you can do on the module that sinks that voltage?

In the case of OMAP3, then we will have a 1-1 relation ship, on OMAP4, 
you'd potentially have 1-many relationship..

If this is the representation, then storing that information will still 
make sense.

The v2 patches implement a logic as follows:
sr_device.c: arch_initcall:
	omap34xx_sr_volt_details
this currently stores voltages (essentially replicates OPP layer 
information from cpufreq34xx.c other than using OPP indices). The NAK 
for this approach is still valid from maintainence and redundancy 
perspective.

What other alternatives do we have?

Here is what I can imagine from the few mins I spend thinking about it 
(just my 2 cents):

int omap_voltage_notify(omap_device *volt_dev, struct omap_voltage_data 
*new, struct omap_voltage_data *old, enum voltage_notify_type);

enum voltage_notify_type {
	VOLTAGE_PRE
	VOLTAGE_ACTIVATE
	VOLTAGE_POST
	VOLTAGE_PAUSE
	VOLTAGE_RESUME
}
or split them up into 4/5 functions..

I will not need to store SRID or any similar stuff inside various files 
NOR will i have to replicate another OPP layer in SR/vc codebase.

volt_device will contain platform_data similar to what 
omap_smartreflex_data has today + additional register baseaddress and 
offset information. it will not contain sr_nvalue, nor sr_volt_data

struct omap_sr_volt_data will be omap_voltage_data be similar to what we 
provide today.

The caller has the responsibility of providing the correct voltage_data 
to the voltage subsystem.

So for today (resource34xx.c or pm34xx.c which ever is triggering the 
chage) the caller will provide the trigger to the voltage layer- for 
OMAP3, store the voltage_data against each OPP. For OMAP4 and elsewhere 
the data could be somewhere else (hwmod itself perhaps if it triggers 
the transitions eventually?). It seems to scale to me + all those hacks 
such as get_curr_vdd[12]_voltage() in the current voltage.c can be avoided.


-- 
Regards,
Nishanth Menon
