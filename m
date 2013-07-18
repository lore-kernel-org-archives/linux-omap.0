From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Thu, 18 Jul 2013 14:29:52 +0530
Message-ID: <51E7AE88.3050007@ti.com>
References: <1374129984-765-1-git-send-email-kishon@ti.com>
 <1374129984-765-2-git-send-email-kishon@ti.com>
 <20130718072004.GA16720@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130718072004.GA16720-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 18 July 2013 12:50 PM, Greg KH wrote:
> On Thu, Jul 18, 2013 at 12:16:10PM +0530, Kishon Vijay Abraham I wrote:
>> +struct phy_provider *__of_phy_provider_register(struct device *dev,
>> +	struct module *owner, struct phy * (*of_xlate)(struct device *dev,
>> +	struct of_phandle_args *args));
>> +struct phy_provider *__devm_of_phy_provider_register(struct device *dev,
>> +	struct module *owner, struct phy * (*of_xlate)(struct device *dev,
>> +	struct of_phandle_args *args))
>> +
>> +__of_phy_provider_register and __devm_of_phy_provider_register can be used to
>> +register the phy_provider and it takes device, owner and of_xlate as
>> +arguments. For the dt boot case, all PHY providers should use one of the above
>> +2 APIs to register the PHY provider.
> 
> Why do you have __ for the prefix of a public function?  Is that really
> the way that OF handles this type of thing?

I have a macro of_phy_provider_register/devm_of_phy_provider_register that
calls these functions and should be used by the PHY drivers. Probably I should
make a mention of it in the Documentation.
> 
>> --- /dev/null
>> +++ b/drivers/phy/Kconfig
>> @@ -0,0 +1,13 @@
>> +#
>> +# PHY
>> +#
>> +
>> +menuconfig GENERIC_PHY
>> +	tristate "PHY Subsystem"
>> +	help
>> +	  Generic PHY support.
>> +
>> +	  This framework is designed to provide a generic interface for PHY
>> +	  devices present in the kernel. This layer will have the generic
>> +	  API by which phy drivers can create PHY using the phy framework and
>> +	  phy users can obtain reference to the PHY.
> 
> Again, please reverse this.  The drivers that use it should select it,
> not depend on it, which will then enable this option.  I will never know
> if I need to enable it, and based on your follow-on patches, if I don't,
> drivers that were working just fine, now disappeared from my build,
> which isn't nice, and a pain to notice and fix up.

ok.
> 
>> +/**
>> + * phy_create() - create a new phy
>> + * @dev: device that is creating the new phy
>> + * @id: id of the phy
>> + * @ops: function pointers for performing phy operations
>> + * @label: label given to the phy
>> + *
>> + * Called to create a phy using phy framework.
>> + */
>> +struct phy *phy_create(struct device *dev, u8 id, const struct phy_ops *ops,
>> +	const char *label)
>> +{
>> +	int ret;
>> +	struct phy *phy;
>> +
>> +	if (!dev) {
>> +		dev_WARN(dev, "no device provided for PHY\n");
>> +		ret = -EINVAL;
>> +		goto err0;
>> +	}
>> +
>> +	phy = kzalloc(sizeof(*phy), GFP_KERNEL);
>> +	if (!phy) {
>> +		ret = -ENOMEM;
>> +		goto err0;
>> +	}
>> +
>> +	device_initialize(&phy->dev);
>> +	mutex_init(&phy->mutex);
>> +
>> +	phy->dev.class = phy_class;
>> +	phy->dev.parent = dev;
>> +	phy->dev.of_node = dev->of_node;
>> +	phy->id = id;
>> +	phy->ops = ops;
>> +	phy->label = kstrdup(label, GFP_KERNEL);
>> +
>> +	ret = dev_set_name(&phy->dev, "%s.%d", dev_name(dev), id);
> 
> Your naming is odd, no "phy" anywhere in it?  You rely on the sender to
> never send a duplicate name.id pair?  Why not create your own ids based
> on the number of phys in the system, like almost all other classes and
> subsystems do?

hmm.. some PHY drivers use the id they provide to perform some of their
internal operation as in [1] (This is used only if a single PHY provider
implements multiple PHYS). Probably I'll add an option like PLATFORM_DEVID_AUTO
to give the PHY drivers an option to use auto id.

[1] ->
http://archive.arm.linux.org.uk/lurker/message/20130628.134308.4a8f7668.ca.html
> 
>> +static inline int phy_pm_runtime_get(struct phy *phy)
>> +{
>> +	if (WARN(IS_ERR(phy), "Invalid PHY reference\n"))
>> +		return -EINVAL;
> 
> Why would phy ever not be valid and a error pointer?  And why dump the
> stack if that happens, that seems really extreme.

hmm.. there might be cases where the same controller in one soc needs PHY
control and in some other soc does not need PHY control. In such cases, we
might get error pointer here.
I'll change WARN to dev_err.
> 
>> +
>> +	if (!pm_runtime_enabled(&phy->dev))
>> +		return -ENOTSUPP;
>> +
>> +	return pm_runtime_get(&phy->dev);
>> +}
> 
> This, and the other inline functions in this .h file seem huge, why are
> they inline and not in the .c file?  There's no speed issues, and it
> should save space overall in the .c file.  Please move them.

ok
> 
> 
>> +static inline int phy_init(struct phy *phy)
>> +{
>> +	int ret;
>> +
>> +	ret = phy_pm_runtime_get_sync(phy);
>> +	if (ret < 0 && ret != -ENOTSUPP)
>> +		return ret;
>> +
>> +	mutex_lock(&phy->mutex);
>> +	if (phy->init_count++ == 0 && phy->ops->init) {
>> +		ret = phy->ops->init(phy);
>> +		if (ret < 0) {
>> +			dev_err(&phy->dev, "phy init failed --> %d\n", ret);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&phy->mutex);
>> +	phy_pm_runtime_put(phy);
>> +	return ret;
>> +}
>> +
>> +static inline int phy_exit(struct phy *phy)
>> +{
>> +	int ret;
>> +
>> +	ret = phy_pm_runtime_get_sync(phy);
>> +	if (ret < 0 && ret != -ENOTSUPP)
>> +		return ret;
>> +
>> +	mutex_lock(&phy->mutex);
>> +	if (--phy->init_count == 0 && phy->ops->exit) {
>> +		ret = phy->ops->exit(phy);
>> +		if (ret < 0) {
>> +			dev_err(&phy->dev, "phy exit failed --> %d\n", ret);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&phy->mutex);
>> +	phy_pm_runtime_put(phy);
>> +	return ret;
>> +}
>> +
>> +static inline int phy_power_on(struct phy *phy)
>> +{
>> +	int ret = -ENOTSUPP;
>> +
>> +	ret = phy_pm_runtime_get_sync(phy);
>> +	if (ret < 0 && ret != -ENOTSUPP)
>> +		return ret;
>> +
>> +	mutex_lock(&phy->mutex);
>> +	if (phy->power_count++ == 0 && phy->ops->power_on) {
>> +		ret = phy->ops->power_on(phy);
>> +		if (ret < 0) {
>> +			dev_err(&phy->dev, "phy poweron failed --> %d\n", ret);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&phy->mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static inline int phy_power_off(struct phy *phy)
>> +{
>> +	int ret = -ENOTSUPP;
>> +
>> +	mutex_lock(&phy->mutex);
>> +	if (--phy->power_count == 0 && phy->ops->power_off) {
>> +		ret =  phy->ops->power_off(phy);
>> +		if (ret < 0) {
>> +			dev_err(&phy->dev, "phy poweroff failed --> %d\n", ret);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&phy->mutex);
>> +	phy_pm_runtime_put(phy);
>> +
>> +	return ret;
>> +}
> 
> Look at those 3 functions, they are all "real" and not an inline
> function at all, please move them.

Alright.

Thanks
Kishon
