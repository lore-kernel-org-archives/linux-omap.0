From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] usb: musb: da8xx: Use the right dma controller
Date: Mon, 9 Jan 2017 21:54:25 +0300
Message-ID: <5a002693-1ebf-550f-02df-b40e44f59751@cogentembedded.com>
References: <20170109163902.5268-1-abailon@baylibre.com>
 <20170109163902.5268-2-abailon@baylibre.com>
 <7dcfe848-a421-d409-0e9a-659c095e4e31@cogentembedded.com>
 <20170109184352.GL2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109184352.GL2630-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/09/2017 09:43 PM, Tony Lindgren wrote:

>>> da8xx driver is registering and using the cppi dma controller but actually,
>>> the da8xx has a cppi41 dma controller.
>>> Update the driver to register and use the cppi41 dma controller.
>>>
>>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>>> ---
>>>  drivers/usb/musb/da8xx.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
>>> index e89708d..74dcc07 100644
>>> --- a/drivers/usb/musb/da8xx.c
>>> +++ b/drivers/usb/musb/da8xx.c
>>> @@ -458,14 +458,14 @@ static inline u8 get_vbus_power(struct device *dev)
>>>  }
>>>
>>>  static const struct musb_platform_ops da8xx_ops = {
>>> -	.quirks		= MUSB_DMA_CPPI | MUSB_INDEXED_EP,
>>
>>    Grr, MUSB_DMA_CPPI is certainly wrong! There's no CPPI 3.0 support for
>> DA8xx. Where have this come from?
>>
>>> +	.quirks		= MUSB_DMA_CPPI41 | MUSB_INDEXED_EP,
>>>  	.init		= da8xx_musb_init,
>>>  	.exit		= da8xx_musb_exit,
>>>
>>>  	.fifo_mode	= 2,
>>> -#ifdef CONFIG_USB_TI_CPPI_DMA
>>> -	.dma_init	= cppi_dma_controller_create,
>>> -	.dma_exit	= cppi_dma_controller_destroy,
>>
>>    Likewise, WTF?
>>    I suggest that you fix this crap in a separate commit, to be backported
>> to -stable if needed.
>
> Probably came from my DMA patch 7f6283ed6fe8 ("usb: musb: Set up function

    Too bad I missed it back then. Then certainly this should be fixed in a 
separate patch. The first hunk was not a part of that commit, tho...

> pointers for DMA"). At that point I thought da8xxx.c and davinci.c are just
> separate attempts of the same driver.. Sorry the number of musb glue layers
> is just too confusing.

    :-)

> Tony

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
