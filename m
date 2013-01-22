From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 2/6] usb: otg: utils: add facilities in phy lib to
 support multiple PHYs of same type
Date: Tue, 22 Jan 2013 19:43:44 +0530
Message-ID: <50FE9E98.3080905@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com>
 <1358848694-20145-3-git-send-email-kishon@ti.com> <50FE9D1E.3010800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50FE9D1E.3010800-l0cyMroinI0@public.gmane.org>
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
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 22 January 2013 07:37 PM, Roger Quadros wrote:
> On 01/22/2013 11:58 AM, Kishon Vijay Abraham I wrote:
>> In order to add support for multipe PHY's of the same type, new API's
>> for adding PHY and getting PHY has been added. Now the binding
>> information for the PHY and controller should be done in platform file
>> using usb_bind_phy API. And for getting a PHY, the device pointer of the
>> USB controller and an index should be passed. Based on the binding
>> information that is added in the platform file, usb_get_phy_dev will return the
>> appropriate PHY.
>> Already existing API's to add and get phy by type is not removed. These
>> API's are deprecated and will be removed once all the platforms start to
>> use the new API.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/usb/otg/otg.c   |  114 ++++++++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/usb/phy.h |   13 ++++++
>>   2 files changed, 126 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
>> index 492ba2f..1f30b22 100644
>> --- a/drivers/usb/otg/otg.c
>> +++ b/drivers/usb/otg/otg.c
>> @@ -36,6 +36,20 @@ static struct usb_phy *__usb_find_phy(struct list_head *list,
>>   	return ERR_PTR(-ENODEV);
>>   }
>>
>> +static struct usb_phy *__usb_find_phy_dev(struct device *dev,
>> +	struct list_head *list, u8 index)
>> +{
>> +	struct usb_phy_bind *phy_bind = NULL;
>> +
>> +	list_for_each_entry(phy_bind, list, list) {
>> +		if (!(strcmp(phy_bind->dev_name, dev_name(dev))) &&
>> +				phy_bind->index == index)
>> +			return phy_bind->phy;
>
> If the PHY driver has not yet called usb_add_phy_dev() (e.g. driver not yet loaeded)
> then this will return NULL.
>
>> +	}
>> +
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>>   static void devm_usb_phy_release(struct device *dev, void *res)
>>   {
>>   	struct usb_phy *phy = *(struct usb_phy **)res;
>> @@ -112,6 +126,69 @@ err0:
>>   EXPORT_SYMBOL(usb_get_phy);
>>
>>   /**
>> + * usb_get_phy_dev - find the USB PHY
>> + * @dev - device that requests this phy
>> + * @index - the index of the phy
>> + *
>> + * Returns the phy driver, after getting a refcount to it; or
>> + * -ENODEV if there is no such phy.  The caller is responsible for
>> + * calling usb_put_phy() to release that count.
>> + *
>> + * For use by USB host and peripheral drivers.
>> + */
>> +struct usb_phy *usb_get_phy_dev(struct device *dev, u8 index)
>> +{
>> +	struct usb_phy	*phy = NULL;
>> +	unsigned long	flags;
>> +
>> +	spin_lock_irqsave(&phy_lock, flags);
>> +
>> +	phy = __usb_find_phy_dev(dev, &phy_bind_list, index);
>> +	if (IS_ERR(phy)) {
>> +		pr_err("unable to find transceiver\n");
>> +		goto err0;
>> +	}
>
> Since NULL is not IS_ERR(), you will do a NULL pointer reference below.
>
> In such cases we would want to use the deferred probe mechanism. So should we return
> -EPROBE_DEFER?

Good catch. I'll update the patch.

Thanks
Kishon
