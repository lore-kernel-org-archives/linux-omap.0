From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] Device Power: introduce power controller
Date: Mon, 03 Dec 2012 00:02:49 +0800
Message-ID: <50BB7BA9.4090902@linaro.org>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com> <1354460467-28006-2-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354460467-28006-2-git-send-email-tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02/12/12 23:01, the mail apparently from Ming Lei included:
> Power controller is an abstract on simple power on/off switch.
>
> One power controller can bind to more than one device, which
> provides power logically, for example, we can think one usb port
> in hub provides power to the usb device attached to the port, even
> though the power is supplied actually by other ways, eg. the usb
> hub is a self-power device. From hardware view, more than one
> device can share one power domain, and power controller can power
> on if one of these devices need to provide power, and power off if
> all these devices don't need to provide power.

What stops us using struct regulator here?  If you have child regulator=
s=20
supplied by a parent supply, isn't that the right semantic already=20
without introducing a whole new thing?  Apologies if I missed the point=
=2E

-Andy

> Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
> Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/base/power/Makefile           |    1 +
>   drivers/base/power/power_controller.c |  110 ++++++++++++++++++++++=
+++++++++++
>   include/linux/power_controller.h      |   48 ++++++++++++++
>   kernel/power/Kconfig                  |    6 ++
>   4 files changed, 165 insertions(+)
>   create mode 100644 drivers/base/power/power_controller.c
>   create mode 100644 include/linux/power_controller.h
>
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefil=
e
> index 2e58ebb..c08bfc9 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -5,5 +5,6 @@ obj-$(CONFIG_PM_TRACE_RTC)	+=3D trace.o
>   obj-$(CONFIG_PM_OPP)	+=3D opp.o
>   obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=3D  domain.o domain_governor.o
>   obj-$(CONFIG_HAVE_CLK)	+=3D clock_ops.o
> +obj-$(CONFIG_POWER_CONTROLLER)	+=3D power_controller.o
>
>   ccflags-$(CONFIG_DEBUG_DRIVER) :=3D -DDEBUG
> diff --git a/drivers/base/power/power_controller.c b/drivers/base/pow=
er/power_controller.c
> new file mode 100644
> index 0000000..d7671fb
> --- /dev/null
> +++ b/drivers/base/power/power_controller.c
> @@ -0,0 +1,110 @@
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/power_controller.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +
> +static DEFINE_MUTEX(pc_lock);
> +
> +static void pc_devm_release(struct device *dev, void *res)
> +{
> +}
> +
> +static int pc_devm_match(struct device *dev, void *res, void *match_=
data)
> +{
> +	struct pc_dev_data *data =3D res;
> +
> +	return (data->magic =3D=3D (unsigned long)pc_devm_release);
> +}
> +
> +static struct pc_dev_data *dev_pc_data(struct device *dev)
> +{
> +	struct pc_dev_data *data;
> +
> +	data =3D devres_find(dev, pc_devm_release, pc_devm_match, NULL);
> +	return data;
> +}
> +
> +static int pc_add_devm_data(struct device *dev, struct power_control=
ler *pc,
> +			    void *dev_data, int dev_data_size)
> +{
> +	struct pc_dev_data *data;
> +	int ret =3D 0;
> +
> +	mutex_lock(&pc_lock);
> +
> +	/* each device should only have one power controller resource */
> +	data =3D dev_pc_data(dev);
> +	if (data) {
> +		ret =3D 1;
> +		goto exit;
> +	}
> +
> +	data =3D devres_alloc(pc_devm_release, sizeof(struct pc_dev_data) +
> +			    dev_data_size, GFP_KERNEL);
> +	if (!data) {
> +		ret =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	data->magic =3D (unsigned long)pc_devm_release;
> +	data->pc =3D pc;
> +	data->dev_data =3D &data[1];
> +	memcpy(data->dev_data, dev_data, dev_data_size);
> +	devres_add(dev, data);
> +
> +exit:
> +	mutex_unlock(&pc_lock);
> +	return ret;
> +}
> +
> +static struct power_controller *dev_pc(struct device *dev)
> +{
> +	struct pc_dev_data *data =3D dev_pc_data(dev);
> +
> +	if (data)
> +		return data->pc;
> +	return NULL;
> +}
> +
> +struct pc_dev_data *dev_pc_get_data(struct device *dev)
> +{
> +	struct pc_dev_data *data =3D dev_pc_data(dev);
> +	return data;
> +}
> +EXPORT_SYMBOL(dev_pc_get_data);
> +
> +int dev_pc_bind(struct power_controller *pc, struct device *dev,
> +		void *dev_data, int dev_data_size)
> +{
> +	return pc_add_devm_data(dev, pc, dev_data, dev_data_size);
> +}
> +EXPORT_SYMBOL(dev_pc_bind);
> +
> +void dev_pc_unbind(struct power_controller *pc, struct device *dev)
> +{
> +}
> +EXPORT_SYMBOL(dev_pc_unbind);
> +
> +void dev_pc_power_on(struct device *dev)
> +{
> +	struct power_controller *pc =3D dev_pc(dev);
> +
> +	if (!pc)	return;
> +
> +	if (atomic_inc_return(&pc->count) =3D=3D 1)
> +		pc->power_on(pc, dev);
> +}
> +EXPORT_SYMBOL(dev_pc_power_on);
> +
> +void dev_pc_power_off(struct device *dev)
> +{
> +	struct power_controller *pc =3D dev_pc(dev);
> +
> +	if (!pc)	return;
> +
> +	if (!atomic_dec_return(&pc->count))
> +		pc->power_off(pc, dev);
> +}
> +EXPORT_SYMBOL(dev_pc_power_off);
> diff --git a/include/linux/power_controller.h b/include/linux/power_c=
ontroller.h
> new file mode 100644
> index 0000000..772f6d7
> --- /dev/null
> +++ b/include/linux/power_controller.h
> @@ -0,0 +1,48 @@
> +#ifndef _LINUX_POWER_CONTROLLER_H
> +#define _LINUX_POWER_CONTROLLER_H
> +
> +#include <linux/device.h>
> +
> +/*
> + * One power controller provides simple power on and power off.
> + *
> + * One power controller can bind to more than one device, which
> + * provides power logically, for example, we can think one usb port
> + * in hub provides power to the usb device attached to the port, eve=
n
> + * though the power is supplied actually by other ways, eg. the usb
> + * hub is a self-power device. From hardware view, more than one
> + * device can share one power domain, and power controller can power
> + * on if one of these devices need to provide power, and power off i=
f
> + * all these devices don't need to provide power.
> + *
> + * The abstract is introduced to hide the implementation details of
> + * power controller, and only let platform code handle the details.
> + */
> +struct power_controller {
> +	atomic_t count;			/* Number of users with power "on" */
> +	char *name;
> +	void (*power_off)(struct power_controller *pc, struct device *dev);
> +	void (*power_on)(struct power_controller *pc, struct device *dev);
> +};
> +
> +struct pc_dev_data {
> +	unsigned long magic;
> +	struct power_controller *pc;
> +	void	*dev_data;
> +};
> +
> +#ifdef CONFIG_POWER_CONTROLLER
> +extern struct pc_dev_data *dev_pc_get_data(struct device *dev);
> +extern int dev_pc_bind(struct power_controller *pc, struct device *d=
ev, void *dev_data, int dev_data_size);
> +extern void dev_pc_unbind(struct power_controller *pc, struct device=
 *dev);
> +extern void dev_pc_power_on(struct device *dev);
> +extern void dev_pc_power_off(struct device *dev);
> +#else
> +static inline struct pc_dev_data *dev_pc_get_data(struct device *dev=
){return NULL;}
> +static inline int dev_pc_bind(struct power_controller *pc, struct de=
vice *dev, void *dev_data,
> +				int dev_data_size){return 0;}
> +static inline void dev_pc_unbind(struct power_controller *pc, struct=
 device *dev){}
> +static inline void dev_pc_power_on(struct device *dev){}
> +static inline void dev_pc_power_off(struct device *dev){}
> +#endif
> +#endif /* _LINUX_POWER_CONTROLLER_H */
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 5dfdc9e..51803a9 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -255,6 +255,12 @@ config PM_OPP
>   	  implementations a ready to use framework to manage OPPs.
>   	  For more information, read <file:Documentation/power/opp.txt>
>
> +config POWER_CONTROLLER
> +	bool "Power Controller"
> +	---help---
> +	Power Controller is an abstract on power switch which can be
> +	shared by more than more devices.
> +
>   config PM_CLK
>   	def_bool y
>   	depends on PM && HAVE_CLK
>


--=20
Andy Green | TI Landing Team Leader
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -=20
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
