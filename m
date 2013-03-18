From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 12/18] ARM: OMAP2+: Add additional GPMC timing parameters
Date: Mon, 18 Mar 2013 10:59:48 -0500
Message-ID: <514739F4.8050307@ti.com>
References: <1363360876-13617-1-git-send-email-jon-hunter@ti.com> <1363360876-13617-13-git-send-email-jon-hunter@ti.com> <51471F8D.4060608@gmail.com> <51472592.4030402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47689 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681Ab3CRP77 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Mar 2013 11:59:59 -0400
In-Reply-To: <51472592.4030402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, Mark Jackson <mpfj-list@mimc.co.uk>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 03/18/2013 09:32 AM, Jon Hunter wrote:
> 
> On 03/18/2013 09:07 AM, Rob Herring wrote:
>> On 03/15/2013 10:21 AM, Jon Hunter wrote:
>>> Some of the GPMC timings parameters are currently missing from the GPMC
>>> device-tree binding. Add these parameters to the binding documentation
>>> as well as code to read them.
>>>
>>> The existing code in gpmc_read_timings_dt() is checking the value of
>>> of_property_read_u32() and only is successful storing the value read
>>> in the gpmc_timings structure. Checking the return value in this case
>>> is not necessary and we can simply read the value, if present, and
>>> store directly in the gpmc_timings structure. Therefore, simplify the
>>> code by removing these checks.
>>>
>>> The comment in the gpmc_read_timings_dt() function, "only for OMAP3430"
>>> is also incorrect as it is applicable to all OMAP3+ devices. So correct
>>> this too.
>>>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt |   25 +++++-
>>>  arch/arm/mach-omap2/gpmc.c                        |   93 ++++++++++-----------
>>>  2 files changed, 66 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>> index 6fde1cf..a63bd93 100644
>>> --- a/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>> @@ -56,10 +56,27 @@ Timing properties for child nodes. All are optional and default to 0.
>>>   - gpmc,oe-off:		Deassertion time
>>>  
>>>   Access time and cycle time timings corresponding to GPMC_CONFIG5:
>>> - - gpmc,page-burst-access: Multiple access word delay
>>> - - gpmc,access:		Start-cycle to first data valid delay
>>> - - gpmc,rd-cycle:	Total read cycle time
>>> - - gpmc,wr-cycle:	Total write cycle time
>>> + - gpmc,page-burst-access: 	Multiple access word delay
>>> + - gpmc,access:			Start-cycle to first data valid delay
>>> + - gpmc,rd-cycle:		Total read cycle time
>>> + - gpmc,wr-cycle:		Total write cycle time
>>> + - gpmc,bus-turnaround:		Turn-around time between successive accesses
>>> + - gpmc,cycle2cycle-delay:	Delay between chip-select pulses
>>> + - gpmc,clk-activation: 	GPMC clock activation time
>>> + - gpmc,wait-monitoring:	Start of wait monitoring with regard to valid
>>> +				data
>>
>> What units are these in? If in nanoseconds, can you append "-ns"
> 
> These are cycles. I can update the comment to reflect that.

Sorry these are nanoseconds. I will update the properties to reflect that.

Jon
