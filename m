From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce accessory APIs for DVFS
Date: Wed, 02 Feb 2011 17:07:23 -0800
Message-ID: <87wrli2aes.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-2-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36783 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751015Ab1BCBHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 20:07:34 -0500
Received: by mail-iy0-f171.google.com with SMTP id 21so573567iyj.30
        for <linux-omap@vger.kernel.org>; Wed, 02 Feb 2011 17:07:33 -0800 (PST)
In-Reply-To: <1295618465-15234-2-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 21 Jan 2011 19:30:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Thara Gopinath <thara@ti.com>

Vishwanath BS <vishwanath.bs@ti.com> writes:

> This patch introduces accessory APIs for DVFS.

Actually, it begins the implementation of a DVFS layer.

> Data structures added:
> 1. omap_dev_user_list: This structure maintains list of frequency requests per
>    device basis. When a device needs to be scaled to a particular frequency,
>    This list is searched to find the maximum request for a given device.
>    If noone has placed any request, device frequency is obtained from device
>    opp table.
> 2. omap_vdd_dev_list: This strcucture stores device list per vdd basis.
>    Whenever a device is registered with a vdd, it is added to this list.
> 3. omap_vdd_user_list: User list of devices associated with each voltage domain
>    instance. The user list is implemented using plist structure with priority
>    node populated with the voltage values.
> 4. omap_vdd_dvfs_info: This structure is used to abstract DVFS related
>    information per VDD basis. It holds pointer to corresponding vdd's
>    voltagedomain instance and pointer to user list.

The terms "user" and dev/device are rather overloaded here and elsewhere
in the code, and makes for rather difficult reading.

I have an idea (or two) to rework these data structures and how they're
stored/connected, but I need to think on it a little more.  More on that
tomorrow...

> Following APIs have been added to operate on above data structures:
> 1. omap_dvfs_add_vdd_user - API to add a user into omap_vdd_user_list
> 2. omap_vdd_user_list - API to remove a user from omap_vdd_user_list

huh?  cut and paste error?  I think this was supposed to be
_remove_vdd_user() ?

> 3. omap_dvfs_register_device - API to register a device with vdd
> 4. omap_dvfs_add_freq_request - API to add a frequency request into
>    omap_dev_user_list
> 5. omap_dvfs_remove_freq_request - API to remove a frequency request from
>    omap_dev_user_list
> 6. omap_dvfs_find_voltage - API to find the opp corresponding to given voltage

I think function naming needs rework for consistency.  For example, to
request a frequency you call _add_freq_request(), but to add a voltage
you call _add_vdd_user(), not very reader friendly

How about simply:

    omap_dvfs_request_freq()
    omap_dvfs_request_volt()

with remove equivalents.

Actually, looking more at the functions in this patch, the frequency and
voltage functions here are basically identical.  There really isn't any
good reason to have separate functions for frequency and voltage.  How
about:

    omap_dvfs_add_request(dvfs_info, class, req_dev, target_dev);
    omap_dvfs_remove_request(dvfs_info, class, req_dev, target_dev);

where class = OMAP_DVFS_FREQ | OMAP_DVFS_VOLT.  This way, based on the
class, you can add the requests to the separate lists, but bulk
of the function is the same.

>
> DVFS layer is initialized and basic data structures are allocated and
> initialized as part of this.
>
> This patch is based on Thara's previous DVFS implementation, but with major
> rework.
>

Minor comment on acronyms.   In the comments throughout, please
capitalize acronyms like DVFS, VDD, etc.  Currently, it is mixed between
upper and lower-case.

> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Cc: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile           |    2 +-
>  arch/arm/mach-omap2/dvfs.c             |  456 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/dvfs.h |   27 ++
>  arch/arm/plat-omap/omap_device.c       |    9 +
>  4 files changed, 493 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/dvfs.c
>  create mode 100644 arch/arm/plat-omap/include/plat/dvfs.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 4ab82f6..bb2e2bc 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -61,7 +61,7 @@ ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o voltage.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
> -					   cpuidle34xx.o pm_bus.o
> +					   cpuidle34xx.o pm_bus.o dvfs.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o pm_bus.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
> diff --git a/arch/arm/mach-omap2/dvfs.c b/arch/arm/mach-omap2/dvfs.c
> new file mode 100644
> index 0000000..8832e4a
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dvfs.c
> @@ -0,0 +1,456 @@
> +/*
> + * OMAP3/OMAP4 DVFS Management Routines
> + *
> + * Author: Vishwanath BS	<vishwanath.bs@ti.com>
> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + * Vishwanath BS <vishwanath.bs@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/spinlock.h>
> +#include <linux/plist.h>
> +#include <linux/slab.h>
> +#include <linux/opp.h>
> +#include <plat/common.h>
> +#include <plat/voltage.h>
> +#include <plat/omap_device.h>
> +
> +/**
> + * struct omap_dev_user_list - Structure maitain userlist per devide

typos: maintain, device

the latter typo you fix in a follow up patch, but should be fixed here.

> + *
> + * @dev:       The device requesting for a particular frequency
> + * @node:      The list head entry
> + * @freq:      frequency being requested
> + *
> + * Using this structure, user list (requesting dev * and frequency) for
> + * each device is maintained. This is how we can have different devices
> + * at different frequencies (to support frequency locking and throttling).
> + * Even if one of the devices in a given vdd has locked it's frequency,
> + * other's can still scale their frequency using this list.
> + * If no one has placed a frequency request for a device, then device is
> + * set to the frequency from it's opp table.
> + */
> +struct omap_dev_user_list {
> +		struct device *dev;
> +		struct plist_node node;
> +		u32 freq;

extra indentation

> +};
> +
> +/**
> + * struct omap_vdd_dev_list - Device list per vdd
> + *
> + * @dev:	The device belonging to a particular vdd
> + * @node:	The list head entry

and the other entries?

> + */
> +struct omap_vdd_dev_list {
> +	struct device *dev;
> +	struct list_head node;
> +	struct plist_head user_list;
> +	spinlock_t user_lock; /* spinlock for plist */

comment redundant

> +};
> +
> +/**
> + * struct omap_vdd_user_list - The per vdd user list
> + *
> + * @dev:	The device asking for the vdd to be set at a particular
> + *			voltage
> + * @node:	The list head entry
> + * @volt:	The voltage requested by the device <dev>
> + */
> +struct omap_vdd_user_list {
> +	struct device *dev;
> +	struct plist_node node;
> +	u32 volt;
> +};

This struct is identical to omap_dev_user_list above, except
s/freq/volt/.  You probably just need a single struct using 'val'
instead of freq/volt.

That being said, why is the frequency struct called 'dev_user_list' and
the voltage table called 'vdd_user_list'.  This alone renders the
resulting code unreadable.  


> +/**
> + * struct omap_vdd_dvfs_info - The per vdd dvfs info
> + *
> + * @user_lock:	spinlock for plist operations
> + * @user_list:	The vdd user list
> + * @scaling_mutex:	Mutex for protecting dvfs data structures for a vdd
> + * @voltdm: Voltage domains for which dvfs info stored

missing some entries here

> + * This is a fundamental structure used to store all the required
> + * DVFS related information for a vdd.
> + */
> +struct omap_vdd_dvfs_info {
> +	spinlock_t user_lock; /* spin lock */

comment redundant

> +	struct plist_head user_list;
> +	struct mutex scaling_mutex; /* dvfs mutex */

ditto

> +	struct voltagedomain *voltdm;
> +	struct list_head dev_list;
> +};
> +
> +static struct omap_vdd_dvfs_info *omap_dvfs_info_list;
> +static int omap_nr_vdd;
> +
> +static struct voltagedomain omap3_vdd[] = {
> +	{
> +	.name = "mpu",
> +	},
> +	{
> +	.name = "core",
> +	},
> +};

indentation

> +static int __init omap_dvfs_init(void);
> +
> +static struct omap_vdd_dvfs_info *get_dvfs_info(struct voltagedomain *voltdm)
> +{
> +	int i;

insert blank line

> +	if (!voltdm || !omap_dvfs_info_list)
> +		return NULL;
> +
> +	for (i = 0; i < omap_nr_vdd; i++)
> +		if (omap_dvfs_info_list[i].voltdm == voltdm)
> +			return &omap_dvfs_info_list[i];
> +
> +	pr_warning("%s: unable find dvfs info for vdd %s\n",
> +			__func__, voltdm->name);
> +	return NULL;
> +}
> +
> +/**
> + * omap_dvfs_find_voltage() - search for given voltage
> + * @dev:	device pointer associated with the opp type
> + * @volt:	voltage to search for
> + *
> + * Searches for exact match in the opp list and returns handle to the matching

comment doesn't match code.  OPP lookup is done using the 'ceil'
version, which is not an exact match, and the voltage check uses '>='
not '=='.

> + * opp if found, else returns ERR_PTR in case of error and should be handled
> + * using IS_ERR. If there are multiple opps with same voltage, it will return
> + * the first available entry.

More specifically, it will return the one with the lowest frequency.

> + */
> +static struct opp *omap_dvfs_find_voltage(struct device *dev,
> +		unsigned long volt)
> +{
> +	struct opp *opp = ERR_PTR(-ENODEV);
> +	unsigned long f = 0;
> +
> +	do {
> +		opp = opp_find_freq_ceil(dev, &f);
> +		if (IS_ERR(opp))
> +			break;
> +		if (opp_get_voltage(opp) >= volt)
> +			break;
> +		f++;
> +	} while (1);
> +
> +	return opp;
> +}
> +
> +/**
> + * omap_dvfs_add_vdd_user() - Add a voltage request
> + * @dvfs_info: omap_vdd_dvfs_info pointer for the required vdd
> + * @dev: device making the request
> + * @volt: requesting voltage in uV
> + *
> + * Adds the given devices' voltage request into corresponding
> + * vdd's omap_vdd_dvfs_info user list (plist). This list is used
> + * to find the maximum voltage request for a given vdd.
> + *
> + * Returns 0 on success.
> + */
> +static int omap_dvfs_add_vdd_user(struct omap_vdd_dvfs_info *dvfs_info,
> +		struct device *dev, unsigned long volt)
> +{
> +	struct omap_vdd_user_list *user = NULL, *temp_user;
> +	struct plist_node *node;
> +
> +	if (!dvfs_info || IS_ERR(dvfs_info)) {
> +		dev_warn(dev, "%s: VDD specified does not exist!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&dvfs_info->scaling_mutex);
> +
> +	plist_for_each_entry(temp_user, &dvfs_info->user_list, node) {
> +		if (temp_user->dev == dev) {
> +			user = temp_user;
> +			break;
> +		}
> +	}
> +
> +	if (!user) {
> +		user = kzalloc(sizeof(struct omap_vdd_user_list), GFP_KERNEL);
> +		if (!user) {
> +			dev_err(dev, "%s: Unable to creat a new user for vdd_%s\n",
> +				__func__, dvfs_info->voltdm->name);
> +			mutex_unlock(&dvfs_info->scaling_mutex);
> +			return -ENOMEM;
> +		}
> +		user->dev = dev;
> +	} else {
> +		plist_del(&user->node, &dvfs_info->user_list);
> +	}
> +
> +	plist_node_init(&user->node, volt);
> +	plist_add(&user->node, &dvfs_info->user_list);
> +	node = plist_last(&dvfs_info->user_list);
> +	user->volt = node->prio;
> +
> +	mutex_unlock(&dvfs_info->scaling_mutex);
> +
> +	return 0;
> +}
> +
> +/**
> + * omap_dvfs_remove_vdd_user() - Remove a voltage request
> + * @dvfs_info: omap_vdd_dvfs_info pointer for the required vdd
> + * @dev: device making the request
> + *
> + * Removes the given devices' voltage request from corresponding
> + * vdd's omap_vdd_dvfs_info user list (plist).
> + *
> + * Returns 0 on success.
> + */
> +static int omap_dvfs_remove_vdd_user(struct omap_vdd_dvfs_info *dvfs_info,
> +		struct device *dev)
> +{
> +	struct omap_vdd_user_list *user = NULL, *temp_user;
> +	int ret = 0;
> +
> +	if (!dvfs_info || IS_ERR(dvfs_info)) {
> +		dev_err(dev, "%s: VDD specified does not exist!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&dvfs_info->scaling_mutex);
> +
> +	plist_for_each_entry(temp_user, &dvfs_info->user_list, node) {
> +		if (temp_user->dev == dev) {
> +			user = temp_user;
> +			break;
> +		}
> +	}
> +
> +	if (user)
> +		plist_del(&user->node, &dvfs_info->user_list);
> +	else {
> +		dev_err(dev, "%s: Unable to find the user for vdd_%s\n",
> +					__func__, dvfs_info->voltdm->name);
> +		ret = -ENOMEM;
> +	}
> +	mutex_unlock(&dvfs_info->scaling_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * omap_dvfs_register_device - Add a device into voltage domain
> + * @voltdm:	voltage domain to which the device is to be added
> + * @dev:	Device to be added
> + *
> + * This API will add a given device into user_list of corresponding
> + * vdd's omap_vdd_dvfs_info strucure. This list is traversed to scale
> + * frequencies of all the devices on a given vdd. This api is called
> + * while hwmod db is built for an omap_device.
> + *
> + * Returns 0 on success.
> + */
> +int omap_dvfs_register_device(struct voltagedomain *voltdm, struct device *dev)
> +{
> +	struct omap_vdd_dev_list *temp_dev;

The point of using the 'temp_' names is for temporary iterators.  Here,
you're using it as the dev_list throughout.  Just call it dev_list.

> +	struct omap_vdd_dvfs_info *dvfs_info = get_dvfs_info(voltdm);
> +
> +	if (!voltdm || IS_ERR(voltdm) || !dvfs_info) {
> +		dev_warn(dev, "%s: VDD specified does not exist!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	list_for_each_entry(temp_dev, &dvfs_info->dev_list, node) {
> +		if (temp_dev->dev == dev) {
> +			dev_warn(dev, "%s: Device already added to vdee_%s\n",

s/vdee/VDD/ ?

You might be seeing device already added for devices with multiple
hwmods per omap_device.  More on this below.

> +				__func__, dvfs_info->voltdm->name);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	temp_dev = kzalloc(sizeof(struct omap_vdd_dev_list), GFP_KERNEL);
> +	if (!temp_dev) {
> +		dev_err(dev, "%s: Unable to creat a new device for vdd_%s\n",
> +			__func__, dvfs_info->voltdm->name);
> +		return -ENOMEM;
> +	}
> +
> +	/* Initialize priority ordered list */
> +	spin_lock_init(&temp_dev->user_lock);
> +	plist_head_init(&temp_dev->user_list, &temp_dev->user_lock);
> +
> +	temp_dev->dev = dev;
> +	list_add(&temp_dev->node, &dvfs_info->dev_list);
> +
> +	return 0;
> +}
> +
> +/**
> + * omap_dvfs_add_freq_request() - add a requested device frequency
> + *
> + *
> + * @dvfs_info: omap_vdd_dvfs_info pointer for the required vdd
> + * @req_dev: device making the request
> + * @target_dev: target device for which frequency request is being made
> + * @freq:	target device frequency
> + *
> + * This API adds a requested frequency into target's device frequency list.

more documentation needed for the reasoning behind why both a requesting
device and a target device are needed.  Also, whey they are needed for
frequency and not voltage.  That might affect my idea above about having
the same function for adding freq/voltage requests.  Even so, the core
part of these functions is identical, so some common functions should
probably be used.

> + * Returns 0 on success.
> + */
> +static int omap_dvfs_add_freq_request(struct omap_vdd_dvfs_info *dvfs_info,
> +	struct device *req_dev, struct device *target_dev, unsigned long freq)
> +{
> +	struct omap_dev_user_list *dev_user = NULL, *tmp_user;
> +	struct omap_vdd_dev_list *temp_dev;

	struct omap_vdd_dev_list *dev_list;

> +	if (!dvfs_info || IS_ERR(dvfs_info)) {
> +		dev_warn(target_dev, "%s: VDD specified does not exist!\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&dvfs_info->scaling_mutex);
> +
> +	list_for_each_entry(temp_dev, &dvfs_info->dev_list, node) {
> +		if (temp_dev->dev == target_dev)

			dev_list = temp_dev;

> +			break;
> +	}
> +	if (temp_dev->dev != target_dev) {

	if (!dev_list) {

> +		dev_warn(target_dev, "%s: target_dev does not exist!\n",
> +			__func__);
> +		mutex_unlock(&dvfs_info->scaling_mutex);
> +		return -EINVAL;
> +	}
> +
> +	plist_for_each_entry(tmp_user, &temp_dev->user_list, node) {
> +		if (tmp_user->dev == req_dev) {
> +			dev_user = tmp_user;
> +			break;
> +		}
> +	}
> +
> +	if (!dev_user) {
> +		dev_user = kzalloc(sizeof(struct omap_dev_user_list),
> +					GFP_KERNEL);
> +		if (!dev_user) {
> +			dev_err(target_dev, "%s: Unable to creat a new user for vdd_%s\n",
> +				__func__, dvfs_info->voltdm->name);
> +			mutex_unlock(&dvfs_info->scaling_mutex);
> +			return -ENOMEM;
> +		}
> +		dev_user->dev = req_dev;
> +	} else {
> +		plist_del(&dev_user->node, &temp_dev->user_list);
> +	}
> +
> +	plist_node_init(&dev_user->node, freq);
> +	plist_add(&dev_user->node, &temp_dev->user_list);
> +
> +	mutex_unlock(&dvfs_info->scaling_mutex);
> +	return 0;
> +}
> +
> +/**
> + * omap_dvfs_remove_freq_request() - Remove the requested device frequency
> + *
> + * @dvfs_info: omap_vdd_dvfs_info pointer for the required vdd
> + * @req_dev: device removing the request
> + * @target_dev: target device from which frequency request is being removed
> + *
> + * This API removes a requested frequency from target's device frequency list.
> + *
> + * Returns 0 on success.
> + */
> +
> +static int omap_dvfs_remove_freq_request(struct omap_vdd_dvfs_info *dvfs_info,
> +	struct device *req_dev, struct device *target_dev)
> +{
> +	struct omap_dev_user_list *dev_user = NULL, *tmp_user;
> +	int ret = 0;
> +	struct omap_vdd_dev_list *temp_dev;
> +
> +	if (!dvfs_info || IS_ERR(dvfs_info)) {
> +		dev_warn(target_dev, "%s: VDD specified does not exist!\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&dvfs_info->scaling_mutex);
> +
> +	list_for_each_entry(temp_dev, &dvfs_info->dev_list, node) {
> +		if (temp_dev->dev == target_dev)
> +			break;
> +	}
> +
> +	if (temp_dev->dev != target_dev) {
> +		dev_warn(target_dev, "%s: target_dev does not exist!\n",
> +			__func__);
> +		mutex_unlock(&dvfs_info->scaling_mutex);
> +		return -EINVAL;
> +	}
> +
> +	plist_for_each_entry(tmp_user, &temp_dev->user_list, node) {
> +		if (tmp_user->dev == req_dev) {
> +			dev_user = tmp_user;
> +			break;
> +		}
> +	}
> +
> +	if (dev_user)
> +		plist_del(&dev_user->node, &temp_dev->user_list);
> +	else {
> +		dev_err(target_dev, "%s: Unable to remove the user for vdd_%s\n",
> +				__func__, dvfs_info->voltdm->name);
> +			ret = -EINVAL;
> +		}
> +
> +	return ret;
> +}
> +
> +/**
> + * omap_dvfs_init() - Initialize omap dvfs layer
> + *
> + * Initalizes omap dvfs layer. It basically allocates memory for
> + * omap_dvfs_info_list and  populates voltdm pointer inside
> + * omap_vdd_dvfs_info structure for all the VDDs.
> + *
> + * Returns 0 on success.
> + */
> +static int __init omap_dvfs_init()
> +{
> +	int i;
> +	struct voltagedomain *vdd_list;

insert blank line

> +	if (cpu_is_omap34xx()) {
> +		omap_nr_vdd = 2;

use ARRAY_SIZE(omap3_vdd)

> +		vdd_list = omap3_vdd;
> +	}

else? 

> +	omap_dvfs_info_list = kzalloc(omap_nr_vdd *
> +			sizeof(struct omap_vdd_dvfs_info), GFP_KERNEL);
> +	if (!omap_dvfs_info_list) {
> +		pr_warning("%s: Unable to allocate memory for vdd_list",
> +			__func__);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < omap_nr_vdd; i++) {
> +		omap_dvfs_info_list[i].voltdm =
> +			omap_voltage_domain_lookup(vdd_list[i].name);
> +		/* Init the plist */

comments redundant

> +		spin_lock_init(&omap_dvfs_info_list[i].user_lock);
> +		plist_head_init(&omap_dvfs_info_list[i].user_list,
> +					&omap_dvfs_info_list[i].user_lock);

ditto

> +		/* Init the DVFS mutex */
> +		mutex_init(&omap_dvfs_info_list[i].scaling_mutex);
> +		/* Init the device list */
 
ditto

> +		INIT_LIST_HEAD(&omap_dvfs_info_list[i].dev_list);


> +	}
> +
> +	return 0;
> +}
> +core_initcall(omap_dvfs_init);
> diff --git a/arch/arm/plat-omap/include/plat/dvfs.h b/arch/arm/plat-omap/include/plat/dvfs.h
> new file mode 100644
> index 0000000..1302990
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/dvfs.h
> @@ -0,0 +1,27 @@
> +/*
> + * OMAP3/OMAP4 DVFS Management Routines
> + *
> + * Author: Vishwanath BS	<vishwanath.bs@ti.com>
> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + * Vishwanath BS <vishwanath.bs@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_DVFS_H
> +#define __ARCH_ARM_MACH_OMAP2_DVFS_H
> +#include <plat/voltage.h>
> +
> +#ifdef CONFIG_PM
> +int omap_dvfs_register_device(struct voltagedomain *voltdm, struct device *dev);
> +#else
> +static inline int omap_dvfs_register_device(struct voltagedomain *voltdm,
> +		struct device *dev)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +#endif
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 57adb27..a84e849 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -86,6 +86,7 @@
>  
>  #include <plat/omap_device.h>
>  #include <plat/omap_hwmod.h>
> +#include <plat/dvfs.h>
>  
>  /* These parameters are passed to _omap_device_{de,}activate() */
>  #define USE_WAKEUP_LAT			0
> @@ -481,6 +482,14 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>  	for (i = 0; i < oh_cnt; i++) {
>  		hwmods[i]->od = od;
>  		_add_optional_clock_alias(od, hwmods[i]);
> +		if (!is_early_device && hwmods[i]->vdd_name) {
> +			struct omap_hwmod *oh = hwmods[i];
> +			struct voltagedomain *voltdm;
> +
> +			voltdm = omap_voltage_domain_lookup(oh->vdd_name);
> +			if (!omap_dvfs_register_device(voltdm, &od->pdev.dev))
> +				oh->voltdm = voltdm;
> +		}

This should be taken out of the for loop.  Otherwise, if an omap_device
has multiple hwmods, then the same devices is registered with DVFS
twice.

>  	}
>  
>  	if (ret)

Kevin
