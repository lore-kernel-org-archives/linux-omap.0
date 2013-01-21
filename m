From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 5/6] usb: otg: add device tree support to otg library
Date: Mon, 21 Jan 2013 19:04:45 +0530
Message-ID: <50FD43F5.1020208@ti.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-6-git-send-email-kishon@ti.com> <50FD40D1.8020405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50FD40D1.8020405-l0cyMroinI0@public.gmane.org>
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
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 21 January 2013 06:51 PM, Roger Quadros wrote:
> On 01/16/2013 05:01 PM, Kishon Vijay Abraham I wrote:
>> Added an API devm_usb_get_phy_by_phandle(), to get usb phy by passing a
>> device node phandle value. This function will return a pointer to
>> the phy on success, -EPROBE_DEFER if there is a device_node for the phandle,
>> but the phy has not been added, or a ERR_PTR() otherwise.
>>
>> Cc: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/usb/otg/otg.c   |   77 +++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/usb/phy.h |    8 +++++
>>   2 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
>> index dbf2043..e9799bb 100644
>> --- a/drivers/usb/otg/otg.c
>> +++ b/drivers/usb/otg/otg.c
>> @@ -13,7 +13,9 @@
>>   #include <linux/export.h>
>>   #include <linux/err.h>
>>   #include <linux/device.h>
>> +#include <linux/module.h>
>>   #include <linux/slab.h>
>> +#include <linux/of.h>
>>
>>   #include <linux/usb/otg.h>
>>
>> @@ -34,6 +36,20 @@ static struct usb_phy *__usb_find_phy(struct device *dev, u8 index)
>>   	return ERR_PTR(-ENODEV);
>>   }
>>
>> +static struct usb_phy *__of_usb_find_phy(struct device_node *node)
>> +{
>> +	struct usb_phy  *phy;
>> +
>> +	list_for_each_entry(phy, &phy_list, head) {
>> +		if (node != phy->dev->of_node)
>> +			continue;
>> +
>> +		return phy;
>> +	}
>> +
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>>   static void devm_usb_phy_release(struct device *dev, void *res)
>>   {
>>   	struct usb_phy *phy = *(struct usb_phy **)res;
>> @@ -109,6 +125,67 @@ err0:
>>   }
>>   EXPORT_SYMBOL(usb_get_phy);
>>
>> + /**
>> + * devm_usb_get_phy_by_phandle - find the USB PHY by phandle
>> + * @dev - device that requests this phy
>> + * @phandle - name of the property holding the phy phandle value
>> + * @index - the index of the phy
>> + *
>> + * Returns the phy driver associated with the given phandle value,
>> + * after getting a refcount to it, -ENODEV if there is no such phy or
>> + * -EPROBE_DEFER if there is a phandle to the phy, but the device is
>> + * not yet loaded. While at that, it also associates the device with
>> + * the phy using devres. On driver detach, release function is invoked
>> + * on the devres data, then, devres data is freed.
>> + *
>> + * For use by USB host and peripheral drivers.
>> + */
>> +struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
>> +	const char *phandle, u8 index)
>> +{
>> +	struct usb_phy	*phy = NULL, **ptr;
>> +	unsigned long	flags;
>> +	struct device_node *node;
>> +
>> +	if (!dev->of_node) {
>> +		dev_dbg(dev, "device does not have a device node entry\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	node = of_parse_phandle(dev->of_node, phandle, index);
>> +	if (!node) {
>> +		dev_dbg(dev, "failed to get %s phandle in %s node\n", phandle,
>> +			dev->of_node->full_name);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	ptr = devres_alloc(devm_usb_phy_release, sizeof(*ptr), GFP_KERNEL);
>> +	if (!ptr) {
>> +		dev_dbg(dev, "failed to allocate memory for devres\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>
> I fail to understand why you need ptr at all and why do devres_alloc()
> for it.

Thats how we create a "managed device resource". You can have a look at 
Documentation/driver-model/devres.txt and drivers/base/devres.c.

I'm not sure if that is what you are looking for :-P

Thanks
Kishon
