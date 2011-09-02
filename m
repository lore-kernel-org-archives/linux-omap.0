From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 10/10] OMAP: DSS2: DSI Video mode support
Date: Fri, 2 Sep 2011 11:43:16 +0530
Message-ID: <4E6073FC.3070107@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>	 <1314701495-11247-11-git-send-email-archit@ti.com>	 <1314882869.2169.22.camel@lappyti>  <4E606675.5010403@ti.com> <1314941566.1907.16.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43050 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758147Ab1IBGOY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 02:14:24 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p826EBR8011281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 01:14:13 -0500
In-Reply-To: <1314941566.1907.16.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 02 September 2011 11:02 AM, Valkeinen, Tomi wrote:
> On Fri, 2011-09-02 at 10:45 +0530, Archit Taneja wrote:
>> Hi,
>>
>> On Thursday 01 September 2011 06:44 PM, Valkeinen, Tomi wrote:
>>> On Tue, 2011-08-30 at 16:21 +0530, Archit Taneja wrote:
>>>> Add initial support for DSI video mode panels:
>>>> - Add a new structure omap_dss_dsi_videomode_data in the member "panel" in
>>>>     omap_dss_device struct. This allows panel driver to configure dsi video_mode
>>>>     specific parameters.
>>>> - Configure basic DSI video mode timing parameters: HBP, HFP, HSA, VBP, VFP, VSA,
>>>>     TL and VACT.
>>>> - Configure DSI protocol engine registers for video_mode support.
>>>> - Introduce functions dsi_video_mode_enable() and dsi_video_mode_disable() which
>>>>     enable/disable video mode for a given virtual channel and a given pixel format
>>>>     type.
>>>>
>>>> Things left for later
>>>> - Add functions to check for errors in video mode timings provided by panel.
>>>> - Configure timing registers required  for command mode interleaving.
>>>>
>>>> Signed-off-by: Archit Taneja<archit@ti.com>
>>>> ---
>>>>    drivers/video/omap2/dss/dsi.c |  256 ++++++++++++++++++++++++++++++++++++-----
>>>>    include/video/omapdss.h       |   32 +++++
>>>>    2 files changed, 259 insertions(+), 29 deletions(-)
>>>>
>>>> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
>>>> index 582ae7b..e3d5c38 100644
>>>> --- a/drivers/video/omap2/dss/dsi.c
>>>> +++ b/drivers/video/omap2/dss/dsi.c
>>>> @@ -132,7 +132,7 @@ struct dsi_reg { u16 idx; };
>>>>    #define DSI_IRQ_TA_TIMEOUT	(1<<   20)
>>>>    #define DSI_IRQ_ERROR_MASK \
>>>>    	(DSI_IRQ_HS_TX_TIMEOUT | DSI_IRQ_LP_RX_TIMEOUT | DSI_IRQ_SYNC_LOST | \
>>>> -	DSI_IRQ_TA_TIMEOUT)
>>>> +	DSI_IRQ_TA_TIMEOUT | DSI_IRQ_SYNC_LOST)
>>>>    #define DSI_IRQ_CHANNEL_MASK	0xf
>>>>
>>>>    /* Virtual channel interrupts */
>>>> @@ -2472,6 +2472,12 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
>>>>
>>>>    	dsi_cio_timings(dsidev);
>>>>
>>>> +	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
>>>> +		/* DDR_CLK_ALWAYS_ON */
>>>> +		REG_FLD_MOD(dsidev, DSI_CLK_CTRL,
>>>> +			dssdev->panel.dsi_vm_data.ddr_clk_always_on, 13, 13);
>>>> +	}
>>>> +
>>>
>>> For the DDR clock to start, you need to send a null packet, don't you?
>>
>> Yes, we have to send a null packet, but that is for the case when DDR
>> clock is required by the panel to function properly. Hence we need to
>> start the DDR clock right at the beginning(before we start sending
>> DCS/generic commands to configure the panel).
>>
>> The panel driver may set DDR_CLK_ALWAYS_ON even if it has its own
>> internal clock to function. In that case, we don't need it to be enabled
>> right at the beginning, i.e, when we send DCS commands to configure the
>> panel. In this case, the signal TxRequestHS will be asserted later on
>> when we enable video mode for a VC, and that will start the DDR clock.
>
> Why would the panel need DDR_CLK_ALWAYS_ON if it has an another fclk?
> I'm not that familiar with video mode, but somehow it would sound
> logical that if the panel wants DDR clock to be always on, it should be
> started right from the beginning. And if the panel doesn't need DDR
> clock to be always on, there's no need to even set DDR_CLK_ALWAYS_ON.

I'm not totally sure about this to be honest, but I have seen a customer 
panel which works on its internal clocks, but they may get disabled in 
certain scenarios, and at that point might need the host's HS clock. 
I'll try to find out more about this, I'm not totally clear about it myself.

>
>> I had left out the "sending null packet" part as I think its a more
>> specific case. Setting DDR_CLK_ALWAYS_ON affects timing calculations,
>> that is why I added it as a configurable parameter for the panel driver.
>
> Ok. But your patches handle the calculations, don't they?

Well, not really. DDR_CLK_ALWAYS_ON being set/not set is used in the 
calculation of the final PLL divider values, and the horizontal/vertical 
timings for DISPC and DSI. Since these are all already provided by the 
panel driver, we don't need to do any calculations.

I was considering to create a check_video_mode_timings function for 
later. That would validate if the timings calculated are correct with 
DDR_CLK_ALWAYS_ON set.

>
> Sending a null packet to start the DDR clk is rather OMAP specific
> internal thing, so I don't want to require the panel driver to need to
> know that it must send a null packet to start the clock. So if the ddr
> clk is not started automatically, I think we should have a function to
> do that (dsi_start_ddr_clk or whatever), which will then send the null
> packet (and perhaps return an error if DDR_CLK_ALWAYS_ON is not set,
> dunno...).

Okay, If we can confirm that a panel asks for DDR_CLK_ALWAYS_ON mainly 
because it doesn't have its own fclk, then the dsi driver surely needs 
to start the DDR clock by sending a NULL packet.

If this is to be done, one thing that has to be thought of is:

- We need one of the requested VC's to be in HS mode for this. Do we 
enable HS for a VC in the dsi driver itself? Currently, its the job of 
the panel driver to enable HSmode for a VC. Is this a clean approach?

Archit
