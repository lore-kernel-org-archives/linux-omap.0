From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 6/6] USB: MUSB: OMAP: get PHY by phandle for dt boot
Date: Tue, 22 Jan 2013 20:07:59 +0530
Message-ID: <50FEA447.1090701@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com> <1358848694-20145-7-git-send-email-kishon@ti.com> <50FE9F5C.2010501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50FE9F5C.2010501-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 22 January 2013 07:47 PM, Roger Quadros wrote:
> On 01/22/2013 11:58 AM, Kishon Vijay Abraham I wrote:
>> The OMAP glue has been modified to get PHY by phandle for dt boot.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/usb/musb/omap2430.c |    7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>> index 1a8cf6d..e43faeb 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -345,7 +345,12 @@ static int omap2430_musb_init(struct musb *musb)
>>   	 * up through ULPI.  TWL4030-family PMICs include one,
>>   	 * which needs a driver, drivers aren't always needed.
>>   	 */
>> -	musb->xceiv = devm_usb_get_phy_dev(dev, 0);
>> +	if (dev->parent->of_node)
>> +		musb->xceiv = devm_usb_get_phy_by_phandle(dev->parent,
>> +		    "usb_phy", 0);
>> +	else
>> +		musb->xceiv = devm_usb_get_phy_dev(dev, 0);
>> +
>>   	if (IS_ERR_OR_NULL(musb->xceiv)) {
>>   		pr_err("HS USB OTG: no transceiver configured\n");
>>   		return -ENODEV;
>
> This will not work with PHY driver as a module. You need to use deferred probing mechanism here
> after you have addressed my comment in patch 2 and also devm_usb_get_phy_by_phandle()

IIUC, even using -EPROBE_DEFER might not help if we are making the PHY 
driver as module, since the kernel will try to probe only till the 
prompt comes.

And having -EPROBE_DEFER instead of -ENODEV might also not help since, 
the gadget driver wont be able to bind to UDC (usb_gadget_probe_driver 
will fail).

A lot of things need to be changed before we change to -EPROBE_DEFER IMO.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
