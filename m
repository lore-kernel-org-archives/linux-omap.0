From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCHv1 1/2] Export SoC info through sysfs
Date: Thu, 10 Mar 2011 09:38:51 +1300
Message-ID: <4D77E55B.8060802@bluewatersys.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: ext Nishanth Menon <nm@ti.com>, ext Tony Lindgren <tony@atomide.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, Linus Walleij <linus.walleij@linaro.org>, Ambresh <a0393775@ti.com>, Saravana Kannan <skannan@codeaurora.org>, Andrei Warkentin <andreiw@motorola.com>, Lee Jones <Lee.Jones@linaro.org>, Rabin VINCENT <rabin.vincent@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jonas ABERG <jonas.aberg@stericsson.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, David Brown <davidb@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Loic PALLARDY <loic.pallardy@stericsson.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, maxime_coquelin@yahoo.fr, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Walker <dwalker@codeaurora.org>, LKML
List-Id: linux-omap@vger.kernel.org

On 03/10/2011 05:59 AM, Maxime Coquelin wrote:
> Common base to export System-on-Chip related informations through sysfs.
> 
> Creation of a "soc" directory under /sys/devices/system/.
> Creation of a common "mach_name" entry to export machine name.
> Creation of platform-defined SoC information entries.

A few comments below. Echoing some of Jamie's and Mark's comments.

~Ryan

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

This should ideally be automatically selected by platforms which provide
SoC information.

Also, the word "informations" sounds odd to me. It can be replaced above
with "information" and in some other places with "pieces of information"
or similar.

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

If you make mach_name work like the other SoC info attributes then it
can be exported using the generic show_info function below. It also
means that struct sys_soc is no longer necessary; you can just have the
global sysdev_class.

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

Agree with others that it should be a bug to have an item with no data.
i.e. the registration should fail, probably with a WARN_ON. I also agree
that buf should be passed directly into the get_info callback. How do we
deal with overflow from dodgy callbacks? From memory we can safely write
at least one page to a sysfs buffer?

> +}
> +
> +void __init register_sys_soc_info(struct sys_soc_info *info, int nb_info)
> +{

register_sys_soc_info can only be called once. That may be the
intention, but it needs to be documented as such. Possibly a WARN_ON to
catch it being called multiple times? I could see potential bugs in
kernels which have multiple SoC/platforms built in.

This function should also be static, since calling it directly will
result in the mach_name entry never being set.

> +	int i;
> +
> +	for (i = 0; i < nb_info; i++) {
> +		info[i].attr.attr.name = info[i].name;
> +		info[i].attr.attr.mode = S_IRUGO;
> +		info[i].attr.show = show_info;

This is double handling. Can't we do something like this:

struct sys_soc_info {
	char *info;
	char *(*get_info)(struct sys_soc_info *);
	struct sysdev_class_attribute attr;
};

#define SYS_SOC_ATTR_VALUE(name, value) {	\
	.attr.attr.name = name,			\
	.mode           = S_IRUGO,		\
	.info           = value,		\
}

#define SYS_SOC_ATTR_CALLBACK(name, callback) {	\
	.attr.attr.name = name,			\
	.mode           = S_IRUGO,		\
	.get_info       = callback,		\
}

Then the above code isn't necessary and the ux500 platform registration
looks like this:

static struct sys_soc_info soc_info[] = {
	SYS_SOC_ATTR_CALLBACK("soc_id",   ux500_get_soc_id),
	SYS_SOC_ATTR_CALLBACK("revision", ux500_get_revision),
	SYS_SOC_ATTR_CALLBACK("process",  ux500_get_process),
};

Which is much more concise.

> +
> +		sysdev_class_create_file(&soc.class, &info[i].attr);

sysdev_class_create_file can fail, so we should propagate the error up.

> +	}
> +}
> +
> +void __init register_sys_soc(char *name, struct sys_soc_info *info, int num)
> +{
> +	int len;
> +
> +	len = strlen(name);
> +	soc.mach_name = kzalloc(len + 1, GFP_KERNEL);
> +	if (!soc.mach_name)
> +		return;
> +
> +	sprintf(soc.mach_name, "%s", name);

Change name to mach_name (or family?) to make it clearer what it is for
and make it const. Use kstrdup. This function should really return
proper error codes rather than silently failing.

I also think mach_name should be added the same way as the other items
since it should simplify the code a little.

> +
> +	if (sysdev_class_register(&soc.class)) {
> +		kfree(soc.mach_name);
> +		return;
> +	}

Standard kernel coding practice is:

	err = sysdev_class_register(&soc.class);	
	if (err) {
		kfree(soc.mach_name);
		return err;
	}

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

This becomes part of the ABI, so needs to be documented.

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

It should be noted here that one and only one of info and get_info must
be set.

> + * @attr: export's sysdev class attribute
> + */
> +struct sys_soc_info {
> +	char *name;
> +	char *info;
> +	char *(*get_info)(struct sys_soc_info *);
> +	struct sysdev_class_attribute attr;
> +};
> +
> +/**
> + * void register_sys_soc(char *name, struct sys_soc_info *, int num)
> + * @name: name of the machine

This is not really descriptive enough. We need to be reasonably clear
about what we mean by 'name'. Is it the mach name (i.e. the name of the
mach-xxxx) directory, is it the family (i.e. omap3 and omap4 are both
under omap), or is it something else?

> + * @info: pointer on the info table to export
> + * @num: number of info to export
> + */

Need to document here that register_sys_soc must only be called once.

> +void register_sys_soc(char *name, struct sys_soc_info *info, int num);
> +
> +#endif /* __SYS_SOC_H */

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
