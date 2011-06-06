From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Mon, 6 Jun 2011 15:15:03 +0200
Message-ID: <4DECD2D7.6030207@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>	 <87hb86a5mm.fsf@ti.com> <1307174504.1777.24.camel@lappyti>	 <4DECCE90.6070201@ti.com> <1307365290.1910.39.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50392 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357Ab1FFNPK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jun 2011 09:15:10 -0400
In-Reply-To: <1307365290.1910.39.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

On 6/6/2011 3:01 PM, Valkeinen, Tomi wrote:
> On Mon, 2011-06-06 at 14:56 +0200, Cousson, Benoit wrote:
>> Hi Tomi,
>>
>> On 6/4/2011 10:01 AM, Valkeinen, Tomi wrote:
>>> On Fri, 2011-06-03 at 15:53 -0700, Kevin Hilman wrote:
>>>> Tomi Valkeinen<tomi.valkeinen@ti.com>   writes:
>>>>
>>>>> Hi Kevin,
>>>>>
>>>>> On Fri, 2011-06-03 at 09:45 -0700, Kevin Hilman wrote:
>>>>>> Tomi Valkeinen<tomi.valkeinen@ti.com>   writes:
>>>>>>
>>>>>>> Use PM runtime and HWMOD support to handle enabling and disabling of DSS
>>>>>>> modules.
>>>>>>>
>>>>>>> Each DSS module will have get and put functions which can be used to
>>>>>>> enable and disable that module. The functions use pm_runtime and hwmod
>>>>>>> opt-clocks to enable the hardware.
>>>>>>>
>>>>>>> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> +int dispc_runtime_get(void)
>>>>>>> +{
>>>>>>> +	int r;
>>>>>>> +
>>>>>>> +	mutex_lock(&dispc.runtime_lock);
>>>>>>
>>>>>> It's not clear to me what the lock is trying to protect.  I guess it's
>>>>>> the counter?  I don't think it should be needed...
>>>>>
>>>>> Yes, the counter. I don't think
>>>>>
>>>>> if (dispc.runtime_count++ == 0)
>>>>>
>>>>> is thread safe.
>>>>
>>>> OK, if it's just the counter, you can drop the mutex and use an atomic
>>>> variable and use atomic_inc(), atomic_dec() etc.  Then it will be clear
>>>> from reading what exactly is protected.
>>>
>>> Hmm, sorry, my mistake. It's actually for the whole function: we can't
>>> do "put" before the whole "get" has finished. Otherwise we could end up,
>>> for example, disabling a clock before enabling it.
>>>
>>>>>>> +	if (dispc.runtime_count++ == 0) {
>>>>>>
>>>>>> You shouldn't need your own use-counting here.  The runtime PM core is
>>>>>> already doing usage counting.
>>>>>>
>>>>>> Instead, you need to use the ->runtime_suspend() and ->runtime_resume()
>>>>>> callbacks (in dev_pm_ops).  These callbacks are called by the runtime PM
>>>>>> core when the usage count goes to/from zero.
>>>>>
>>>>> Yes, I wish I could do that =).
>>>>>
>>>>> I tried to explain this in the 00-patch, I guess I should've explained
>>>>> it in this patch also. Perhaps also in a comment.
>>>>
>>>> Oops, my fault.  I didn't read the whole 00 patch.  I'm pretty ignorant
>>>> about DSS, so I was focused in on the runtime PM implementation only.
>>>> Sorry about that.
>>>>
>>>>>    From the introduction:
>>>>>
>>>>> ---
>>>>>
>>>>> Due to DSS' peculiar clock setup the code is not as elegant as I'd like. The
>>>>> problem is that on OMAP4 we have to enable an optional clock before calling
>>>>> pm_runtime_get(), and similarly we need to keep the optional clock enabled
>>>>> until after pm_runtime_put() has been called.
>>>>
>>>> Just to clarify, what exactly does the opt clock have to be enabled for?
>>>
>>> I'm not sure if this is a valid definition, but in my mind the opt clock
>>> has two uses: 1) a functional clock, to make the HW tick and registers
>>> accessible, and 2) act as a source clock for the outgoing pixel clock.
>>
>> That terminology in the PRCM just means that an opt clock will not be
>> handled automatically by the PRCM and will require SW control.
>> This is not the case for mandatory clock. Upon module enable the PRCM
>> will ensure that all mandatory clocks (functional and interface) are
>> enabled automagically. If the clock is marked as optional it means that
>> the SW will have to enable it explicitly before enabling the module.
>>
>> The modulemode was not there previously on OMAP2&  3, but it is more or
>> less equivalent to icken=1 + fcken=1.
>> This idea was to hide the explicit clock management especially for the
>> iclk that were already supposed to always be in autoidle.
>>
>> Since the current hwmod + clock fmwks are still based on the previous
>> clock centric approach we used to have on OMAP2&  3, we cannot match
>> properly the modulemode to any clock and thus cannot handle properly the
>> DSS fclk as the main clock instead of the optional clock.
>>
>> A temporary option will be to consider the modulemode as the interface
>> clock and thus remove it from the main_clk and replace it by the real
>> DSS fclk.
>>
>> It should work be will unfortunately not be compliant with PRCM
>> recommendation to enable the modulemode once every clocks are enabled.
>>
>> The long term solution is to update the hwmod fmwk to handle the
>> modulemode directly and not through the clock fmwk. It will allow the
>> main_clk to be connnected to the dss_fclk.
>>
>> You will not have that nasty opt_clock issue anymore.
>
> In this long term solution, if the dss_fclk is the main_clk, how does
> the framework handle the situation when we want to switch from the
> standard DSS fclk to the one from DSI PLL?

That part cannot be done by the hwmod fmwk anyway. The goal of the fmwk 
is to ensure that the module is accessible by the driver whatever the 
PRCM clock used.
Enabling the DSI PLL will require the PRCM clock to be enabled first.

Using the DSI PLL as the fclk is doable, but is it really useful or needed?
Assuming you need that mode, you will always have to explicitly switch 
from DSI to PRCM clock before trying to disable the DSS.
This is something you will have to do inside the DSS driver. It should 
be transparent to the hwmod fmwk.

Regards,
Benoit
