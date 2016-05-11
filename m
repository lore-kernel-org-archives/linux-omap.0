From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 09/14] usb: of: add an API to get OTG device from USB
 controller node
Date: Wed, 11 May 2016 14:04:12 +0300
Message-ID: <573311AC.8040800@ti.com>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
 <1462191537-10314-10-git-send-email-rogerq@ti.com>
 <20160511084057.GG16910@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160511084057.GG16910@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/05/16 11:40, Peter Chen wrote:
> On Mon, May 02, 2016 at 03:18:52PM +0300, Roger Quadros wrote:
>> The OTG controller and the USB controller an be linked via the
> 
> Typo?

Will fix.

cheers,
-roger

> 
> Others are ok for me.
> 
> Acked-by: Peter Chen <peter.chen@nxp.com>
> 
>> 'otg-controller' property in the USB controller's device node.
>>
>> of_usb_get_otg() can be used to get the OTG controller device
>> from the USB controller's device node.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  Documentation/devicetree/bindings/usb/generic.txt |  3 +++
>>  drivers/usb/common/common.c                       | 27 +++++++++++++++++++++++
>>  include/linux/usb/of.h                            |  9 ++++++++
>>  3 files changed, 39 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
>> index bba8257..f6866c1 100644
>> --- a/Documentation/devicetree/bindings/usb/generic.txt
>> +++ b/Documentation/devicetree/bindings/usb/generic.txt
>> @@ -24,6 +24,9 @@ Optional properties:
>>  			optional for OTG device.
>>   - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
>>  			optional for OTG device.
>> + - otg-controller: phandle to otg controller. Host or gadget controllers can
>> +			contain this property to link it to a particular OTG
>> +			controller.
>>  
>>  This is an attribute to a USB controller such as:
>>  
>> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
>> index e3d0161..d7ec471 100644
>> --- a/drivers/usb/common/common.c
>> +++ b/drivers/usb/common/common.c
>> @@ -238,6 +238,33 @@ int of_usb_update_otg_caps(struct device_node *np,
>>  }
>>  EXPORT_SYMBOL_GPL(of_usb_update_otg_caps);
>>  
>> +#ifdef CONFIG_USB_OTG
>> +/**
>> + * of_usb_get_otg - get the OTG controller linked to the USB controller
>> + * @np: Pointer to the device_node of the USB controller
>> + * @otg_caps: Pointer to the target usb_otg_caps to be set
>> + *
>> + * Returns the OTG controller device or NULL on error.
>> + */
>> +struct device *of_usb_get_otg(struct device_node *np)
>> +{
>> +	struct device_node *otg_np;
>> +	struct platform_device *pdev;
>> +
>> +	otg_np = of_parse_phandle(np, "otg-controller", 0);
>> +	if (!otg_np)
>> +		return NULL;
>> +
>> +	pdev = of_find_device_by_node(otg_np);
>> +	of_node_put(otg_np);
>> +	if (!pdev)
>> +		return NULL;
>> +
>> +	return &pdev->dev;
>> +}
>> +EXPORT_SYMBOL_GPL(of_usb_get_otg);
>> +#endif
>> +
>>  #endif
>>  
>>  MODULE_LICENSE("GPL");
>> diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
>> index de3237f..499a4e8 100644
>> --- a/include/linux/usb/of.h
>> +++ b/include/linux/usb/of.h
>> @@ -40,6 +40,15 @@ static inline struct device_node *usb_of_get_child_node
>>  }
>>  #endif
>>  
>> +#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_OTG)
>> +struct device *of_usb_get_otg(struct device_node *np);
>> +#else
>> +static inline struct device *of_usb_get_otg(struct device_node *np)
>> +{
>> +	return NULL;
>> +}
>> +#endif
>> +
>>  #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_SUPPORT)
>>  enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np);
>>  #else
>> -- 
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
