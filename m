From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 05/10] usb: musb: tusb6010_omap: Do not reset the other
 direction's packet size
Date: Thu, 11 May 2017 09:19:17 +0300
Message-ID: <2d693d53-ba32-1549-90bd-da92f061cbed@ti.com>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
 <20170510084231.19302-6-peter.ujfalusi@ti.com>
 <20170510170754.GA7154@uda0271908> <1494458188.2028.5.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494458188.2028.5.camel@perches.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Bin Liu <b-liu@ti.com>
Cc: tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 2017-05-11 02:16, Joe Perches wrote:
> On Wed, 2017-05-10 at 12:07 -0500, Bin Liu wrote:
>> On Wed, May 10, 2017 at 11:42:27AM +0300, Peter Ujfalusi wrote:
>>> We have one register for each EP to set the maximum packet size for both
>>> TX and RX.
>>> If for example an RX programming would happen before the previous TX
>>> transfer finishes we would reset the TX packet side.
>>>
>>> To fix this issue, only modify the TX or RX part of the register.
> []
>>> diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
> []
>>> @@ -389,15 +389,19 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
>>>   
>>>   	if (chdat->tx) {
>>>   		/* Send transfer_packet_sz packets at a time */
>>> -		musb_writel(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET,
>>> -			chdat->transfer_packet_sz);
>>> +		u32 psize = musb_readl(ep_conf, TUSB_EP_MAX_PACKET_SIZE_OFFSET);
>>
>> checkpatch.pl complains about declaration and assignment together.
> 
> No it doesn't.

It 'only' complains about:
WARNING: Missing a blank line after declarations

which is valid.

- Péter
