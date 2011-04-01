From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: move dss device clock configuration
Date: Fri, 1 Apr 2011 13:21:35 +0530
Message-ID: <4D958407.1080505@ti.com>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>	 <1301566266-11187-2-git-send-email-tomi.valkeinen@ti.com>	 <4D957923.2030902@ti.com> <1301641628.3393.5.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50982 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189Ab1DAHrW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 03:47:22 -0400
In-Reply-To: <1301641628.3393.5.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Friday 01 April 2011 12:37 PM, Valkeinen, Tomi wrote:
> On Fri, 2011-04-01 at 12:35 +0530, Archit Taneja wrote:
>> On Thursday 31 March 2011 03:40 PM, Valkeinen, Tomi wrote:
>>> Clock configuration was defined inside dssdev.phy.dsi struct. The clock
>>> config doesn't really belong there, and so it's moved to dssdev.clock
>>> struct.
>>>
>>> Now the explicit clock configuration could also be used for other
>>> interfaces than DSI, although there's no support for it currently.
>>>
>>> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
>>> ---
>>>    arch/arm/mach-omap2/board-4430sdp.c       |   14 +++++++++-----
>>>    arch/arm/plat-omap/include/plat/display.h |   28 ++++++++++++++++------------
>>>    drivers/video/omap2/dss/dsi.c             |   14 +++++++-------
>>>    3 files changed, 32 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
>>> index 05288c9..626b16b 100644
>>> --- a/arch/arm/mach-omap2/board-4430sdp.c
>>> +++ b/arch/arm/mach-omap2/board-4430sdp.c
>
> <snip>
>
>>> @@ -424,6 +412,22 @@ struct omap_dss_device {
>>>    	} phy;
>>>
>>>    	struct {
>>> +		struct {
>>> +			u16 lck_div;
>>> +			u16 pck_div;
>>
>> Is it possible to wrap these members around a channel member? The board
>> file can then fill up the lck_div and ppck_div based on what channel it
>> is using.
>
> Hmm. What do you mean "wrap around"? The channel is defined a bit below
> there.
>

I meant something like:
	
	...
	struct {
		struct {
			struct {
				u16 lck_div;
				u16 pck_div;
			} channel[MAX_CHANNELS];
		} dispc;

		...

		struct {

		} dsi;

	} clocks;
	...

Or something equivalent to the thing above, like using a pointer to an 
array.

Archit
