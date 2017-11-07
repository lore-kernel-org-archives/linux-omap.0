From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 04/27] clk: ti: clkctrl: use fallback udelay approach if
 timekeeping is suspended
Date: Tue, 7 Nov 2017 09:06:14 +0200
Message-ID: <ce8c4e07-8925-9b97-5d18-76c72985769e@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
 <1509368685-29112-5-git-send-email-t-kristo@ti.com>
 <20171103154317.GV11011@codeaurora.org>
 <3249933f-7f37-a6c9-ed0c-58d40f06578b@ti.com>
 <20171106221847.GB22441@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20171106221847.GB22441@codeaurora.org>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 07/11/17 00:18, Stephen Boyd wrote:
> On 11/06, Tero Kristo wrote:
>> On 03/11/17 17:43, Stephen Boyd wrote:
>>> On 10/30, Tero Kristo wrote:
>>>> @@ -90,7 +91,7 @@ static bool _omap4_is_ready(u32 val)
>>>>   static bool _omap4_is_timeout(union omap4_timeout *time, u32 timeout)
>>>>   {
>>>> -	if (unlikely(_early_timeout)) {
>>>> +	if (unlikely(_early_timeout || timekeeping_suspended)) {
>>>>   		if (time->cycles++ < timeout) {
>>>
>>> This would be the second user of timekeeping_suspended outside of
>>> timekeeping core. Why don't we just udelay(1) every time we call
>>> this function? The loop on ktime without any sort of delay in it
>>> may actually spin faster, especially because we can't get
>>> interrupted here (irqs are off). And irqs + preemption enabled is
>>> typically where you would want to use ktime instead of counting
>>> udelay() calls to see if you hit a timeout.
>>
>> It actually was originally just udelay() but I changed it to use the
>> ktime_get() approach way back due to comments provided on some early
>> revisions of this patch. See:
>> https://patchwork.kernel.org/patch/7884371/
>>
> 
> Ok, so we use ktime to spin faster on the bit than udelay() would
> allow us to. That looks to be on purpose because udelay(1) is too
> long between bit checks.
> 
> What is causing us to call this path after timekeeping has been
> suspended? Please add some more specifics to the commit text so
> we know exactly where it's happening. Also add a comment above
> the if statement describing why we're checking the variable so it
> isn't buried in commit text somewhere and Cc timekeeping
> maintainers on the patch please.

Ok, I'll comment this in the code and repost.

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
