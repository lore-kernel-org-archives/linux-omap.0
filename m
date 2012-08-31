From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all omap_clk_get_by_name
 usage
Date: Fri, 31 Aug 2012 13:58:16 +0530
Message-ID: <504075A0.7010708@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>   <1346230576-20004-3-git-send-email-rnayak@ti.com>   <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>   <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com>   <1346344933.2327.43.camel@deskari> <5040586D.2020406@ti.com>  <1346397309.18766.5.camel@lappyti> <504073CF.6010804@ti.com> <1346401643.32389.4.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42283 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab2HaI37 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 04:29:59 -0400
In-Reply-To: <1346401643.32389.4.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Turquette, Mike" <mturquette@ti.com>

On Friday 31 August 2012 01:57 PM, Tomi Valkeinen wrote:
> On Fri, 2012-08-31 at 13:50 +0530, Archit Taneja wrote:
>> On Friday 31 August 2012 12:45 PM, Tomi Valkeinen wrote:
>>> On Fri, 2012-08-31 at 11:53 +0530, Archit Taneja wrote:
>>>
>>>> The only little problem was that during bootup, when hwmods are setup,
>>>> only the 'parent' hwmod was able to get reset properly, all the other
>>>> 'child' hwmods don't have modulemode bits tied to them, and hence
>>>> weren't able to reset. So we got some error prints.
>>>>
>>>> Once DSS driver kicks in, the driver ensures the parent is enabled for
>>>> any child to be enabled, so we don't face the issue again.
>>>>
>>>> So, if DSS driver is not built in, and if the bootloader left DSS in a
>>>> bad state, the DSS clocks might remain messed up all the time since
>>>> hwmod fwk wasn't able to reset them.
>>>>
>>>> I think this is why we didn't proceed with remove "dss_fck" as a slave
>>>> clock. If this issue is minor, we could go ahead and remove it.
>>>
>>> I wonder if we could handle this with a custom reset function. We
>>> already have a reset func for dss core. If I remember right, the main
>>> point for that is the fact that omap4 doesn't have a softreset for dss
>>> core, so we manually write the default values to registers.
>>>
>>> For omap2/3 this would be simple: skip the resets for all other dss
>>> submodules, and dss core's reset would enable all the clocks and set the
>>> softreset bit. This would reset all the submodules also.
>>>
>>> Omap4 is more tricky. I guess we'd need to enable all the clocks, clear
>>> manually dss core's registers, and then set softreset bits in all the
>>> submodules. So in this case dss core would need to have information
>>> about the other submodules.
>>
>> The is a good idea. I don't clearly understand your approach though. Are
>> you saying we have a custom reset function for only dss core? And reset
>> the submodules in it manually?
>
> Yes.
>
>> An alternative approach would be to implement custom reset functions for
>> each submodule(or each hwmod), and in the beginning of every reset
>> function, add a hack to enable MODULEMODE bits(since we don't want hwmod
>> fwk to touch MODULEMODE for the DSS submodules), and then set the soft
>> reset bits.
>
> I thought about that also. We'd need reset functions for all of them,
> and for omap2/3 we'd just reset the submodules again as they have
> already been reset with the dss core reset.
>
> The dss submodule resets are a bit linked. For omap2/3 the connection is
> obvious as dss core reset resets also the submodules, and for omap4 we
> have this requirement for the modulemode. That's why I though it'd be
> perhaps cleaner to handle the reset of the DSS block as a whole, in one
> place.
>
>> Your approach would ensure that we get a clean reset of DSS, but it
>> would still give the annoying prints when each of the submodule tries to
>> reset itself.
>
> The other submodules would not be reset by the hwmod framework at all,
> so there wouldn't be prints. I think there's a flag for that.

Oh, yeah. I didn't think of it that way, we could just 'not reset' the 
DSS submodule hwmod using this flag.

If we do that, then your approach sounds good.

Archit

