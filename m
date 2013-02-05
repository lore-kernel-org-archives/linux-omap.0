From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 02/13] USB: phy: nop: Defer probe if device needs VCC/RESET
Date: Tue, 5 Feb 2013 10:44:05 +0200
Message-ID: <5110C655.3060305@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-3-git-send-email-rogerq@ti.com> <51109E95.3000307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35370 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024Ab3BEIoa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 03:44:30 -0500
In-Reply-To: <51109E95.3000307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon <kishon@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

On 02/05/2013 07:54 AM, kishon wrote:
> On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
>> Add 2 flags, needs_vcc and needs_reset to platform data.
>> If the flag is set and the regulator couldn't be found
>> then we bail out with -EPROBE_DEFER.
>>
>> For device tree boot we depend on presensce of vcc-supply/
>> reset-supply properties to decide if we should bail out
>> with -EPROBE_DEFER or just continue in case the regulator
>> can't be found.
>>
>> This is required for proper functionality in cases where the
>> regulator is needed but is probed later than the PHY device.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/usb/otg/nop-usb-xceiv.c   |    8 ++++++++
>>   include/linux/usb/nop-usb-xceiv.h |    4 ++++
>>   2 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
>> index adbb7ab..7860e7569 100644
>> --- a/drivers/usb/otg/nop-usb-xceiv.c
>> +++ b/drivers/usb/otg/nop-usb-xceiv.c
>> @@ -147,6 +147,10 @@ static void nop_xeiv_get_dt_pdata(struct device *dev,
>>
>>       if (!of_property_read_u32(node, "clock-frequency", &clk_rate))
>>           pdata->clk_rate = clk_rate;
>> +    if (of_property_read_bool(node, "vcc-supply"))
>> +        pdata->needs_vcc = true;
> This can be written as..
> pdata->needs_vcc = of_property_read_bool(node, "vcc-supply");

OK.

> 
>> +    if (of_property_read_bool(node, "reset-supply"))
>> +        pdata->needs_reset = true;
> same here..
>>   }
>>
>>   static int nop_usb_xceiv_probe(struct platform_device *pdev)
>> @@ -205,12 +209,16 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>>       if (IS_ERR(nop->vcc)) {
>>           dev_dbg(&pdev->dev, "Error getting vcc regulator: %ld\n",
>>                       PTR_ERR(nop->vcc));
>> +        if (pdata->needs_vcc)
>> +            return -EPROBE_DEFER;
>>       }
>>
>>       nop->reset = devm_regulator_get(&pdev->dev, "reset");
>>       if (IS_ERR(nop->reset)) {
>>           dev_dbg(&pdev->dev, "Error getting reset regulator: %ld\n",
>>                       PTR_ERR(nop->reset));
>> +        if (pdata->needs_reset)
>> +            return -EPROBE_DEFER;
>>       }
>>
>>       nop->dev        = &pdev->dev;
>> diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop-usb-xceiv.h
>> index 3265b61..148d351 100644
>> --- a/include/linux/usb/nop-usb-xceiv.h
>> +++ b/include/linux/usb/nop-usb-xceiv.h
>> @@ -6,6 +6,10 @@
>>   struct nop_usb_xceiv_platform_data {
>>       enum usb_phy_type type;
>>       unsigned long clk_rate;
>> +
>> +    /* if set fails with -EPROBE_DEFER if can't get regulator */
>> +    unsigned int needs_vcc:1;
>> +    unsigned int needs_reset:1;
> 
> how about u8 here?

Not sure. Bitfields are usually defined as unsigned int.

cheers,
-roger
