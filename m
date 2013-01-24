From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 4/6] drivers: usb: musb: omap: make use of the new
 PHY lib APIs
Date: Fri, 25 Jan 2013 00:28:43 +0530
Message-ID: <51018463.4040908@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com> <1358848694-20145-5-git-send-email-kishon@ti.com> <50FE9DA6.4030507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50FE9DA6.4030507-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 22 January 2013 07:39 PM, Roger Quadros wrote:
> On 01/22/2013 11:58 AM, Kishon Vijay Abraham I wrote:
>> New PHY lib APIs like usb_add_phy_dev() and devm_usb_get_phy_dev() are
>> used in MUSB (OMAP), in order to make use of the binding information
>> provided in the board file (of OMAP platforms).
>> All the platforms should be modified similar to this to add and get the
>> PHY.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/usb/musb/omap2430.c   |    2 +-
>>   drivers/usb/otg/twl4030-usb.c |    3 ++-
>>   drivers/usb/phy/omap-usb2.c   |    3 ++-
>>   3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>> index bf6cfe0..1a8cf6d 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -345,7 +345,7 @@ static int omap2430_musb_init(struct musb *musb)
>>   	 * up through ULPI.  TWL4030-family PMICs include one,
>>   	 * which needs a driver, drivers aren't always needed.
>>   	 */
>> -	musb->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
>> +	musb->xceiv = devm_usb_get_phy_dev(dev, 0);
>>   	if (IS_ERR_OR_NULL(musb->xceiv)) {
>>   		pr_err("HS USB OTG: no transceiver configured\n");
>>   		return -ENODEV;
>> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
>> index 0a70193..a994715 100644
>> --- a/drivers/usb/otg/twl4030-usb.c
>> +++ b/drivers/usb/otg/twl4030-usb.c
>> @@ -610,6 +610,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
>>   	twl->phy.dev		= twl->dev;
>>   	twl->phy.label		= "twl4030";
>>   	twl->phy.otg		= otg;
>> +	twl->phy.type		= USB_PHY_TYPE_USB2;
>
> What is the need to set phy.type? I think this should be deprecated along with the old API.

The *type* field as such is not deprecated. Adding and getting a PHY 
using *type* is deprecated.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
