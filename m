From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: move dss device clock configuration
Date: Fri, 1 Apr 2011 13:49:29 +0530
Message-ID: <4D958A91.90807@ti.com>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>	 <1301566266-11187-2-git-send-email-tomi.valkeinen@ti.com>	 <4D957923.2030902@ti.com> <1301641628.3393.5.camel@deskari>	 <4D958407.1080505@ti.com> <1301644231.3393.20.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59118 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053Ab1DAIPR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Apr 2011 04:15:17 -0400
In-Reply-To: <1301644231.3393.20.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Friday 01 April 2011 01:20 PM, Valkeinen, Tomi wrote:
> On Fri, 2011-04-01 at 13:21 +0530, Archit Taneja wrote:
>> On Friday 01 April 2011 12:37 PM, Valkeinen, Tomi wrote:
>>> On Fri, 2011-04-01 at 12:35 +0530, Archit Taneja wrote:
>>>> On Thursday 31 March 2011 03:40 PM, Valkeinen, Tomi wrote:
>>>>> Clock configuration was defined inside dssdev.phy.dsi struct. The clock
>>>>> config doesn't really belong there, and so it's moved to dssdev.clock
>>>>> struct.
>>>>>
>>>>> Now the explicit clock configuration could also be used for other
>>>>> interfaces than DSI, although there's no support for it currently.
>>>>>
>>>>> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
>>>>> ---
>>>>>     arch/arm/mach-omap2/board-4430sdp.c       |   14 +++++++++-----
>>>>>     arch/arm/plat-omap/include/plat/display.h |   28 ++++++++++++++++------------
>>>>>     drivers/video/omap2/dss/dsi.c             |   14 +++++++-------
>>>>>     3 files changed, 32 insertions(+), 24 deletions(-)
>>>>>

<snip>

>> I meant something like:
>> 	
>> 	...
>> 	struct {
>> 		struct {
>> 			struct {
>> 				u16 lck_div;
>> 				u16 pck_div;
>> 			} channel[MAX_CHANNELS];
>> 		} dispc;
>>
>> 		...
>>
>> 		struct {
>>
>> 		} dsi;
>>
>> 	} clocks;
>> 	...
>>
>> Or something equivalent to the thing above, like using a pointer to an
>> array.
>
> What would be the benefit of that? A dss device can be connected only to
> one channel. Now we have the dividers and the channel defined, and
> omapdss can use this info to configure the dividers for that channel
> properly.

Okay, I guess channel wasn't the best example to explain my point, and I 
guess its safe for dss device not to touch any other channels (currently 
ignoring complex bridge chips which can merge data of 2 LCD channels 
onto one panel).

But there are some parameters which might get common across dss devices.
Things like dispc clock source, dispc core clock divider will be shared 
across the panels. We had discussed the possibility of declaring this 
common info in omap_dss_board_info or as a separate common_clocks 
structure. Each device could pick this filled up common_clocks struct, 
or fill it up its own way (for the use cases which has only one panel on 
at a time). I was wondering if it would be easy to move to this approach 
with your patch. dispc itself would now have some common clock stuff and 
per panel clock stuff. Is that a very clean approach?

Anyway, I think it would be good to have a channel struct, as there are 
more things to put in dispc clocks, it should look something like:

struct clocks {
		struct {
			struct {
				u16 lck_div;
				u16 pck_div;
				enum clock_source lcd_clk_src;
			} channel;
			...
			...
			u16 core_clk_div;
		} dispc;
		...
		...
};

Archit
