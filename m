From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/5] extcon: Add an API to get extcon device from dt node
Date: Wed, 12 Jun 2013 10:28:00 +0900
Message-ID: <51B7CEA0.2060903@samsung.com>
References: <1370276020-17446-1-git-send-email-kishon@ti.com>
 <1370276020-17446-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1370276020-17446-2-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: myungjoo.ham@samsung.com, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, gregkh@linuxfoundation.org, benoit.cousson@linaro.org, anish198519851985@gmail.com, pmeerw@pmeerw.net
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On 06/04/2013 01:13 AM, Kishon Vijay Abraham I wrote:
> Added an API of_extcon_get_extcon_dev() to be used by drivers to get
> extcon device in the case of dt boot (this can be used instead of
> extcon_get_extcon_dev()).
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/extcon/extcon-class.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/extcon.h        |    8 ++++++++
>  2 files changed, 48 insertions(+)

I don't prefer that add of helper API in extcon core. I want to add
new of helper file as drivers/extcon/of-extcon.c.
So, I add drivers/extcon/of-extcon.c and include/linux/extcon/of-extcon.h
based on your this patch. I will send modified patch at once.

> diff --git a/drivers/extcon/extcon-class.c b/drivers/extcon/extcon-class.c
> index 60adc04..265d549 100644
> --- a/drivers/extcon/extcon-class.c
> +++ b/drivers/extcon/extcon-class.c
> @@ -31,6 +31,7 @@
>  #include <linux/extcon.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> +#include <linux/of_platform.h>
>  
>  /*
>   * extcon_cable_name suggests the standard cable names for commonly used
> @@ -392,6 +393,45 @@ int extcon_set_cable_state(struct extcon_dev *edev,
>  }
>  EXPORT_SYMBOL_GPL(extcon_set_cable_state);
>  
> +struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev, int index)
> +{
> +	struct class_dev_iter iter;
> +	struct device *extcon_dev;
> +	struct device_node *node;
> +	struct platform_device *extcon_parent_dev;
> +
> +	if (!dev->of_node) {
> +		dev_dbg(dev, "device does not have a device node entry\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	node = of_parse_phandle(dev->of_node, "extcon", index);
> +	if (!node) {
> +		dev_dbg(dev, "failed to get phandle in %s node\n",
> +			dev->of_node->full_name);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	extcon_parent_dev = of_find_device_by_node(node);
> +	if (!extcon_parent_dev) {
> +		dev_dbg(dev, "unable to find device by node\n");
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	class_dev_iter_init(&iter, extcon_class, NULL, NULL);
> +	while ((extcon_dev = class_dev_iter_next(&iter))) {
> +		if (extcon_dev->parent != &extcon_parent_dev->dev)
> +			continue;
> +
> +		class_dev_iter_exit(&iter);
> +		return dev_get_drvdata(extcon_dev);
> +	}
> +
> +	class_dev_iter_exit(&iter);

Use extcon_get_extcon_dev() instead of using class_dev_iter_init/exit()

> +	return ERR_PTR(-ENODEV);
> +}
> +EXPORT_SYMBOL_GPL(of_extcon_get_extcon_dev);
> +
>  /**
>   * extcon_get_extcon_dev() - Get the extcon device instance from the name
>   * @extcon_name:	The extcon name provided with extcon_dev_register()
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index fcb51c8..3858bb9 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -182,6 +182,8 @@ struct extcon_specific_cable_nb {
>   */
>  extern int extcon_dev_register(struct extcon_dev *edev, struct device *dev);
>  extern void extcon_dev_unregister(struct extcon_dev *edev);
> +extern struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev,
> +	int index);
>  extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
>  
>  /*
> @@ -292,6 +294,12 @@ static inline int extcon_set_cable_state(struct extcon_dev *edev,
>  	return 0;
>  }
>  
> +static inline struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev,
> +	int index)
> +{
> +	return NULL;
> +}
> +
>  static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  {
>  	return NULL;

Thanks,
Chanwoo Choi






