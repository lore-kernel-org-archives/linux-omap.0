From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: dwc3: dwc3-omap: return -EPROBE_DEFER if probe
 has not yet executed
Date: Tue, 5 Mar 2013 20:31:58 +0530
Message-ID: <513608E6.3010502@ti.com>
References: <1362493320-13913-1-git-send-email-kishon@ti.com>
 <1362493320-13913-3-git-send-email-kishon@ti.com>
 <20130305145645.GG12123@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130305145645.GG12123-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 05 March 2013 08:26 PM, Felipe Balbi wrote:
> On Tue, Mar 05, 2013 at 07:51:58PM +0530, Kishon Vijay Abraham I wrote:
>> return -EPROBE_DEFER from dwc3_omap_mailbox in dwc3-omap.c, if the probe of
>> dwc3-omap has not yet been executed or failed.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/usb/dwc3/dwc3-omap.c  |    7 +++++--
>>   include/linux/usb/dwc3-omap.h |    6 +++---
>>   2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>> index 19c6e72..9428f4e 100644
>> --- a/drivers/usb/dwc3/dwc3-omap.c
>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>> @@ -138,11 +138,14 @@ static inline void dwc3_omap_writel(void __iomem *base, u32 offset, u32 value)
>>   	writel(value, base + offset);
>>   }
>>
>> -void dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>> +int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>>   {
>>   	u32			val;
>>   	struct dwc3_omap	*omap = _omap;
>>
>> +	if (!omap)
>> +		return -EPROBE_DEFER;
>> +
>>   	switch (status) {
>>   	case OMAP_DWC3_ID_GROUND:
>>   		dev_dbg(omap->dev, "ID GND\n");
>> @@ -185,7 +188,7 @@ void dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>>   		dev_dbg(omap->dev, "ID float\n");
>>   	}
>>
>> -	return;
>> +	return IRQ_HANDLED;
>
> IRQ_HANDLED ????

Actually I did it that way since palmas_vbus_wakeup_irq can directly 
return the return value from dwc3_omap_mailbox. If this seems hacky to 
you, I'll change it.

Thanks
Kishon
