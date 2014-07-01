From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] phy: omap-usb2: Manage PHY 3.3V supply regulator
Date: Tue, 1 Jul 2014 16:07:04 +0530
Message-ID: <53B28F50.6060409@ti.com>
References: <1404126038-19974-1-git-send-email-rogerq@ti.com> <1404126038-19974-2-git-send-email-rogerq@ti.com> <53B285DC.8070102@ti.com> <53B289B1.6020705@ti.com> <53B28B84.9080404@ti.com> <53B28CB5.1070306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53B28CB5.1070306-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: nm-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 01 July 2014 03:55 PM, Roger Quadros wrote:
> On 07/01/2014 01:20 PM, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Tuesday 01 July 2014 03:43 PM, Roger Quadros wrote:
>>> On 07/01/2014 12:56 PM, Kishon Vijay Abraham I wrote:
>>>> Hi Roger,
>>>>
>>>> On Monday 30 June 2014 04:30 PM, Roger Quadros wrote:
>>>>> On some SoCs e.g. J6 the 3.3V supply to the USB2 PHY can be
>>>>> powered down when the PHY is not in use. Add regulator
>>>>> management code to control this power line.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>>> ---
>>>>>  drivers/phy/phy-omap-usb2.c  | 25 +++++++++++++++++++++++++
>>>>>  include/linux/phy/omap_usb.h |  1 +
>>>>>  2 files changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
>>>>> index 7007c11..2afc79c 100644
>>>>> --- a/drivers/phy/phy-omap-usb2.c
>>>>> +++ b/drivers/phy/phy-omap-usb2.c
>>>>> @@ -30,6 +30,7 @@
>>>>>  #include <linux/phy/omap_control_phy.h>
>>>>>  #include <linux/phy/phy.h>
>>>>>  #include <linux/of_platform.h>
>>>>> +#include <linux/regulator/consumer.h>
>>>>>  
>>>>>  #define USB2PHY_DISCON_BYP_LATCH (1 << 31)
>>>>>  #define USB2PHY_ANA_CONFIG1 0x4c
>>>>> @@ -107,6 +108,14 @@ static int omap_usb_power_off(struct phy *x)
>>>>>  
>>>>>  	omap_control_phy_power(phy->control_dev, 0);
>>>>>  
>>>>> +	if (phy->pwr) {
>>>>> +		int ret;
>>>>> +
>>>>> +		ret = regulator_disable(phy->pwr);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>>>> +
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> @@ -114,6 +123,14 @@ static int omap_usb_power_on(struct phy *x)
>>>>>  {
>>>>>  	struct omap_usb *phy = phy_get_drvdata(x);
>>>>>  
>>>>> +	if (phy->pwr) {
>>>>> +		int ret;
>>>>> +
>>>>> +		ret = regulator_enable(phy->pwr);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>>>> +
>>>>
>>>> Shouldn't we do this in phy_power_on/phy_power_off in phy-core?
>>>
>>> I thought about that earlier, but could not find a way to defer probing if the regulator is not-yet probed.
>>> Any clues how it could be done in phy-core?
>>
>> We can try to do regulator_get in phy_create and return EPROBE_DEFER if the
>> regulator_get returns EPROBE_DEFER no?
> 
> Yes indeed, we can. I missed the phy_create() and was only looking at phy_init() and phy_power_*() :P.
> I'll post a v2 soon.

cool. Thanks :-)

-Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
