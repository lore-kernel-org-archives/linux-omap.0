From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP2+: timer: remove CONFIG_OMAP_32K_TIMER
Date: Tue, 13 Nov 2012 11:14:12 +0200
Message-ID: <50A20F64.4010902@compulab.co.il>
References: <1352299344-8011-1-git-send-email-grinberg@compulab.co.il> <509AD478.1050904@ti.com> <509B666F.6080507@compulab.co.il> <509BFFDF.9040605@ti.com> <79CD15C6BA57404B839C016229A409A83EB68799@DBDE01.ent.ti.com> <509C050C.6010201@ti.com> <509F8BEF.90008@compulab.co.il> <50A14AD1.4070704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:58134 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979Ab2KMJOS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 04:14:18 -0500
In-Reply-To: <50A14AD1.4070704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 11/12/12 21:15, Jon Hunter wrote:
> 
> On 11/11/2012 05:28 AM, Igor Grinberg wrote:
>>
>>
>> On 11/08/12 21:16, Jon Hunter wrote:
>>>
>>> On 11/08/2012 12:59 PM, Hiremath, Vaibhav wrote:
>>>> On Fri, Nov 09, 2012 at 00:24:23, Hunter, Jon wrote:
>>>>>
>>>>> On 11/08/2012 01:59 AM, Igor Grinberg wrote:
>>>>>
>>>>> [snip]
>>>>>
>>>>>> There is no reliable way to determine which source should be used in runtime
>>>>>> for boards that do not have the 32k oscillator wired.
>>>>>
>>>>> So thinking about this some more and given that we are moving away from
>>>>> board files, if a board does not provide a 32kHz clock source, then this
>>>>> should be reflected in the device-tree source file for that board.
>>>>> Hence, at boot time we should be able to determine if a 32kHz clock
>>>>> source can be used.
>>>>>
>>>>
>>>> Let me feed some more thoughts here :)
>>>>
>>>> The way it is being detected currently is based on timer idle status bit.
>>>> I am worried that, this is the only option we have.
>>>
>>> Why not use device-tree to indicate the presence of a 32k clock source?
>>> This seems like a board level configuration and so device-tree seems to
>>> be the perfect place for this IMO.
>>
>> Well, that is what my commit message says...
> 
> Sorry, but that was not clear to me from whats in the commit message.

>From the commit message:
"1) Timer structures and initialization functions are named by the platform
   name and the clock source in use. The decision which timer is
   used is done statically from the machine_desc structure. In the
   future it should come from DT."

The last sentence has it.
The transition to DT is not immediate and we can't (still) neglect
the non-DT setups.

> 
> Should we be doing this now instead of adding all these static timer
> init functions?

I don't see this as "adding ...", I see this as expanding the setup
which was previously hidden by the CONFIG_OMAP_32K_TIMER option.

> 
> Are there any boards today (supported in the kernel that is), that don't
> support a 32k?

Yes, starting from revision 1.2, CM-T3517 does not have the 32k.

[...]

-- 
Regards,
Igor.
