From: kishon <kishon@ti.com>
Subject: Re: [PATCH 2/4] usb: dwc3: dwc3-omap: return -EPROBE_DEFER if probe
 has not yet executed
Date: Tue, 5 Mar 2013 20:48:24 +0530
Message-ID: <51360CC0.9080108@ti.com>
References: <1362493320-13913-1-git-send-email-kishon@ti.com> <1362493320-13913-3-git-send-email-kishon@ti.com> <20130305145645.GG12123@arwen.pp.htv.fi> <513608E6.3010502@ti.com> <20130305150608.GI12123@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130305150608.GI12123@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, gregkh@linuxfoundation.org, s-guiriec@ti.com, gg@slimlogic.co.uk, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, ldewangan@nvidia.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 05 March 2013 08:36 PM, Felipe Balbi wrote:
> On Tue, Mar 05, 2013 at 08:31:58PM +0530, kishon wrote:
>> Hi,
>>
>> On Tuesday 05 March 2013 08:26 PM, Felipe Balbi wrote:
>>> On Tue, Mar 05, 2013 at 07:51:58PM +0530, Kishon Vijay Abraham I wrote:
>>>> return -EPROBE_DEFER from dwc3_omap_mailbox in dwc3-omap.c, if the probe of
>>>> dwc3-omap has not yet been executed or failed.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>   drivers/usb/dwc3/dwc3-omap.c  |    7 +++++--
>>>>   include/linux/usb/dwc3-omap.h |    6 +++---
>>>>   2 files changed, 8 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>>>> index 19c6e72..9428f4e 100644
>>>> --- a/drivers/usb/dwc3/dwc3-omap.c
>>>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>>>> @@ -138,11 +138,14 @@ static inline void dwc3_omap_writel(void __iomem *base, u32 offset, u32 value)
>>>>   	writel(value, base + offset);
>>>>   }
>>>>
>>>> -void dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>>>> +int dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>>>>   {
>>>>   	u32			val;
>>>>   	struct dwc3_omap	*omap = _omap;
>>>>
>>>> +	if (!omap)
>>>> +		return -EPROBE_DEFER;
>>>> +
>>>>   	switch (status) {
>>>>   	case OMAP_DWC3_ID_GROUND:
>>>>   		dev_dbg(omap->dev, "ID GND\n");
>>>> @@ -185,7 +188,7 @@ void dwc3_omap_mailbox(enum omap_dwc3_vbus_id_status status)
>>>>   		dev_dbg(omap->dev, "ID float\n");
>>>>   	}
>>>>
>>>> -	return;
>>>> +	return IRQ_HANDLED;
>>>
>>> IRQ_HANDLED ????
>>
>> Actually I did it that way since palmas_vbus_wakeup_irq can directly
>> return the return value from dwc3_omap_mailbox. If this seems hacky
>> to you, I'll change it.
>
> it does seem hacky :-) Try something like:
>
> ret = dwc3_omap_mailbox();
> if (ret)
> 	print_error();
>
> return IRQ_HANDLED;

hmm.. But there is one case where palmas_vbus_wakeup_irq should return 
EPROBE_DEFER. In the cold plug case, if palmas gets loaded before 
dwc3-omap, omap in dwc3_omap_mailbox will be NULL. So ideally palmas 
should be probed after dwc3-omap for this case. Returning IRQ_HANDLED or 
IRQ_NONE wont help here.

Thanks
Kishon




>

