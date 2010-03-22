From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store data
 per opp
Date: Mon, 22 Mar 2010 13:25:05 -0500
Message-ID: <4BA7B601.1060504@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com> <1268937891-19445-2-git-send-email-nm@ti.com> <1268937891-19445-3-git-send-email-nm@ti.com> <1268937891-19445-4-git-send-email-nm@ti.com> <20100319144333.GU18995@nokia.com> <4BA3975E.70206@ti.com> <74583B8642AB8841B30447520659FCA9EBAC2C6A@dnce01.ent.ti.com> <4BA770D6.9020707@ti.com> <74583B8642AB8841B30447520659FCA9EBAC3458@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39027 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376Ab0CVSZJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Mar 2010 14:25:09 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA9EBAC3458@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Cousson, Benoit had written, on 03/22/2010 12:46 PM, the following:
>> From: Menon, Nishanth
>> Sent: Monday, March 22, 2010 2:30 PM
>>
>> Cousson, Benoit had written, on 03/21/2010 04:50 PM, the following:
>> [...]
>>>> now in the approach I took,
>>>> you could have:
>>>> struct sr_ntarget_type{
>>>>       unsigned long nTarget;
>>>>       something else if needed
>>>> }
>>> I'm still not convinced...
>>>
>>> It appears that there is still some confusion with what OPP is or should
>> be.
>>
>> Errr.. Overall, the idea is to provide an infrastructure to store
>> information per opp, OPP layer does not make policy decision - that is
>> left to the caller (a.k.a user modules).
>>
>>> The OPP layer, for my point of view was done to handle the freq ->
>> voltage association per IP. This layer should be flexible because we can
>> add or remove dynamically any OPP.
>> yes, this is the basic SOC generic definition of OPP - i agree.
>>> All the data related to SR and ABB belong to the characterized voltages
>> that belong to a certain OPP for a voltage rail. These informations are not
>> configurable at all and not related to any IP. They are well defined for a
>> particular SoC techno (65nm, 45nm) for a voltage domain.
>> exactly the reason why this patch is relevant nominal voltage and
>> frequencies per OPP is not considered dynamic. OPP layer is a data store
>> layer - it stores information in a centralized manner allowing other
>> dependent module to query, store and operate on that information.
>>
>> the dependency as you rightly pointed out is:
>> voltage -> SR,ABB information.
>>
>> but as you already know,
>> OPP = (freq,voltage)
>>
>> hence there is a indirect dependency of SR, ABB information per OPP.
> 
> Not at all, you missed the point of storing information per IP vs. information per voltage domain.
> You first translate the freq to voltage for all IPs that belong to that voltage domain. If you have 10 IPs in the same voltage domain, you will not duplicate 10 times the SR informations.
I dont think you will. if you register with opp layer 10 times different 
data, well.. you'd do it.. but anyways.. that is a minor point.

> 
>>> So they should belong to a SoC specific file, and should be hard coded
>> for a voltage domain.
>> ACK - the question is how would you do it? try to answer these questions:
>> a) where do you store SR ntarget values which is per OPP in a SOC
>> generic way?
>> b) how do you allow SR ntarget value to be queried in a SOC generic way?
> 
> By adding a voltage management API similar to the OPP management API, but dedicated to voltage domains.

I like that approach - do we have anything that does it today? nope. the 
intent of doing SR changes was to introduce these changes, but seems to 
have been missed somewhere down the pipe. shrug.

> 
>>> The point is that you should not tie SR Ntarget, ABB... to the OPP itself
>> but to the voltage. Hence the need to have other voltage -> SR, ABB table
>> in the voltage management code only.
>> err.. that is exactly how it is done.
> 
> Not really, it uses the OPP ID for the moment.
Seriously - that is not an explanation - it is a bad implementation.

> 
>>> We should not clutter the OPP layer with something that is voltage
>> related.
>> I dont see your point here. OPP layer is just providing an
>> infrastructure to store OPP related data.
> 
> This is the point... OPP layer is a freq/voltage tuple management layer not a voltage control layer. There is not necessarily a one to one mapping between OPP and voltage.
I agree from a theoretical perspective. the user of voltage management 
layer needs the opp layer to know the voltages. The question is where do 
you want to store the voltage related information?

> 
>>> The other point is that up to now, all voltage related data are a super
>> set of the previous SoC data, so you can define only one voltage_data
>> structure that work for all SoC. If the data is useless for previous
>> platform, just put 0 or a flag to disable that parameter.
>> welcome to redundant data. How do you plan to support 35xx devices which
>> do not have nTarget data? by putting 0s for those fields? you need to
>> store this data at the end of the day in some data structure, you dont
>> have a choice. the solution as I pointed in the previous mailchain is to
>> provide an SOC generic manner which ties the data corresponding to a
>> OPP(freq/voltage) to the OPP itself.
> 
> Welcome to complex data management for a couple of 32 bits data :-)
:)
> If you look at the size of the infrastructure you have to put in place, I'm not even sure that you will save one bit.
I dont claim so.. but it stores only relevant information.. lists are 
not exactly the most optimal logic, it is just the most flexible :)

> 
>> if you look at the implementation from Thara's patches today, see:
>> See:
>> https://patchwork.kernel.org/patch/86642/
>> you will endup with a code as follows:
>> arch/arm/mach-omap2/srdevice.c:
>>
>>> +/* Read EFUSE values from control registers for OMAP3430 */
>>> +static void __init omap34xx_sr_read_efuse(struct omap_smartreflex_data
>> *sr_data,
>>> +                                            int sr_id)
>>> +{
>>> +    if (sr_id == SR1) {
[...]
>>> +            sr_data->sr_nvalue[0] = omap_ctrl_readl(
>>> +                                    OMAP343X_CONTROL_FUSE_OPP1_VDD2);
>>> +    }
>>> +}
>> well.. that is what you get if you decide that ONLY the module should
>> store the data-> it will have to have the concept of OPP ID as a result!
>>
>> Sorry, I disagree with this.
> 
> That, I agree (with you). We need to get rid of the OPP ID stuff.

[...] [I am not about to repeat everything I stated in previous 
threads.. so  snipping the discussion down.]

> 
> Otherwise the primary idea to remove OPP ID is good, and the way to go.

good. So lets NAK that SR series and see how else we can implement it 
without OPP ID. I am open to any clean mechanisms you may propose 
without using OPP ID referencing :).

-- 
Regards,
Nishanth Menon
