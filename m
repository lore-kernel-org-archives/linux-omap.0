From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/6] usb: dwc3-omap: use runtime API's to enable clocks
Date: Fri, 28 Sep 2012 19:01:30 +0530
Message-ID: <CAAe_U6Js7jA4qhT7xGmhNHKLBHt=rnN2=MK-tT3QCmVTktQgtQ@mail.gmail.com>
References: <1348836795-4783-1-git-send-email-kishon@ti.com>
	<1348836795-4783-3-git-send-email-kishon@ti.com>
	<20120928125840.GL31006@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120928125840.GL31006-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 28, 2012 at 6:28 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Fri, Sep 28, 2012 at 06:23:11PM +0530, Kishon Vijay Abraham I wrote:
>> Before accessing any register, runtime API's should be invoked to enable
>> the clocks. runtime API's are added here to prevent abort during register
>> access.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/usb/dwc3/dwc3-omap.c |   10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>> index 34578de..6a0e17f 100644
>> --- a/drivers/usb/dwc3/dwc3-omap.c
>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>> @@ -43,6 +43,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/platform_data/dwc3-omap.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/ioport.h>
>>  #include <linux/io.h>
>> @@ -281,6 +282,13 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
>>       omap->irq       = irq;
>>       omap->base      = base;
>>
>> +     pm_runtime_enable(dev);
>> +     ret = pm_runtime_get_sync(dev);
>> +     if (ret < 0) {
>> +             dev_err(dev, "get_sync failed with err %d\n", ret);
>> +                     goto err1;
>> +     }
>> +
>>       reg = dwc3_omap_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
>>
>>       utmi_mode = of_get_property(node, "utmi-mode", &size);
>> @@ -354,6 +362,8 @@ err1:
>>  static int __devexit dwc3_omap_remove(struct platform_device *pdev)
>>  {
>>       device_for_each_child(&pdev->dev, NULL, dwc3_remove_core);
>> +     pm_runtime_put(&pdev->dev);
>> +     pm_runtime_disable(&pdev->dev);
>
> You're going to disable pm_runtime here, so it's better to use
> pm_runtime_put_sync(), I guess ??

sure. Will post a patch fixing it.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
