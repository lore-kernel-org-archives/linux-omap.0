From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 5/6] usb: otg: add device tree support to otg library
Date: Tue, 22 Jan 2013 21:07:44 +0530
Message-ID: <50FEB248.5090701@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com>
 <1358848694-20145-6-git-send-email-kishon@ti.com>
 <20130122103650.GB18876@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130122103650.GB18876-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
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
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org" <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 22 January 2013 04:06 PM, Mark Rutland wrote:
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
>
> At any point past this, node's refcount is incremented (done automatically by
> of_parse_phandle => of_find_node_by_phandle).
>
>> +
>> +	ptr = devres_alloc(devm_usb_phy_release, sizeof(*ptr), GFP_KERNEL);
>> +	if (!ptr) {
>> +		dev_dbg(dev, "failed to allocate memory for devres\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	spin_lock_irqsave(&phy_lock, flags);
>> +
>> +	phy = __of_usb_find_phy(node);
>> +	if (IS_ERR(phy) || !try_module_get(phy->dev->driver->owner)) {
>> +		phy = ERR_PTR(-EPROBE_DEFER);
>> +		devres_free(ptr);
>> +		goto err0;
>> +	}
>> +
>> +	*ptr = phy;
>> +	devres_add(dev, ptr);
>> +
>> +	get_device(phy->dev);
>> +
>> +err0:
>> +	spin_unlock_irqrestore(&phy_lock, flags);
>> +
>> +	return phy;
>> +}
>
> This means that on all of the exit paths, node's refcount is left incremented
> incorrectly. You'll need an of_node_put(node) on each exit path.

Ok. Will fix it.

Thanks
Kishon
