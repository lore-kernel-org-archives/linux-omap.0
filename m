From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store data
 per opp
Date: Mon, 22 Mar 2010 08:29:58 -0500
Message-ID: <4BA770D6.9020707@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com> <1268937891-19445-2-git-send-email-nm@ti.com> <1268937891-19445-3-git-send-email-nm@ti.com> <1268937891-19445-4-git-send-email-nm@ti.com> <20100319144333.GU18995@nokia.com> <4BA3975E.70206@ti.com> <74583B8642AB8841B30447520659FCA9EBAC2C6A@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58076 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab0CVNa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 09:30:27 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA9EBAC2C6A@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Cousson, Benoit had written, on 03/21/2010 04:50 PM, the following:
[...]
>>
>> now in the approach I took,
>> you could have:
>> struct sr_ntarget_type{
>>       unsigned long nTarget;
>>       something else if needed
>> }
> 
> I'm still not convinced...
> 
> It appears that there is still some confusion with what OPP is or should be.

Errr.. Overall, the idea is to provide an infrastructure to store 
information per opp, OPP layer does not make policy decision - that is 
left to the caller (a.k.a user modules).

> 
> The OPP layer, for my point of view was done to handle the freq -> voltage association per IP. This layer should be flexible because we can add or remove dynamically any OPP.
yes, this is the basic SOC generic definition of OPP - i agree.
> 
> All the data related to SR and ABB belong to the characterized voltages that belong to a certain OPP for a voltage rail. These informations are not configurable at all and not related to any IP. They are well defined for a particular SoC techno (65nm, 45nm) for a voltage domain.
exactly the reason why this patch is relevant nominal voltage and 
frequencies per OPP is not considered dynamic. OPP layer is a data store 
layer - it stores information in a centralized manner allowing other 
dependent module to query, store and operate on that information.

the dependency as you rightly pointed out is:
voltage -> SR,ABB information.

but as you already know,
OPP = (freq,voltage)

hence there is a indirect dependency of SR, ABB information per OPP.

> So they should belong to a SoC specific file, and should be hard coded for a voltage domain.
ACK - the question is how would you do it? try to answer these questions:
a) where do you store SR ntarget values which is per OPP in a SOC 
generic way?
b) how do you allow SR ntarget value to be queried in a SOC generic way?

> The point is that you should not tie SR Ntarget, ABB... to the OPP itself but to the voltage. Hence the need to have other voltage -> SR, ABB table in the voltage management code only.
err.. that is exactly how it is done.

> We should not clutter the OPP layer with something that is voltage related.
I dont see your point here. OPP layer is just providing an 
infrastructure to store OPP related data.

> 
> The other point is that up to now, all voltage related data are a super set of the previous SoC data, so you can define only one voltage_data structure that work for all SoC. If the data is useless for previous platform, just put 0 or a flag to disable that parameter.
welcome to redundant data. How do you plan to support 35xx devices which 
do not have nTarget data? by putting 0s for those fields? you need to 
store this data at the end of the day in some data structure, you dont 
have a choice. the solution as I pointed in the previous mailchain is to 
provide an SOC generic manner which ties the data corresponding to a 
OPP(freq/voltage) to the OPP itself.

if you look at the implementation from Thara's patches today, see:
See:
https://patchwork.kernel.org/patch/86642/
you will endup with a code as follows:
arch/arm/mach-omap2/srdevice.c:

> +/* Read EFUSE values from control registers for OMAP3430 */
> +static void __init omap34xx_sr_read_efuse(struct omap_smartreflex_data *sr_data,
> +						int sr_id)
> +{
> +	if (sr_id == SR1) {
> +		sr_data->no_opp = opp_get_opp_count(OPP_MPU);
> +		sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
> +					sr_data->no_opp , GFP_KERNEL);
> +		if (WARN_ON(!sr_data->sr_nvalue))
> +			return;
> +
> +		sr_data->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> +					OMAP343X_SR1_SENNENABLE_MASK) >>
> +					OMAP343X_SR1_SENNENABLE_SHIFT;
> +		sr_data->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> +					OMAP343X_SR1_SENPENABLE_MASK) >>
> +					OMAP343X_SR1_SENPENABLE_SHIFT;
> +		sr_data->sr_nvalue[4] = omap_ctrl_readl(
> +					OMAP343X_CONTROL_FUSE_OPP5_VDD1);
> +		sr_data->sr_nvalue[3] = omap_ctrl_readl(
> +					OMAP343X_CONTROL_FUSE_OPP4_VDD1);
> +		sr_data->sr_nvalue[2] = omap_ctrl_readl(
> +					OMAP343X_CONTROL_FUSE_OPP3_VDD1);
> +		sr_data->sr_nvalue[1] = omap_ctrl_readl(
> +					OMAP343X_CONTROL_FUSE_OPP2_VDD1);
> +		sr_data->sr_nvalue[0] = omap_ctrl_readl(
> +					OMAP343X_CONTROL_FUSE_OPP1_VDD1);
> +	} else if (sr_id == SR2) {
> +		sr_data->no_opp = 3;
> +		sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
> +					sr_data->no_opp , GFP_KERNEL);
> +		if (WARN_ON(!sr_data->sr_nvalue))
> +			return;
> +
> +		sr_data->senn_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> +					OMAP343X_SR2_SENNENABLE_MASK) >>
> +					OMAP343X_SR2_SENNENABLE_SHIFT;
> +		sr_data->senp_mod = (omap_ctrl_readl(OMAP343X_CONTROL_FUSE_SR) &
> +					OMAP343X_SR2_SENPENABLE_MASK) >>
> +					OMAP343X_SR2_SENPENABLE_SHIFT;
> +		sr_data->sr_nvalue[2] = omap_ctrl_readl(
> +					OMAP343X_CONTROL_FUSE_OPP3_VDD2);
> +		sr_data->sr_nvalue[1] = omap_ctrl_readl(
> +					OMAP343X_CONTROL_FUSE_OPP2_VDD2);
> +		sr_data->sr_nvalue[0] = omap_ctrl_readl(
> +					OMAP343X_CONTROL_FUSE_OPP1_VDD2);
> +	}
> +}
well.. that is what you get if you decide that ONLY the module should 
store the data-> it will have to have the concept of OPP ID as a result!

Sorry, I disagree with this.

> 
> 
> Regarding the link between voltage domains, there are two different types that should not be necessarily handled by the OPP layer.
> 
> - The first case is the one we have today to handle the MPU -> L3 dependency: In that case it is a pure policy dependency, that can or not be applied depending of the need and of the customer.
> Is it the OPP layer responsibility to handle policy? If it is the case, we should add much more stuff to expose that to user mode and allow a certain amount of flexibility.
Errr... you missed the purpose of the patch I suspect - OPP layer did 
not implement policy - it just provided an uniform mechanism to store 
data, the policy of dependency is implemented in resource34xx.c.


> - The second case is due to HW limitation like on OMAP4, where we cannot have the highest OPP on MPU or IVA with the lowest one on the CORE.
> In that case, we probably have to handle that in the low level voltage management part and not in the OPP layer.
And how would you implement it? you need to describe this information 
some place without hardcoding it.. OPP layer allows you that flexibility.

> 
> 
> Bottom line is I still think this is a little bit over-engineered for the real need, and on the other side that does not fully solve the needs.
I strongly disagree with your opinion. I think the OPP layer's job is to 
store OPP relevant information which can be queried and operated upon by 
layers that implement policy and functionality - how and when they do it 
is up to them, OPP layer should provide a mechanism for data storage and 
this is introduced in this patchset.


-- 
Regards,
Nishanth Menon
