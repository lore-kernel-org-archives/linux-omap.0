From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all omap_clk_get_by_name
 usage
Date: Fri, 31 Aug 2012 11:53:41 +0530
Message-ID: <5040586D.2020406@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com> <1346230576-20004-3-git-send-email-rnayak@ti.com> <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com> <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com> <1346344933.2327.43.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36044 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418Ab2HaGZV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 02:25:21 -0400
In-Reply-To: <1346344933.2327.43.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Turquette, Mike" <mturquette@ti.com>

On Thursday 30 August 2012 10:12 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-30 at 13:57 +0200, Benoit Cousson wrote:
>> On 08/30/2012 10:39 AM, Rajendra Nayak wrote:
>>> On Thursday 30 August 2012 05:45 AM, Turquette, Mike wrote:
>>>> On Wed, Aug 29, 2012 at 1:56 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>>>>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c
>>>>> b/arch/arm/mach-omap2/clock44xx_data.c
>>>>> index d7f55e4..a3831a2 100644
>>>>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>>>>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>>>>> @@ -3156,6 +3156,7 @@ static struct omap_clk omap44xx_clks[] = {
>>>>>           CLK(NULL,       "dss_tv_clk",&dss_tv_clk,    CK_443X),
>>>>>           CLK(NULL,       "dss_48mhz_clk",&dss_48mhz_clk, CK_443X),
>>>>>           CLK(NULL,       "dss_dss_clk",&dss_dss_clk,   CK_443X),
>>>>> +       CLK(NULL,       "dss_fck",&dss_fck,       CK_443X),
>>>>>           CLK("omapdss_dss",      "ick",&dss_fck,       CK_443X),
>>>>
>>>> Is it right to re-use dss_fck for the "ick" here?  I think it is due
>>>> to omap4 modulemode stuff but I don't have DM in front of me and
>>>> wanted a double-check...
>>>
>>> yes, its because of the wierdness of DSS clocks where a so-called
>>> optional clock is actually a function clock.
>>
>> Not only, it is a hack to allow the DSS to be enabled whenever a DSS
>> submodule has to be enabled. Since they are sharing the ick, it will
>> enable the modulemode when the DISPC will be enabled.
>>
>> That hack should disappear as soon as the DSS will be able to handle the
>> PM dependency between DSS submodules and the DSS itself using pm_runtime
>> parent/child link.
>> And then we will have to remove this fake ick modulemode clock node and
>> let hwmod handle that properly.
>>
>> Tomi already cleaned the DSS part, I guess it should be upstreamed soon,
>> if this is not already the case.
>
> This is in 3.5. omapdss_dss is now the parent for the rest of the dss
> submodules, and runtime PM is being used.
>
> I think we should now revisit this dss clock handling to see if there
> are any other changes required in the omapdss side, but I hope they are
> already according to our discussions and correct.

The only little problem was that during bootup, when hwmods are setup, 
only the 'parent' hwmod was able to get reset properly, all the other 
'child' hwmods don't have modulemode bits tied to them, and hence 
weren't able to reset. So we got some error prints.

Once DSS driver kicks in, the driver ensures the parent is enabled for 
any child to be enabled, so we don't face the issue again.

So, if DSS driver is not built in, and if the bootloader left DSS in a 
bad state, the DSS clocks might remain messed up all the time since 
hwmod fwk wasn't able to reset them.

I think this is why we didn't proceed with remove "dss_fck" as a slave 
clock. If this issue is minor, we could go ahead and remove it.

Archit

