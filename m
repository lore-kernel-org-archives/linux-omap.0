From: Andy Green <andy.green@linaro.org>
Subject: Re: [RFC PATCH 2/5] driver core: introduce global device ADD/DEL
 notifier
Date: Mon, 03 Dec 2012 00:13:21 +0800
Message-ID: <50BB7E21.1080200@linaro.org>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com> <1354460467-28006-3-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:38760 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab2LBQNk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 2 Dec 2012 11:13:40 -0500
In-Reply-To: <1354460467-28006-3-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>

On 02/12/12 23:01, the mail apparently from Ming Lei included:
> The global device ADD/DEL notifier is introduced so that
> some platform code can bind some device resource to the
> device. When this platform code runs, there is no any bus
> information about the device, so have to resort to the
> global notifier.
>
> Cc: Andy Green <andy.green@linaro.org>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>   drivers/base/core.c    |   21 +++++++++++++++++++++
>   include/linux/device.h |   13 +++++++++++++
>   2 files changed, 34 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a235085..37f11ff 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -43,6 +43,9 @@ static __init int sysfs_deprecated_setup(char *arg)
>   early_param("sysfs.deprecated", sysfs_deprecated_setup);
>   #endif
>
> +/* global device nofifier */
> +struct blocking_notifier_head dev_notifier;
> +
>   int (*platform_notify)(struct device *dev) =3D NULL;
>   int (*platform_notify_remove)(struct device *dev) =3D NULL;
>   static struct kobject *dev_kobj;
> @@ -1041,6 +1044,8 @@ int device_add(struct device *dev)
>   	if (platform_notify)
>   		platform_notify(dev);
>
> +	blocking_notifier_call_chain(&dev_notifier, DEV_NOTIFY_ADD_DEVICE, =
dev);
> +
>   	error =3D device_create_file(dev, &uevent_attr);
>   	if (error)
>   		goto attrError;
> @@ -1228,6 +1233,7 @@ void device_del(struct device *dev)
>   	device_pm_remove(dev);
>   	driver_deferred_probe_del(dev);
>
> +	blocking_notifier_call_chain(&dev_notifier, DEV_NOTIFY_DEL_DEVICE, =
dev);
>   	/* Notify the platform of the removal, in case they
>   	 * need to do anything...
>   	 */
> @@ -1376,6 +1382,8 @@ struct device *device_find_child(struct device =
*parent, void *data,
>
>   int __init devices_init(void)
>   {
> +	BLOCKING_INIT_NOTIFIER_HEAD(&dev_notifier);
> +
>   	devices_kset =3D kset_create_and_add("devices", &device_uevent_ops=
, NULL);
>   	if (!devices_kset)
>   		return -ENOMEM;
> @@ -1995,6 +2003,19 @@ int dev_printk(const char *level, const struct=
 device *dev,
>   }
>   EXPORT_SYMBOL(dev_printk);
>
> +/* The notifier should be avoided as far as possible */
> +int dev_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&dev_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(dev_register_notifier);
> +
> +int dev_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&dev_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(dev_unregister_notifier);
> +
>   #define define_dev_printk_level(func, kern_level)		\
>   int func(const struct device *dev, const char *fmt, ...)	\
>   {								\
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 43dcda9..aeb54f6 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -179,6 +179,19 @@ extern int bus_unregister_notifier(struct bus_ty=
pe *bus,
>   #define BUS_NOTIFY_UNBOUND_DRIVER	0x00000006 /* driver is unbound
>   						      from the device */
>
> +/* All 2 notifers below get called with the target struct device *
> + * as an argument. Note that those functions are likely to be called
> + * with the device lock held in the core, so be careful.
> + */
> +#define DEV_NOTIFY_ADD_DEVICE          0x00000001 /* device added */
> +#define DEV_NOTIFY_DEL_DEVICE          0x00000002 /* device removed =
*/
> +extern int dev_register_notifier(struct notifier_block *nb);
> +extern int dev_unregister_notifier(struct notifier_block *nb);
> +
> +extern struct kset *bus_get_kset(struct bus_type *bus);
> +extern struct klist *bus_get_device_klist(struct bus_type *bus);
> +
> +
>   extern struct kset *bus_get_kset(struct bus_type *bus);
>   extern struct klist *bus_get_device_klist(struct bus_type *bus);

Device de/registraton time is not necessarily a good choice for the=20
notification point.  At boot time, platform_devices may be being=20
registered with no sign of driver and anything getting enabled in the=20
notifier without further filtering (at each notifier...) will then=20
always be enabled the whole session whether in use or not.

probe() and remove() are more interesting because at that point the=20
driver is present and we're definitely instantiating the thing or=20
finished with its instantiation, and it's valid for non-usb devices too=
=2E

In the one case you're servicing in the series, usb hub port, the devic=
e=20
is very unusual in that it has no driver.  However if you're going to=20
add a global notifier in generic device code, you should have it do the=
=20
right thing for normal device case so other people can use it... how I=20
solved this for hub port was to simply normalize hub port by introducin=
g=20
a stub driver for it, so you get a probe / remove like anything else.

-Andy

--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
