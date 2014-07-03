From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for ti,mux-clock
Date: Thu, 3 Jul 2014 10:41:22 +0300
Message-ID: <53B50922.7070402@ti.com>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com> <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com> <53A2CA7A.60206@ti.com> <20140701194833.GH13396@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42797 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755531AbaGCHkh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2014 03:40:37 -0400
In-Reply-To: <20140701194833.GH13396@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

On 07/01/2014 10:48 PM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Jun 19, 2014 at 02:33:14PM +0300, Tero Kristo wrote:
>> On 06/17/2014 11:04 AM, Tomi Valkeinen wrote:
>>> When setting the rate of a clock, by default the clock framework will
>>> change the parent of the clock to the most suitable one in
>>> __clk_mux_determine_rate() (most suitable by looking at the clock rate).
>>>
>>> This is a rather dangerous default, and causes problems on AM43x when
>>> using display and ethernet. There are multiple ways to select the clock
>>> muxes on AM43x, and some of those clock paths have the same source
>>> clocks for display and ethernet. When changing the clock rate for the
>>> display subsystem, the clock framework decides to change the display mux
>> >from the dedicated display PLL to a shared PLL which is used by the
>>> ethernet, and then changes the rate of the shared PLL, breaking the
>>> ethernet.
>>>
>>> As I don't think there ever is a case where we want the clock framework
>>> to automatically change the parent clock of a clock mux, this patch sets
>>> the CLK_SET_RATE_NO_REPARENT for all ti,mux-clocks.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>   drivers/clk/ti/mux.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
>>> index 0197a478720c..e9d650e51287 100644
>>> --- a/drivers/clk/ti/mux.c
>>> +++ b/drivers/clk/ti/mux.c
>>> @@ -160,7 +160,7 @@ static void of_mux_clk_setup(struct device_node *node)
>>>   	u8 clk_mux_flags = 0;
>>>   	u32 mask = 0;
>>>   	u32 shift = 0;
>>> -	u32 flags = 0;
>>> +	u32 flags = CLK_SET_RATE_NO_REPARENT;
>>>
>>>   	num_parents = of_clk_get_parent_count(node);
>>>   	if (num_parents < 2) {
>>>
>>
>> Thanks, queued for 3.16-rc fixes.
>
> did you skip a few -rcs by any chance? Looks like this could've been
> merged on v3.16-rc3... Just checking.

This goes through Mike's clk tree, so there is extra latency there. Not 
sure when he plans to send next pull-req for clk-fixes to linux-master.

-Tero
