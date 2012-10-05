From: Archit Taneja <archit@ti.com>
Subject: Re: OMAP4 clock/pm fixes [was: [PATCH v4 2/3] ARM: omap: hwmod: get
 rid of all omap_clk_get_by_name usage
Date: Fri, 5 Oct 2012 17:59:18 +0530
Message-ID: <506ED29E.7070403@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com> <1346230576-20004-3-git-send-email-rnayak@ti.com> <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com> <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com> <1346344933.2327.43.camel@deskari> <5040586D.2020406@ti.com> <1346397309.18766.5.camel@lappyti> <504073CF.6010804@ti.com> <1346401643.32389.4.camel@deskari> <504075A0.7010708@ti.com> <506EAC89.2070307@ti.com> <506ED079.70700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57726 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442Ab2JEM31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 08:29:27 -0400
In-Reply-To: <506ED079.70700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Turquette, Mike" <mturquette@ti.com>

On Friday 05 October 2012 05:50 PM, Benoit Cousson wrote:
> Hi Archit,
>
> On 10/05/2012 11:46 AM, Archit Taneja wrote:
>> Hi,
>>
>> On Friday 31 August 2012 01:58 PM, Archit Taneja wrote:
>>> On Friday 31 August 2012 01:57 PM, Tomi Valkeinen wrote:
>>>> On Fri, 2012-08-31 at 13:50 +0530, Archit Taneja wrote:
>>>>> On Friday 31 August 2012 12:45 PM, Tomi Valkeinen wrote:
>>>>>> On Fri, 2012-08-31 at 11:53 +0530, Archit Taneja wrote:
>>>>>>
>>>>>>> The only little problem was that during bootup, when hwmods are
>>>>>>> setup,
>>>>>>> only the 'parent' hwmod was able to get reset properly, all the other
>>>>>>> 'child' hwmods don't have modulemode bits tied to them, and hence
>>>>>>> weren't able to reset. So we got some error prints.
>>>>>>>
>>>>>>> Once DSS driver kicks in, the driver ensures the parent is enabled
>>>>>>> for
>>>>>>> any child to be enabled, so we don't face the issue again.
>>>>>>>
>>>>>>> So, if DSS driver is not built in, and if the bootloader left DSS
>>>>>>> in a
>>>>>>> bad state, the DSS clocks might remain messed up all the time since
>>>>>>> hwmod fwk wasn't able to reset them.
>>>>>>>
>>>>>>> I think this is why we didn't proceed with remove "dss_fck" as a
>>>>>>> slave
>>>>>>> clock. If this issue is minor, we could go ahead and remove it.
>>>>>>
>>>>>> I wonder if we could handle this with a custom reset function. We
>>>>>> already have a reset func for dss core. If I remember right, the main
>>>>>> point for that is the fact that omap 4 doesn't have a softreset for dss
>>>>>> core, so we manually write the default values to registers.
>>>>>>
>>>>>> For omap2/3 this would be simple: skip the resets for all other dss
>>>>>> submodules, and dss core's reset would enable all the clocks and set
>>>>>> the
>>>>>> softreset bit. This would reset all the submodules also.
>>>>>>
>>>>>> Omap4 is more tricky. I guess we'd need to enable all the clocks,
>>>>>> clear
>>>>>> manually dss core's registers, and then set softreset bits in all the
>>>>>> submodules. So in this case dss core would need to have information
>>>>>> about the other submodules.
>>>>>
>>>>> The is a good idea. I don't clearly understand your approach though.
>>>>> Are
>>>>> you saying we have a custom reset function for only dss core? And reset
>>>>> the submodules in it manually?
>>>>
>>>> Yes.
>>>>
>>>>> An alternative approach would be to implement custom reset functions
>>>>> for
>>>>> each submodule(or each hwmod), and in the beginning of every reset
>>>>> function, add a hack to enable MODULEMODE bits(since we don't want
>>>>> hwmod
>>>>> fwk to touch MODULEMODE for the DSS submodules), and then set the soft
>>>>> reset bits.
>>>>
>>>> I thought about that also. We'd need reset functions for all of them,
>>>> and for omap2/3 we'd just reset the submodules again as they have
>>>> already been reset with the dss core reset.
>>>>
>>>> The dss submodule resets are a bit linked. For omap2/3 the connection is
>>>> obvious as dss core reset resets also the submodules, and for omap4 we
>>>> have this requirement for the modulemode. That's why I though it'd be
>>>> perhaps cleaner to handle the reset of the DSS block as a whole, in one
>>>> place.
>>>>
>>>>> Your approach would ensure that we get a clean reset of DSS, but it
>>>>> would still give the annoying prints when each of the submodule
>>>>> tries to
>>>>> reset itself.
>>>>
>>>> The other submodules would not be reset by the hwmod framework at all,
>>>> so there wouldn't be prints. I think there's a flag for that.
>>
>> Sorry for bringing up an old thread. I was working on cleaning up the
>> OMAP4 DSS related clock/pm issues, hence brought it up.
>>
>> We were discussing here on how to setting up and reset the OMAP4 DSS
>> submodules correctly without tying the MODULEMODE bits to the
>> corresponding hwmods.
>>
>> Tomi, your suggestion was to do soft resets for the submodules manually
>> in the dss_core hwmod's custom reset function itself, and use the flag
>> HWMOD_INIT_NO_RESET to prevent _reset() being called.
>
> Yep, that's the right approach.
>
>> However, this won't still resolve the issue of the errors we see a
>> bootup. The function _setup_reset() looks like this:
>>
>> static int _setup_reset(struct omap_hwmod *oh)
>> {
>>      ...
>>      r = _enable(oh);
>>      if (r) {
>>                   pr_warning("omap_hwmod: %s: cannot be enabled for
>>              reset (%d)\n", oh->name, oh->_state);
>>                          return -EINVAL;
>>                  }
>>      ...
>>
>>      if (!(oh->flags & HWMOD_INIT_NO_RESET))
>>          r = _reset(oh);
>>
>>      ...
>> }
>>
>> So, even if we have ask hwmod not to reset the DSS submodules, it will
>> still try to enable them, and we can't enable them since MODULEMODE
>> isn't tied to them. I don't see how we can get a clean reset done for
>> the DSS submodules without making some changes in hwmod framework.
>
> Yeah, I do agree. Some module cannot but enabled automatically in the fmwk due to PM dependency.
> This is the case as well for MCPDM, IPU, DSP, ISS, FDIF...
>
> In that case the early setup should just be skipped and the DSS driver should take care of that during probe / pm_runtime_enable.
>
> I already have a WIP series that delay the setup until the driver probe the device. It will allow the setup to work properly in the case of the DSS assuming the DISPC and other sub IPs are setup in the context of DSS probe. At that time the DSS will be enabled already and thus every sub IPs will be able to get enabled.
>
> It is done in the context of DT boot, but should work as well for legacy boot.
> I can share the current crappy patches as soon as I fixed a couple of regression introduced by the patches :-(

Ah, that will be great!

The other not so good option to make DSS PM work would be to add 
OCPIF_SWSUP_IDLE flag to our l3_main_2__dss_* slave interfaces(which 
have the hack "dss_fck" as slave clock). I gave this approach a try, 
that too isn't working so well. When I disable DSS, I get 
CM_DSS_DSS_CLKCTRL.IDLEST as 0x1, and 
CM_DSS_CLKSTCTRL.CLKACTIVITY_DSS_L3_ICLK is set. I wonder why that's 
happening.

Thanks,
Archit

