From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Wed, 9 Mar 2011 17:39:02 +0000
Message-ID: <20110309173902.GD2737@pulham.picochip.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel
List-Id: linux-omap@vger.kernel.org

Hi Maxime,

Thanks for doing this, it looks very nice!  A couple of nitpicks, but 
I've given it a quick spin on my platform and it provides us with all of 
the hooks to export all of the information we need.

Jamie

On Wed, Mar 09, 2011 at 05:59:20PM +0100, Maxime Coquelin wrote:
> Common base to export System-on-Chip related informations through sysfs.
> 
> Creation of a "soc" directory under /sys/devices/system/.
> Creation of a common "mach_name" entry to export machine name.
> Creation of platform-defined SoC information entries.
> 
> Signed-off-by: Maxime COQUELIN <maxime.coquelin-nonst@stericsson.com>
> ---
>  drivers/base/Kconfig    |    4 ++
>  drivers/base/Makefile   |    1 +
>  drivers/base/soc.c      |   88 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h |   33 +++++++++++++++++
>  4 files changed, 126 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/soc.c
>  create mode 100644 include/linux/sys_soc.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index d57e8d0..4f2b56d 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -168,4 +168,8 @@ config SYS_HYPERVISOR
>  	bool
>  	default n
>  
> +config SYS_SOC
> +	bool "Export SoC specific informations"
> +	depends on EMBEDDED
> +
>  endmenu
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 5f51c3b..f3bcfb3 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -18,6 +18,7 @@ ifeq ($(CONFIG_SYSFS),y)
>  obj-$(CONFIG_MODULES)	+= module.o
>  endif
>  obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
> +obj-$(CONFIG_SYS_SOC) += soc.o
>  
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
>  
> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> new file mode 100644
> index 0000000..6fa538b
> --- /dev/null
> +++ b/drivers/base/soc.c
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2011
> + * Author: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/sysdev.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/stat.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +static struct sysdev_class_attribute *soc_default_attrs[];
> +
> +struct sys_soc {
> +	char *mach_name;

Can this be made const?

> +	struct sysdev_class class;
> +};
> +
> +struct sys_soc soc = {
> +	.class = {
> +		.name = "soc",
> +		.attrs = soc_default_attrs,
> +	},
> +};
> +
> +static ssize_t show_mach_name(struct sysdev_class *class,
> +				struct sysdev_class_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%s\n", soc.mach_name);
> +}
> +static SYSDEV_CLASS_ATTR(mach_name, S_IRUGO, show_mach_name, NULL);
> +
> +static ssize_t show_info(struct sysdev_class *class,
> +				struct sysdev_class_attribute *attr, char *buf)
> +{
> +	struct sys_soc_info *si = container_of(attr,
> +			struct sys_soc_info, attr);
> +
> +	if (si->info)
> +		return sprintf(buf, "%s\n", si->info);
> +	else if (si->get_info)
> +		return sprintf(buf, "%s\n", si->get_info(si));
> +	else
> +		return sprintf(buf, "No data\n");

Isn't this a platform error if we don't have a way to get the required 
info?  If in register_sys_soc_info() we check that one of si->info or 
si->get_info is non-NULL then we don't need this check.  If we have 
something like:

static bool sys_soc_info_is_valid(struct sys_soc_info *info)
{
	if ((!info->info && !info->get_info) ||
	    info->info && info->get_info)
	    return false;

	return true;
}

then we can do this at registration.  Is there a valid use case where 
someone could set the static info and the dynamic get_info callback?

> +}
> +
> +void __init register_sys_soc_info(struct sys_soc_info *info, int nb_info)
> +{
> +	int i;
> +
> +	for (i = 0; i < nb_info; i++) {
> +		info[i].attr.attr.name = info[i].name;
> +		info[i].attr.attr.mode = S_IRUGO;
> +		info[i].attr.show = show_info;
> +
> +		sysdev_class_create_file(&soc.class, &info[i].attr);

		if (sys_soc_info_is_valid(&info[i]))
			sysdev_class_create_file(...); ?

> +	}
> +}
> +
> +void __init register_sys_soc(char *name, struct sys_soc_info *info, int num)

Make name const?  Also, should num be a size_t?

> +{
> +	int len;
> +
> +	len = strlen(name);
> +	soc.mach_name = kzalloc(len + 1, GFP_KERNEL);
> +	if (!soc.mach_name)
> +		return;
> +
> +	sprintf(soc.mach_name, "%s", name);

soc.mach_name = kstrdup(name, GFP_KERNEL) instead of the allocate and 
sprintf?

> +
> +	if (sysdev_class_register(&soc.class)) {
> +		kfree(soc.mach_name);
> +		return;
> +	}
> +
> +	register_sys_soc_info(info, num);
> +}
> +
> +/*
> + * Common attributes for all platforms.
> + * Only machine name for now
> + */
> +static struct sysdev_class_attribute *soc_default_attrs[] = {
> +	&attr_mach_name,
> +	NULL
> +};
> diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> new file mode 100644
> index 0000000..b91a924
> --- /dev/null
> +++ b/include/linux/sys_soc.h
> @@ -0,0 +1,33 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2011
> + * Author: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +#ifndef __SYS_SOC_H
> +#define __SYS_SOC_H
> +
> +#include <linux/sysdev.h>
> +
> +/**
> + * struct sys_soc_info - SoC exports related informations
> + * @name: name of the export
> + * @info: pointer on the key to export
> + * @get_info: callback to retrieve key if info field is NULL
> + * @attr: export's sysdev class attribute
> + */
> +struct sys_soc_info {
> +	char *name;
> +	char *info;
> +	char *(*get_info)(struct sys_soc_info *);

Could this return a const char* ?

> +	struct sysdev_class_attribute attr;
> +};
> +
> +/**
> + * void register_sys_soc(char *name, struct sys_soc_info *, int num)

I think this should be "register_sys_soc - register the soc information" 
for valid kerneldoc notation..

> + * @name: name of the machine
> + * @info: pointer on the info table to export
> + * @num: number of info to export
> + */
> +void register_sys_soc(char *name, struct sys_soc_info *info, int num);
> +
> +#endif /* __SYS_SOC_H */
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
