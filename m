From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v7 1/9] drivers: phy: add generic PHY framework
Date: Thu, 20 Jun 2013 10:58:09 +0530
Message-ID: <51C292E9.2010904@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-2-git-send-email-kishon@ti.com>
 <51C1D30D.1050907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51C1D30D.1050907@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: mchehab@redhat.com, linux-doc@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, swarren@nvidia.com, grant.likely@linaro.org, cesarb@cesarb.net, arnd@arndb.de, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, rob.herring@calxeda.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, santosh.shilimkar@ti.com, rob@landley.net, benoit.cousson@linaro.org, akpm@linux-foundation.org, shawn.guo@linaro.org, davem@davemloft.net
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 19 June 2013 09:19 PM, Sylwester Nawrocki wrote:
> Hi,
>
> On 06/13/2013 10:43 AM, Kishon Vijay Abraham I wrote:
>> +/**
>> + * phy_create() - create a new phy
>> + * @dev: device that is creating the new phy
>> + * @id: id of the phy
>> + * @ops: function pointers for performing phy operations
>> + * @label: label given to the phy
>> + * @priv: private data from phy driver
>> + *
>> + * Called to create a phy using phy framework.
>> + */
>> +struct phy *phy_create(struct device *dev, u8 id, const struct phy_ops *ops,
>> +	const char *label, void *priv)
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
>> +
>> +	phy->dev.class = phy_class;
>> +	phy->dev.parent = dev;
>> +	phy->dev.of_node = dev->of_node;
>> +	phy->id = id;
>> +	phy->ops = ops;
>> +	phy->label = label;
>
> Perhaps we could make it:
>
> 	phy->label = kstrdup(label, GFP_KERNEL);
>
> and free the label in phy_destroy() ?

yeah.. Fixed.
>
> That way the users would't need to keep the label around. It might
> be useful when PHY provider generates the labels dynamically. I guess
> it is OK for PHY providers to hard code the labels and having the PHY
> user drivers passed labels in platform data ?

yeah. But the only concern here is there is no way to enforce the
labels are passed in platform data. The PHY user driver can also
hard code the labels while getting the reference to the PHY and we can
catch such cases only by review.

>
>> +	dev_set_drvdata(&phy->dev, priv);
>> +
>> +	ret = dev_set_name(&phy->dev, "%s.%d", dev_name(dev), id);
>> +	if (ret)
>> +		goto err1;
>> +
>> +	ret = device_add(&phy->dev);
>> +	if (ret)
>> +		goto err1;
>> +
>> +	if (pm_runtime_enabled(dev))
>> +		pm_runtime_enable(&phy->dev);
>> +
>> +	return phy;
>> +
>> +err1:
>> +	put_device(&phy->dev);
>> +	kfree(phy);
>> +
>> +err0:
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(phy_create);
>
>> +/**
>> + * phy_destroy() - destroy the phy
>> + * @phy: the phy to be destroyed
>> + *
>> + * Called to destroy the phy.
>> + */
>> +void phy_destroy(struct phy *phy)
>> +{
>> +	pm_runtime_disable(&phy->dev);
>> +	device_unregister(&phy->dev);
>
> Isn't kfree(phy); missing here ?

Not actually. Its done in phy_release (class's dev_release method)

Thanks
Kishon
