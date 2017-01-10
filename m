From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 4/4] usb: musb: musb_cppi41: Workaround dma stall issue
 during teardown
Date: Tue, 10 Jan 2017 11:12:53 +0100
Message-ID: <d3c34d6f-1eeb-7d03-39a3-fd9873be75d0@baylibre.com>
References: <20170109163902.5268-1-abailon@baylibre.com>
 <20170109163902.5268-5-abailon@baylibre.com>
 <511a1b59-82d8-4f29-98ce-273e3cc65797@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <511a1b59-82d8-4f29-98ce-273e3cc65797-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, b-liu-l0cyMroinI0@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/09/2017 07:34 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 01/09/2017 07:39 PM, Alexandre Bailon wrote:
> 
>> The dma may hung up if a teardown is initiated while an endpoint is still
> 
>    The DMA may hang up...
> 
>> active (Advisory 2.3.27 of da8xx errata).
>> To workaround this issue, add a delay before to initiate the teardown.
>>
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> [...]
>> diff --git a/drivers/usb/musb/musb_cppi41.c
>> b/drivers/usb/musb/musb_cppi41.c
>> index 1636385..8fdbc17 100644
>> --- a/drivers/usb/musb/musb_cppi41.c
>> +++ b/drivers/usb/musb/musb_cppi41.c
>> @@ -547,6 +547,10 @@ static int cppi41_dma_channel_abort(struct
>> dma_channel *channel)
>>          }
>>      }
>>
>> +    /* DA8xx Advisory 2.3.27: wait 250 ms before to start the
>> teardown */
>> +    if (musb->io.quirks & MUSB_DA8XX)
>> +        mdelay(250);
> 
>    This is a horrible workaround, not even msleep()...
Indeed, that's a bad workaround but have not found a better one.
cppi41_dma_channel_abort() is called from atomic context,
so we can't use msleep().
And update the musb driver to call cppi41_dma_channel_abort()
from process context would require too many changes.

Best Regards,
Alexandre
> 
> [...]
> 
> MBR, Sergei
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
