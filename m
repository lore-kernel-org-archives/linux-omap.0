From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v7 1/9] drivers: phy: add generic PHY framework
Date: Wed, 19 Jun 2013 17:49:33 +0200
Message-ID: <51C1D30D.1050907@samsung.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1371113039-5784-2-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: grant.likely@linaro.org, tony@atomide.com, balbi@ti.com, arnd@arndb.de, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, linux@arm.linux.org.uk, benoit.cousson@linaro.org, mchehab@redhat.com, cesarb@cesarb.net, davem@davemloft.net, rnayak@ti.com, shawn.guo@linaro.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 06/13/2013 10:43 AM, Kishon Vijay Abraham I wrote:
> +/**
> + * phy_create() - create a new phy
> + * @dev: device that is creating the new phy
> + * @id: id of the phy
> + * @ops: function pointers for performing phy operations
> + * @label: label given to the phy
> + * @priv: private data from phy driver
> + *
> + * Called to create a phy using phy framework.
> + */
> +struct phy *phy_create(struct device *dev, u8 id, const struct phy_ops *ops,
> +	const char *label, void *priv)
> +{
> +	int ret;
> +	struct phy *phy;
> +
> +	if (!dev) {
> +		dev_WARN(dev, "no device provided for PHY\n");
> +		ret = -EINVAL;
> +		goto err0;
> +	}
> +
> +	phy = kzalloc(sizeof(*phy), GFP_KERNEL);
> +	if (!phy) {
> +		ret = -ENOMEM;
> +		goto err0;
> +	}
> +
> +	device_initialize(&phy->dev);
> +
> +	phy->dev.class = phy_class;
> +	phy->dev.parent = dev;
> +	phy->dev.of_node = dev->of_node;
> +	phy->id = id;
> +	phy->ops = ops;
> +	phy->label = label;

Perhaps we could make it:

	phy->label = kstrdup(label, GFP_KERNEL);

and free the label in phy_destroy() ?

That way the users would't need to keep the label around. It might
be useful when PHY provider generates the labels dynamically. I guess
it is OK for PHY providers to hard code the labels and having the PHY
user drivers passed labels in platform data ?

> +	dev_set_drvdata(&phy->dev, priv);
> +
> +	ret = dev_set_name(&phy->dev, "%s.%d", dev_name(dev), id);
> +	if (ret)
> +		goto err1;
> +
> +	ret = device_add(&phy->dev);
> +	if (ret)
> +		goto err1;
> +
> +	if (pm_runtime_enabled(dev))
> +		pm_runtime_enable(&phy->dev);
> +
> +	return phy;
> +
> +err1:
> +	put_device(&phy->dev);
> +	kfree(phy);
> +
> +err0:
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(phy_create);

> +/**
> + * phy_destroy() - destroy the phy
> + * @phy: the phy to be destroyed
> + *
> + * Called to destroy the phy.
> + */
> +void phy_destroy(struct phy *phy)
> +{
> +	pm_runtime_disable(&phy->dev);
> +	device_unregister(&phy->dev);

Isn't kfree(phy); missing here ?

> +}
> +EXPORT_SYMBOL_GPL(phy_destroy);

Thanks,
Sylwester
