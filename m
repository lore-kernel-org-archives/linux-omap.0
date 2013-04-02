From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/6] drivers: phy: add generic PHY framework
Date: Tue, 2 Apr 2013 14:09:21 +0530
Message-ID: <515A9939.40406@ti.com>
References: <1364449408-9510-1-git-send-email-kishon@ti.com>
 <1364449408-9510-2-git-send-email-kishon@ti.com> <5159E157.6000800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5159E157.6000800-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 02 April 2013 01:04 AM, Sylwester Nawrocki wrote:
> Just couple minor comments...
>
> On 03/28/2013 06:43 AM, Kishon Vijay Abraham I wrote:
>> The PHY framework provides a set of APIs for the PHY drivers to
>> create/destroy a PHY and APIs for the PHY users to obtain a reference
>> to the
>> PHY with or without using phandle. To obtain a reference to the PHY
>> without
>> using phandle, the platform specfic intialization code (say from board
>> file)
>> should have already called phy_bind with the binding information. The
>> binding
>> information consists of phy's device name, phy user device name and an
>> index.
>> The index is used when the same phy user binds to mulitple phys.
>>
>> PHY drivers should create the PHY by passing phy_descriptor that has
>> describes the PHY (label, type etc..) and ops like init, exit,
>> suspend, resume,
>> poweron, shutdown.
>>
>> The documentation for the generic PHY framework is added in
>> Documentation/phy.txt and the documentation for the sysfs entry is added
>> in Documentation/ABI/testing/sysfs-class-phy and the documentation for
>> dt binding is can be found at
>> Documentation/devicetree/bindings/phy/phy-bindings.txt
>>
>> Signed-off-by: Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>
>> ---
> [...]
>> +/**
>> + * phy_put - release the PHY
>
> nit: According to kernel-doc documentation function names should have
> parentheses appended to the name. So it would need to be
>
> + * phy_put() - release the PHY
>
> in this case and it applies to multiple places elsewhere in this patch.

Will fix it.
>
>> + * @phy: the phy returned by phy_get()
>> + *
>> + * Releases a refcount the caller received from phy_get().
>> + */
>> +void phy_put(struct phy *phy)
>> +{
>> +    if (phy) {
>> +        module_put(phy->ops->owner);
>> +        put_device(&phy->dev);
>> +    }
>> +}
>> +EXPORT_SYMBOL_GPL(phy_put);
> [...]
>> +/**
>> + * devm_of_phy_get_byname - lookup and obtain a reference to a phy by
>> name
>> + * @dev: device that requests this phy
>> + * @string - the phy name as given in the dt data
>
> s/ -/:

Ok.
>
>> + *
>> + * Calls devm_of_phy_get (which associates the device with the phy
>> using devres
>> + * on successful phy get) and passes on the return value of
>> devm_of_phy_get.
>> + */
>> +struct phy *devm_of_phy_get_byname(struct device *dev, const char
>> *string)
>> +{
>> +    int index;
>> +
>> +    if (!dev->of_node) {
>> +        dev_dbg(dev, "device does not have a device node entry\n");
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
>> +    index = of_property_match_string(dev->of_node, "phy-names", string);
>> +
>> +    return devm_of_phy_get(dev, index);
>> +}
>> +EXPORT_SYMBOL_GPL(devm_of_phy_get_byname);
>> +
>> +/**
>> + * phy_get - lookup and obtain a reference to a phy.
>> + * @dev: device that requests this phy
>> + * @index: the index of the phy
>> + *
>> + * Returns the phy driver, after getting a refcount to it; or
>> + * -ENODEV if there is no such phy.  The caller is responsible for
>> + * calling phy_put() to release that count.
>> + */
>> +struct phy *phy_get(struct device *dev, int index)
>> +{
>> +    struct phy *phy = NULL;
>
> Unneeded initialization.
>
>> +    phy = phy_lookup(dev, index);
>> +    if (IS_ERR(phy)) {
>> +        dev_err(dev, "unable to find phy\n");
>> +        goto err0;
>
> Wouldn't it be better to just do:

Indeed.
>
>          return phy;
>> +    }
>> +
>> +    if (!try_module_get(phy->ops->owner)) {
>> +        phy = ERR_PTR(-EPROBE_DEFER);
>
> and
>          return ERR_PTR(-EPROBE_DEFER);
>
>> +        goto err0;
>
> and to drop this goto and the label below ?
>
>> +    }
>> +
>> +    get_device(&phy->dev);
>> +
>> +err0:
>> +    return phy;
>> +}
>> +EXPORT_SYMBOL_GPL(phy_get);
>
>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> new file mode 100644
>> index 0000000..0cb2298
>> --- /dev/null
>> +++ b/include/linux/phy/phy.h
>> @@ -0,0 +1,237 @@
>> +/*
>> + * phy.h -- generic phy header file
> [...]
>> +#ifndef __DRIVERS_PHY_H
>> +#define __DRIVERS_PHY_H
>> +
>> +#include<linux/err.h>
>> +#include<linux/of.h>
>> +
>> +struct phy
>
> I think you also need to add either
>
> #include <linux/device.h>
>
> or
>
> struct device;
>
> struct device * is used further in this file.

Ok.
>
>> +/**
>> + * struct phy_ops - set of function pointers for performing phy
>> operations
>> + * @init: operation to be performed for initializing phy
>> + * @exit: operation to be performed while exiting
>> + * @suspend: suspending the phy
>> + * @resume: resuming the phy
>
>> + * @poweron: powering on the phy
>> + * @shutdown: shutting down the phy
>
> Could these be named power_on/power_off ? Looks a bit more symmetric
> to me that way.

Ok. Will have it that way.

Thanks
Kishon
