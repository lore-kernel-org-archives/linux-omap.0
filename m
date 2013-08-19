From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: move of helpers into the core
Date: Mon, 19 Aug 2013 20:22:05 +0200
Message-ID: <5212624D.5090708@samsung.com>
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1376935183-11218-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/19/2013 07:59 PM, Wolfram Sang wrote:
> I2C of helpers used to live in of_i2c.c but experience (from SPI) shows
> that it is much cleaner to have this in the core. This also removes a
> circular dependency between the helpers and the core, and so we can
> finally register child nodes in the core instead of doing this manually
> in each driver. So, fix the drivers and documentation, too.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
> 
> Sigh, hitting the CC threshold on vger again. So resending to the lists only.
> BTW this patch is based on -rc4 and was tested on an AT91 board. More tests
> very welcome. Thanks!
> 
> 
>  drivers/i2c/busses/i2c-s3c2410.c                |    2 -
>  drivers/media/platform/exynos4-is/fimc-is-i2c.c |    3 -

For these:

Acked-by: Sylwester Nawrocki <s.nawrocki-UaMK/Mspgf7QT0dZR+AlfA@public.gmane.org>

However this patch fails to apply onto either v3.11-rc4 or v3.11-rc6:

Applying: i2c: move of helpers into the core
fatal: sha1 information is lacking or useless (drivers/i2c/busses/i2c-powermac.c).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001 i2c: move of helpers into the core


One nitpick below..

[...]
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index f32ca29..321b7ca 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -23,7 +23,11 @@
>     SMBus 2.0 support by Mark Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> and
>     Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>     Mux support by Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> and
> -   Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org> */
> +   Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org>
> +   OF support is copyright (c) 2008 Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
> +   (based on a previous patch from Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>) and
> +   (c) 2013  Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> + */
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> @@ -35,7 +39,9 @@
>  #include <linux/init.h>
>  #include <linux/idr.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/completion.h>
>  #include <linux/hardirq.h>
>  #include <linux/irqflags.h>
> @@ -954,6 +960,102 @@ static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
>  	up_read(&__i2c_board_lock);
>  }
>  
> +/* of support code */

/* OF support code */

or

/*
 * Device Tree support code.
 */

?
> +#if IS_ENABLED(CONFIG_OF)
> +static void of_i2c_register_devices(struct i2c_adapter *adap)
> +{
> +	void *result;
> +	struct device_node *node;
> +
> +	/* Only register child devices if the adapter has a node pointer set */
> +	if (!adap->dev.of_node)
> +		return;
> +
> +	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
> +
> +	for_each_available_child_of_node(adap->dev.of_node, node) {
> +		struct i2c_board_info info = {};
> +		struct dev_archdata dev_ad = {};
> +		const __be32 *addr;
> +		int len;
> +
> +		dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);
> +
> +		if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
> +			dev_err(&adap->dev, "of_i2c: modalias failure on %s\n",
> +				node->full_name);
> +			continue;
> +		}
> +
> +		addr = of_get_property(node, "reg", &len);
> +		if (!addr || (len < sizeof(int))) {
> +			dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
> +				node->full_name);
> +			continue;
> +		}
> +
> +		info.addr = be32_to_cpup(addr);
> +		if (info.addr > (1 << 10) - 1) {
> +			dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
> +				info.addr, node->full_name);
> +			continue;
> +		}
> +
> +		info.irq = irq_of_parse_and_map(node, 0);
> +		info.of_node = of_node_get(node);
> +		info.archdata = &dev_ad;
> +
> +		if (of_get_property(node, "wakeup-source", NULL))
> +			info.flags |= I2C_CLIENT_WAKE;
> +
> +		request_module("%s%s", I2C_MODULE_PREFIX, info.type);
> +
> +		result = i2c_new_device(adap, &info);
> +		if (result == NULL) {
> +			dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
> +				node->full_name);
> +			of_node_put(node);
> +			irq_dispose_mapping(info.irq);
> +			continue;
> +		}
> +	}
> +}
> +
> +static int of_dev_node_match(struct device *dev, void *data)
> +{
> +	return dev->of_node == data;
> +}
> +
> +/* must call put_device() when done with returned i2c_client device */
> +struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
> +{
> +	struct device *dev;
> +
> +	dev = bus_find_device(&i2c_bus_type, NULL, node,
> +					 of_dev_node_match);
> +	if (!dev)
> +		return NULL;
> +
> +	return i2c_verify_client(dev);
> +}
> +EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
> +
> +/* must call put_device() when done with returned i2c_adapter device */
> +struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
> +{
> +	struct device *dev;
> +
> +	dev = bus_find_device(&i2c_bus_type, NULL, node,
> +					 of_dev_node_match);
> +	if (!dev)
> +		return NULL;
> +
> +	return i2c_verify_adapter(dev);
> +}
> +EXPORT_SYMBOL(of_find_i2c_device_by_node);
> +#endif /* CONFIG_OF */

Thanks,
Sylwester
