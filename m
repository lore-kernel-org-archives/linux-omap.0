From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 07/11] dt/bindings: da8xx-usb: Add binding for the cppi41
 dma controller
Date: Tue, 10 Jan 2017 11:37:39 +0100
Message-ID: <55e3feca-58fc-d56a-74f5-08fa10c45312@baylibre.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
 <20170109160656.3470-8-abailon@baylibre.com>
 <6ae72fe4-ddb7-4dfc-8c8c-29b63636171b@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6ae72fe4-ddb7-4dfc-8c8c-29b63636171b-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello,

On 01/09/2017 07:41 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 01/09/2017 07:06 PM, Alexandre Bailon wrote:
> 
>> DT binding for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx cppi41 dma controller.
> 
>    It's called CPPI 4.1, not cppi41.
>    Let me introduce myself: I was the author of the 1st CPPI 4.1 drivers
> (never merged).
> 
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>  .../devicetree/bindings/usb/da8xx-usb.txt          | 39
>> ++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
>> b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
>> index ccb844a..2a4d737 100644
>> --- a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
>> +++ b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
>> @@ -18,10 +18,26 @@ Required properties:
> [...]
>>  Optional properties:
>>  ~~~~~~~~~~~~~~~~~~~~
>>   - vbus-supply: Phandle to a regulator providing the USB bus power.
>>
>> +DMA
>> +~~~
>> +- compatible: ti,da8xx-cppi41
>> +- reg: offset and length of the following register spaces: USBSS, USB
> 
>    I don't understand what you mean by USBSS and how it's related to
> CPPI 4.1.
I have kept the terminology used in the CPPI 4.1 driver.
USBSS is how the MUSB glue is named in AM335x datasheet.
The CPPI 4.1 driver need to access to few of this registers.
> 
>> +  CPPI DMA Controller, USB CPPI DMA Scheduler, USB Queue Manager
> 
>    I'd drop "USB" everywhere, the DMAC scheduler and queue manager are
> not a part of any USB logic.
Will do it.
> 
>> +- reg-names: glue, controller, scheduler, queuemgr
> 
>    Quoted, maybe?
> 
>> +- #dma-cells: should be set to 2. The first number represents the
>> +  endpoint number (0 … 3 for endpoints 1 … 4).
> 
>    Not sure why you need EPs here. Is that required by the DMA driver?
> The DMA controller operates with channels...
I have taken this from am335x-usb bindings and I kept it as is because
I don't think that's wrong.
I agree we should use DMA terminology but actually the CPPI 4.1 is only
used by USB in DA8xx (share the same clock, the same irq, etc).
In the case of DA8xx, I'm not sure that would make things more clear.

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
