From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/3] dt/bindings: da8xx-usb: Add binding for the CPPI
 4.1 DMA controller
Date: Wed, 18 Jan 2017 14:03:44 +0530
Message-ID: <710c724c-3831-e9d1-406b-76bdfed7b948@ti.com>
References: <20170117142016.11163-1-abailon@baylibre.com>
 <20170117142016.11163-2-abailon@baylibre.com>
 <aa9b6761-c8de-13ea-1a62-9810ad92a6d4@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <aa9b6761-c8de-13ea-1a62-9810ad92a6d4-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 17 January 2017 10:46 PM, Sergei Shtylyov wrote:
> On 01/17/2017 05:20 PM, Alexandre Bailon wrote:
> 
>> DT binding for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx cppi41 dma controller.
>>
>> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>  .../devicetree/bindings/usb/da8xx-usb.txt          | 42
>> ++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
>> b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
>> index ccb844a..aed3169 100644
>> --- a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
>> +++ b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
>> @@ -18,10 +18,26 @@ Required properties:
>>
>>   - phy-names: Should be "usb-phy"
>>
>> + - dmas: specifies the dma channels
>> +
>> + - dma-names: specifies the names of the channels. Use "rxN" for receive
>> +   and "txN" for transmit endpoints. N specifies the endpoint number.
>> +
>>  Optional properties:
>>  ~~~~~~~~~~~~~~~~~~~~
>>   - vbus-supply: Phandle to a regulator providing the USB bus power.
>>
>> +DMA
>> +~~~
>> +- compatible: ti,da8xx-cppi41
> 
>    Almost missed this -- wildcards in this property are forbidden.
> We should use "ti,da830-cppi41" as a least common denominator.

Documentation/devicetree/bindings/submitting-patches.txt states:

"
  5) The wildcard "<chip>" may be used in compatible strings, as in
     the following example:

         - compatible: Must contain '"nvidia,<chip>-pcie",
           "nvidia,tegra20-pcie"' where <chip> is tegra30, tegra132, ...
"

I take this to mean that using wildcards to denote an SoC family on
which the same IP is present is okay to do. With that understanding, I
think using ti,da8xx-cppi41 is fine too. Although I have no objections
against using the more specific ti,da830-cppi41

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
