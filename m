From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCHv2 1/2] Export SoC info through sysfs
Date: Fri, 11 Mar 2011 15:32:51 +0100
Message-ID: <201103111532.52393.arnd@arndb.de>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299846911-15782-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1299846911-15782-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Jouni Hogander <jouni.hogander@nokia.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Greg KH <greg@kroah.com>, David Brown <davidb@codeaurora.org>, Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Ryan Mallon <ryan@bluewatersys.com>, Linux-OMAP <linux-omap@vger.kernel.org>Da
List-Id: linux-omap@vger.kernel.org

On Friday 11 March 2011, Maxime Coquelin wrote:
> Common base to export System-on-Chip related informations through sysfs.
> 
> Creation of a "socinfo" directory under /sys/.
> Creation of SoC information entries.
> 
> Signed-off-by: Maxime COQUELIN <maxime.coquelin-nonst@stericsson.com>

I think it's better than the previous patch to create an
artificial device in /sys/devices/system/socinfo, but I'd
still prefer the information to be attached to a real device
that represents the SOC, as I explained in the discussion with
Linus Walleij.

You should definitely add Greg on Cc, as he's maintaining sysfs
and certainly has an opininion here.

	Arnd

> ---
>  Documentation/ABI/testing/sysfs-socinfo |   16 ++++++
>  drivers/base/Kconfig                    |    3 +
>  drivers/base/Makefile                   |    1 +
>  drivers/base/soc.c                      |   79 +++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h                 |   50 +++++++++++++++++++
>  5 files changed, 149 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-socinfo
>  create mode 100644 drivers/base/soc.c
>  create mode 100644 include/linux/sys_soc.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-socinfo b/Documentation/ABI/testing/sysfs-socinfo
> new file mode 100644
> index 0000000..afd9da2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-socinfo
> @@ -0,0 +1,16 @@
> +What:		/sys/socinfo
> +Date:		March 2011
> +contact:	Maxime Coquelin <maxime.coquelin-nonst@stericsson.com>
> +Description:
> +		The /sys/socinfo directory contains information about the
> +		System-on-Chip.	It is only available if platform implements it.
> +		This directory contains two kind of attributes :
> +			- common attributes: 
> +				* machine: the name of the machine.
> +				* family: the family name of the SoC
> +			- SoC-specific attributes: The SoC vendor can declare attributes
> +			  to export some strings to user-space, like the serial-number for
> +			  example.
> +
> +Users:
> +		User-space applications which needs these kind of attributes.
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index d57e8d0..372ef3a 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -168,4 +168,7 @@ config SYS_HYPERVISOR
>  	bool
>  	default n
>  
> +config SYS_SOC
> +	bool
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
> index 0000000..046b43b
> --- /dev/null
> +++ b/drivers/base/soc.c
> @@ -0,0 +1,79 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2011
> + * Author: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/stat.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +struct kobject *soc_object;
> +
> +ssize_t show_soc_info(struct kobject *kobj,
> +			struct kobj_attribute *attr, char *buf)
> +{
> +	struct sysfs_soc_info *si = container_of(attr,
> +				struct sysfs_soc_info, attr);
> +
> +	if (si->info)
> +		return sprintf(buf, "%s\n", si->info);
> +
> +	return si->get_info(buf, si);
> +}

I think this can be simplified by just letting the soc
register its own show method instead of the get_info function.

> +int __init register_sysfs_soc_info(struct sysfs_soc_info *info, int nb_info)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < nb_info; i++) {
> +		ret = sysfs_create_file(soc_object, &info[i].attr.attr);
> +		if (ret) {
> +			for (i -= 1; i >= 0; i--)
> +				sysfs_remove_file(soc_object, &info[i].attr.attr);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static struct attribute *soc_attrs[] = {
> +	NULL,
> +};
> +
> +static struct attribute_group soc_attr_group = {
> +	.attrs = soc_attrs,
> +};
> +
> +int __init register_sysfs_soc(struct sysfs_soc_info *info, size_t num)
> +{
> +	int ret;
> +
> +	soc_object = kobject_create_and_add("socinfo", NULL);
> +	if (!soc_object) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	ret = sysfs_create_group(soc_object, &soc_attr_group);
> +	if (ret)
> +		goto kset_exit;
> +
> +	ret = register_sysfs_soc_info(info, num);
> +	if (ret)
> +		goto group_exit;
> +
> +	return 0;
> +
> +group_exit:
> +	sysfs_remove_group(soc_object, &soc_attr_group);
> +kset_exit:
> +	kobject_put(soc_object);
> +exit:
> +	return ret;
> +}
> +
> diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
> new file mode 100644
> index 0000000..05e5529
> --- /dev/null
> +++ b/include/linux/sys_soc.h
> @@ -0,0 +1,50 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2011
> + * Author: Maxime Coquelin <maxime.coquelin-nonst@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +#ifndef __SYS_SOC_H
> +#define __SYS_SOC_H
> +
> +#include <linux/kobject.h>
> +
> +/**
> + * struct sys_soc_info - SoC exports related informations
> + * @name: name of the export
> + * @info: pointer on the key to export
> + * @get_info: callback to retrieve key if info field is NULL
> + * @attr: export's sysdev class attribute
> + */
> +struct sysfs_soc_info {
> +	const char *info;
> +	ssize_t (*get_info)(char *buf, struct sysfs_soc_info *);
> +	struct kobj_attribute attr;
> +};
> +
> +ssize_t show_soc_info(struct kobject *, struct kobj_attribute *, char *);
> +
> +#define SYSFS_SOC_ATTR_VALUE(_name, _value) {		\
> +	.attr.attr.name = _name,			\
> +	.attr.attr.mode = S_IRUGO,			\
> +	.attr.show	= show_soc_info,		\
> +	.info           = _value,			\
> +}
> +
> +#define SYSFS_SOC_ATTR_CALLBACK(_name, _callback) {	\
> +	.attr.attr.name = _name,			\
> +	.attr.attr.mode = S_IRUGO,			\
> +	.attr.show	= show_soc_info,		\
> +	.get_info       = _callback,			\
> +}
> +
> +/**
> + * register_sys_soc - register the soc information
> + * @name: name of the machine
> + * @info: pointer on the info table to export
> + * @num: number of info to export
> + *
> + * NOTE: This function must only be called once
> + */
> +int register_sysfs_soc(struct sysfs_soc_info *info, size_t num);
> +
> +#endif /* __SYS_SOC_H */
> -- 
