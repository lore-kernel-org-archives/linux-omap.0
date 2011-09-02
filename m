From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 10/10] OMAP: DSS2: DSI Video mode support
Date: Fri, 2 Sep 2011 10:45:33 +0530
Message-ID: <4E606675.5010403@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>	 <1314701495-11247-11-git-send-email-archit@ti.com> <1314882869.2169.22.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40872 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab1IBFQg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 01:16:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p825GWVp006058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 2 Sep 2011 00:16:35 -0500
In-Reply-To: <1314882869.2169.22.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thursday 01 September 2011 06:44 PM, Valkeinen, Tomi wrote:
> On Tue, 2011-08-30 at 16:21 +0530, Archit Taneja wrote:
>> Add initial support for DSI video mode panels:
>> - Add a new structure omap_dss_dsi_videomode_data in the member "panel" in
>>    omap_dss_device struct. This allows panel driver to configure dsi video_mode
>>    specific parameters.
>> - Configure basic DSI video mode timing parameters: HBP, HFP, HSA, VBP, VFP, VSA,
>>    TL and VACT.
>> - Configure DSI protocol engine registers for video_mode support.
>> - Introduce functions dsi_video_mode_enable() and dsi_video_mode_disable() which
>>    enable/disable video mode for a given virtual channel and a given pixel format
>>    type.
>>
>> Things left for later
>> - Add functions to check for errors in video mode timings provided by panel.
>> - Configure timing registers required  for command mode interleaving.
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dsi.c |  256 ++++++++++++++++++++++++++++++++++++-----
>>   include/video/omapdss.h       |   32 +++++
>>   2 files changed, 259 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
>> index 582ae7b..e3d5c38 100644
>> --- a/drivers/video/omap2/dss/dsi.c
>> +++ b/drivers/video/omap2/dss/dsi.c
>> @@ -132,7 +132,7 @@ struct dsi_reg { u16 idx; };
>>   #define DSI_IRQ_TA_TIMEOUT	(1<<  20)
>>   #define DSI_IRQ_ERROR_MASK \
>>   	(DSI_IRQ_HS_TX_TIMEOUT | DSI_IRQ_LP_RX_TIMEOUT | DSI_IRQ_SYNC_LOST | \
>> -	DSI_IRQ_TA_TIMEOUT)
>> +	DSI_IRQ_TA_TIMEOUT | DSI_IRQ_SYNC_LOST)
>>   #define DSI_IRQ_CHANNEL_MASK	0xf
>>
>>   /* Virtual channel interrupts */
>> @@ -2472,6 +2472,12 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
>>
>>   	dsi_cio_timings(dsidev);
>>
>> +	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
>> +		/* DDR_CLK_ALWAYS_ON */
>> +		REG_FLD_MOD(dsidev, DSI_CLK_CTRL,
>> +			dssdev->panel.dsi_vm_data.ddr_clk_always_on, 13, 13);
>> +	}
>> +
>
> For the DDR clock to start, you need to send a null packet, don't you?

Yes, we have to send a null packet, but that is for the case when DDR 
clock is required by the panel to function properly. Hence we need to 
start the DDR clock right at the beginning(before we start sending 
DCS/generic commands to configure the panel).

The panel driver may set DDR_CLK_ALWAYS_ON even if it has its own 
internal clock to function. In that case, we don't need it to be enabled 
right at the beginning, i.e, when we send DCS commands to configure the 
panel. In this case, the signal TxRequestHS will be asserted later on 
when we enable video mode for a VC, and that will start the DDR clock.

I had left out the "sending null packet" part as I think its a more 
specific case. Setting DDR_CLK_ALWAYS_ON affects timing calculations, 
that is why I added it as a configurable parameter for the panel driver.

Archit

>
>   Tomi
>
>

