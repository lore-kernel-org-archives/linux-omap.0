From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all omap_clk_get_by_name
 usage
Date: Fri, 31 Aug 2012 13:50:31 +0530
Message-ID: <504073CF.6010804@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>  <1346230576-20004-3-git-send-email-rnayak@ti.com>  <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>  <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com>  <1346344933.2327.43.camel@deskari> <5040586D.2020406@ti.com> <1346397309.18766.5.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34404 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab2HaIWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 04:22:13 -0400
In-Reply-To: <1346397309.18766.5.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Turquette, Mike" <mturquette@ti.com>

On Friday 31 August 2012 12:45 PM, Tomi Valkeinen wrote:
> On Fri, 2012-08-31 at 11:53 +0530, Archit Taneja wrote:
>
>> The only little problem was that during bootup, when hwmods are setup,
>> only the 'parent' hwmod was able to get reset properly, all the other
>> 'child' hwmods don't have modulemode bits tied to them, and hence
>> weren't able to reset. So we got some error prints.
>>
>> Once DSS driver kicks in, the driver ensures the parent is enabled for
>> any child to be enabled, so we don't face the issue again.
>>
>> So, if DSS driver is not built in, and if the bootloader left DSS in a
>> bad state, the DSS clocks might remain messed up all the time since
>> hwmod fwk wasn't able to reset them.
>>
>> I think this is why we didn't proceed with remove "dss_fck" as a slave
>> clock. If this issue is minor, we could go ahead and remove it.
>
> I wonder if we could handle this with a custom reset function. We
> already have a reset func for dss core. If I remember right, the main
> point for that is the fact that omap4 doesn't have a softreset for dss
> core, so we manually write the default values to registers.
>
> For omap2/3 this would be simple: skip the resets for all other dss
> submodules, and dss core's reset would enable all the clocks and set the
> softreset bit. This would reset all the submodules also.
>
> Omap4 is more tricky. I guess we'd need to enable all the clocks, clear
> manually dss core's registers, and then set softreset bits in all the
> submodules. So in this case dss core would need to have information
> about the other submodules.

The is a good idea. I don't clearly understand your approach though. Are 
you saying we have a custom reset function for only dss core? And reset 
the submodules in it manually?

An alternative approach would be to implement custom reset functions for 
each submodule(or each hwmod), and in the beginning of every reset 
function, add a hack to enable MODULEMODE bits(since we don't want hwmod 
fwk to touch MODULEMODE for the DSS submodules), and then set the soft 
reset bits.

Your approach would ensure that we get a clean reset of DSS, but it 
would still give the annoying prints when each of the submodule tries to 
reset itself.

Archit
