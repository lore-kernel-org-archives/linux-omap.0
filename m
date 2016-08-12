From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v3 2/9] hwmon: (core) New hwmon registration API
Date: Fri, 12 Aug 2016 13:46:04 +0530
Message-ID: <57AD85C4.5020409@ti.com>
References: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
 <1469417552-9749-3-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469417552-9749-3-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Vignesh" <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 25 July 2016 09:02 AM, Guenter Roeck wrote:
> Up to now, each hwmon driver has to implement its own sysfs attributes.
> This requires a lot of template code, and distracts from the driver's core
> function to read and write chip registers.
>
> To be able to reduce driver complexity, move sensor attribute handling
> and thermal zone registration into hwmon core. By using the new API,
> driver code and data size is typically reduced by 20-70%, depending
> on driver complexity and the number of sysfs attributes supported.
>
> With this patch, the new API only supports thermal sensors. Support for
> other sensor types will be added with subsequent patches.
>
Hi Guenter,

Seems like this patch introduces a cycling dependency between
thermal_sys and hwmon:

DEPMOD 4.8.0-rc1-next-20160811-00001-g2f84cf7854e7
depmod: ERROR: Found 2 modules in dependency cycles!
depmod: ERROR: Cycle detected: hwmon -> thermal_sys -> hwmon

As reported by R, Vignesh <vigneshr@ti.com>.

- Keerthy

> Acked-by: Punit Agrawal <punit.agrawal@arm.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3:
> - Thermal registration depends on IS_REACHABLE(CONFIG_THERMAL) and
>    CONFIG_THERMAL_OF.
> v2:
> - Document callback function parameters of struct hwmon_ops in
>    include/linux/hwmon.h.
> - Clarify that the is_visible() callback is mandatory.
> - Initialize device attribute read/write callback functions unconditionally.
> - If an attribute has no template string, treat it as invisible, not as
>    error. Affected are virtual attributes such as HWMON_C_REGISTER_TZ.
> - Added newline to improve readability.
>
> Review comments not addressed:
> - Stick with u32 for attribute masks. We could use u64, but it is currently
>    not needed, and changing it later would be straightforward.
> - Do not use for_each_set_bit() to walk attribute masks.
>    for_each_set_bit() expects a pointer to an unsigned long as argument,
>    which would make it difficult to switch to u64 attribute masks if/when
>    needed.
>
>   drivers/hwmon/hwmon.c | 485 +++++++++++++++++++++++++++++++++++++++++++++++---
>   include/linux/hwmon.h | 148 +++++++++++++++
>   2 files changed, 606 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 649a68d119b4..3e4cc442a089 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -12,6 +12,7 @@
>
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/bitops.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/gfp.h>
> @@ -21,6 +22,7 @@
>   #include <linux/pci.h>
>   #include <linux/slab.h>
>   #include <linux/string.h>
> +#include <linux/thermal.h>
>
>   #define HWMON_ID_PREFIX "hwmon"
>   #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
> @@ -28,9 +30,35 @@
>   struct hwmon_device {
>   	const char *name;
>   	struct device dev;
> +	const struct hwmon_chip_info *chip;
> +
> +	struct attribute_group group;
> +	const struct attribute_group **groups;
>   };
> +
>   #define to_hwmon_device(d) container_of(d, struct hwmon_device, dev)
>
> +struct hwmon_device_attribute {
> +	struct device_attribute dev_attr;
> +	const struct hwmon_ops *ops;
> +	enum hwmon_sensor_types type;
> +	u32 attr;
> +	int index;
> +};
> +
> +#define to_hwmon_attr(d) \
> +	container_of(d, struct hwmon_device_attribute, dev_attr)
> +
> +/*
> + * Thermal zone information
> + * In addition to the reference to the hwmon device,
> + * also provides the sensor index.
> + */
> +struct hwmon_thermal_data {
> +	struct hwmon_device *hwdev;	/* Reference to hwmon device */
> +	int index;			/* sensor index */
> +};
> +
>   static ssize_t
>   show_name(struct device *dev, struct device_attribute *attr, char *buf)
>   {
> @@ -78,25 +106,286 @@ static struct class hwmon_class = {
>
>   static DEFINE_IDA(hwmon_ida);
>
> -/**
> - * hwmon_device_register_with_groups - register w/ hwmon
> - * @dev: the parent device
> - * @name: hwmon name attribute
> - * @drvdata: driver data to attach to created device
> - * @groups: List of attribute groups to create
> - *
> - * hwmon_device_unregister() must be called when the device is no
> - * longer needed.
> - *
> - * Returns the pointer to the new device.
> - */
> -struct device *
> -hwmon_device_register_with_groups(struct device *dev, const char *name,
> -				  void *drvdata,
> -				  const struct attribute_group **groups)
> +/* Thermal zone handling */
> +
> +#if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF)
> +static int hwmon_thermal_get_temp(void *data, int *temp)
> +{
> +	struct hwmon_thermal_data *tdata = data;
> +	struct hwmon_device *hwdev = tdata->hwdev;
> +	int ret;
> +	long t;
> +
> +	ret = hwdev->chip->ops->read(&hwdev->dev, hwmon_temp, hwmon_temp_input,
> +				     tdata->index, &t);
> +	if (ret < 0)
> +		return ret;
> +
> +	*temp = t;
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_of_device_ops hwmon_thermal_ops = {
> +	.get_temp = hwmon_thermal_get_temp,
> +};
> +
> +static int hwmon_thermal_add_sensor(struct device *dev,
> +				    struct hwmon_device *hwdev, int index)
> +{
> +	struct hwmon_thermal_data *tdata;
> +
> +	tdata = devm_kzalloc(dev, sizeof(*tdata), GFP_KERNEL);
> +	if (!tdata)
> +		return -ENOMEM;
> +
> +	tdata->hwdev = hwdev;
> +	tdata->index = index;
> +
> +	devm_thermal_zone_of_sensor_register(&hwdev->dev, index, tdata,
> +					     &hwmon_thermal_ops);
> +
> +	return 0;
> +}
> +#else
> +static int hwmon_thermal_add_sensor(struct device *dev,
> +				    struct hwmon_device *hwdev, int index)
> +{
> +	return 0;
> +}
> +#endif /* IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) */
> +
> +/* sysfs attribute management */
> +
> +static ssize_t hwmon_attr_show(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
> +{
> +	struct hwmon_device_attribute *hattr = to_hwmon_attr(devattr);
> +	long val;
> +	int ret;
> +
> +	ret = hattr->ops->read(dev, hattr->type, hattr->attr, hattr->index,
> +			       &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%ld\n", val);
> +}
> +
> +static ssize_t hwmon_attr_store(struct device *dev,
> +				struct device_attribute *devattr,
> +				const char *buf, size_t count)
> +{
> +	struct hwmon_device_attribute *hattr = to_hwmon_attr(devattr);
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = hattr->ops->write(dev, hattr->type, hattr->attr, hattr->index,
> +				val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static int hwmon_attr_base(enum hwmon_sensor_types type)
> +{
> +	if (type == hwmon_in)
> +		return 0;
> +	return 1;
> +}
> +
> +static struct attribute *hwmon_genattr(struct device *dev,
> +				       const void *drvdata,
> +				       enum hwmon_sensor_types type,
> +				       u32 attr,
> +				       int index,
> +				       const char *template,
> +				       const struct hwmon_ops *ops)
> +{
> +	struct hwmon_device_attribute *hattr;
> +	struct device_attribute *dattr;
> +	struct attribute *a;
> +	umode_t mode;
> +	char *name;
> +
> +	/* The attribute is invisible if there is no template string */
> +	if (!template)
> +		return ERR_PTR(-ENOENT);
> +
> +	mode = ops->is_visible(drvdata, type, attr, index);
> +	if (!mode)
> +		return ERR_PTR(-ENOENT);
> +
> +	if ((mode & S_IRUGO) && !ops->read)
> +		return ERR_PTR(-EINVAL);
> +	if ((mode & S_IWUGO) && !ops->write)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (type == hwmon_chip) {
> +		name = (char *)template;
> +	} else {
> +		name = devm_kzalloc(dev, strlen(template) + 16, GFP_KERNEL);
> +		if (!name)
> +			return ERR_PTR(-ENOMEM);
> +		scnprintf(name, strlen(template) + 16, template,
> +			  index + hwmon_attr_base(type));
> +	}
> +
> +	hattr = devm_kzalloc(dev, sizeof(*hattr), GFP_KERNEL);
> +	if (!hattr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	hattr->type = type;
> +	hattr->attr = attr;
> +	hattr->index = index;
> +	hattr->ops = ops;
> +
> +	dattr = &hattr->dev_attr;
> +	dattr->show = hwmon_attr_show;
> +	dattr->store = hwmon_attr_store;
> +
> +	a = &dattr->attr;
> +	sysfs_attr_init(a);
> +	a->name = name;
> +	a->mode = mode;
> +
> +	return a;
> +}
> +
> +static const char * const hwmon_chip_attr_templates[] = {
> +	[hwmon_chip_temp_reset_history] = "temp_reset_history",
> +	[hwmon_chip_update_interval] = "update_interval",
> +	[hwmon_chip_alarms] = "alarms",
> +};
> +
> +static const char * const hwmon_temp_attr_templates[] = {
> +	[hwmon_temp_input] = "temp%d_input",
> +	[hwmon_temp_type] = "temp%d_type",
> +	[hwmon_temp_lcrit] = "temp%d_lcrit",
> +	[hwmon_temp_lcrit_hyst] = "temp%d_lcrit_hyst",
> +	[hwmon_temp_min] = "temp%d_min",
> +	[hwmon_temp_min_hyst] = "temp%d_min_hyst",
> +	[hwmon_temp_max] = "temp%d_max",
> +	[hwmon_temp_max_hyst] = "temp%d_max_hyst",
> +	[hwmon_temp_crit] = "temp%d_crit",
> +	[hwmon_temp_crit_hyst] = "temp%d_crit_hyst",
> +	[hwmon_temp_emergency] = "temp%d_emergency",
> +	[hwmon_temp_emergency_hyst] = "temp%d_emergency_hyst",
> +	[hwmon_temp_alarm] = "temp%d_alarm",
> +	[hwmon_temp_lcrit_alarm] = "temp%d_lcrit_alarm",
> +	[hwmon_temp_min_alarm] = "temp%d_min_alarm",
> +	[hwmon_temp_max_alarm] = "temp%d_max_alarm",
> +	[hwmon_temp_crit_alarm] = "temp%d_crit_alarm",
> +	[hwmon_temp_emergency_alarm] = "temp%d_emergency_alarm",
> +	[hwmon_temp_fault] = "temp%d_fault",
> +	[hwmon_temp_offset] = "temp%d_offset",
> +	[hwmon_temp_label] = "temp%d_label",
> +	[hwmon_temp_lowest] = "temp%d_lowest",
> +	[hwmon_temp_highest] = "temp%d_highest",
> +	[hwmon_temp_reset_history] = "temp%d_reset_history",
> +};
> +
> +static const char * const *__templates[] = {
> +	[hwmon_chip] = hwmon_chip_attr_templates,
> +	[hwmon_temp] = hwmon_temp_attr_templates,
> +};
> +
> +static const int __templates_size[] = {
> +	[hwmon_chip] = ARRAY_SIZE(hwmon_chip_attr_templates),
> +	[hwmon_temp] = ARRAY_SIZE(hwmon_temp_attr_templates),
> +};
> +
> +static int hwmon_num_channel_attrs(const struct hwmon_channel_info *info)
> +{
> +	int i, n;
> +
> +	for (i = n = 0; info->config[i]; i++)
> +		n += hweight32(info->config[i]);
> +
> +	return n;
> +}
> +
> +static int hwmon_genattrs(struct device *dev,
> +			  const void *drvdata,
> +			  struct attribute **attrs,
> +			  const struct hwmon_ops *ops,
> +			  const struct hwmon_channel_info *info)
> +{
> +	const char * const *templates;
> +	int template_size;
> +	int i, aindex = 0;
> +
> +	if (info->type >= ARRAY_SIZE(__templates))
> +		return -EINVAL;
> +
> +	templates = __templates[info->type];
> +	template_size = __templates_size[info->type];
> +
> +	for (i = 0; info->config[i]; i++) {
> +		u32 attr_mask = info->config[i];
> +		u32 attr;
> +
> +		while (attr_mask) {
> +			struct attribute *a;
> +
> +			attr = __ffs(attr_mask);
> +			attr_mask &= ~BIT(attr);
> +			if (attr >= template_size)
> +				return -EINVAL;
> +			a = hwmon_genattr(dev, drvdata, info->type, attr, i,
> +					  templates[attr], ops);
> +			if (IS_ERR(a)) {
> +				if (PTR_ERR(a) != -ENOENT)
> +					return PTR_ERR(a);
> +				continue;
> +			}
> +			attrs[aindex++] = a;
> +		}
> +	}
> +	return aindex;
> +}
> +
> +static struct attribute **
> +__hwmon_create_attrs(struct device *dev, const void *drvdata,
> +		     const struct hwmon_chip_info *chip)
> +{
> +	int ret, i, aindex = 0, nattrs = 0;
> +	struct attribute **attrs;
> +
> +	for (i = 0; chip->info[i]; i++)
> +		nattrs += hwmon_num_channel_attrs(chip->info[i]);
> +
> +	if (nattrs == 0)
> +		return ERR_PTR(-EINVAL);
> +
> +	attrs = devm_kcalloc(dev, nattrs + 1, sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; chip->info[i]; i++) {
> +		ret = hwmon_genattrs(dev, drvdata, &attrs[aindex], chip->ops,
> +				     chip->info[i]);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +		aindex += ret;
> +	}
> +
> +	return attrs;
> +}
> +
> +static struct device *
> +__hwmon_device_register(struct device *dev, const char *name, void *drvdata,
> +			const struct hwmon_chip_info *chip,
> +			const struct attribute_group **groups)
>   {
>   	struct hwmon_device *hwdev;
> -	int err, id;
> +	struct device *hdev;
> +	int i, j, err, id;
>
>   	/* Do not accept invalid characters in hwmon name attribute */
>   	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
> @@ -112,28 +401,128 @@ hwmon_device_register_with_groups(struct device *dev, const char *name,
>   		goto ida_remove;
>   	}
>
> +	hdev = &hwdev->dev;
> +
> +	if (chip && chip->ops->is_visible) {
> +		struct attribute **attrs;
> +		int ngroups = 2;
> +
> +		if (groups)
> +			for (i = 0; groups[i]; i++)
> +				ngroups++;
> +
> +		hwdev->groups = devm_kcalloc(dev, ngroups, sizeof(*groups),
> +					     GFP_KERNEL);
> +		if (!hwdev->groups)
> +			return ERR_PTR(-ENOMEM);
> +
> +		attrs = __hwmon_create_attrs(dev, drvdata, chip);
> +		if (IS_ERR(attrs)) {
> +			err = PTR_ERR(attrs);
> +			goto free_hwmon;
> +		}
> +
> +		hwdev->group.attrs = attrs;
> +		ngroups = 0;
> +		hwdev->groups[ngroups++] = &hwdev->group;
> +
> +		if (groups) {
> +			for (i = 0; groups[i]; i++)
> +				hwdev->groups[ngroups++] = groups[i];
> +		}
> +
> +		hdev->groups = hwdev->groups;
> +	} else {
> +		hdev->groups = groups;
> +	}
> +
>   	hwdev->name = name;
> -	hwdev->dev.class = &hwmon_class;
> -	hwdev->dev.parent = dev;
> -	hwdev->dev.groups = groups;
> -	hwdev->dev.of_node = dev ? dev->of_node : NULL;
> -	dev_set_drvdata(&hwdev->dev, drvdata);
> -	dev_set_name(&hwdev->dev, HWMON_ID_FORMAT, id);
> -	err = device_register(&hwdev->dev);
> +	hdev->class = &hwmon_class;
> +	hdev->parent = dev;
> +	hdev->of_node = dev ? dev->of_node : NULL;
> +	hwdev->chip = chip;
> +	dev_set_drvdata(hdev, drvdata);
> +	dev_set_name(hdev, HWMON_ID_FORMAT, id);
> +	err = device_register(hdev);
>   	if (err)
> -		goto free;
> +		goto free_hwmon;
> +
> +	if (chip && chip->ops->is_visible && chip->ops->read &&
> +	    chip->info[0]->type == hwmon_chip &&
> +	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
> +		const struct hwmon_channel_info **info = chip->info;
> +
> +		for (i = 1; info[i]; i++) {
> +			if (info[i]->type != hwmon_temp)
> +				continue;
> +
> +			for (j = 0; info[i]->config[j]; j++) {
> +				if (!chip->ops->is_visible(drvdata, hwmon_temp,
> +							   hwmon_temp_input, j))
> +					continue;
> +				if (info[i]->config[j] & HWMON_T_INPUT)
> +					hwmon_thermal_add_sensor(dev, hwdev, j);
> +			}
> +		}
> +	}
>
> -	return &hwdev->dev;
> +	return hdev;
>
> -free:
> +free_hwmon:
>   	kfree(hwdev);
>   ida_remove:
>   	ida_simple_remove(&hwmon_ida, id);
>   	return ERR_PTR(err);
>   }
> +
> +/**
> + * hwmon_device_register_with_groups - register w/ hwmon
> + * @dev: the parent device
> + * @name: hwmon name attribute
> + * @drvdata: driver data to attach to created device
> + * @groups: List of attribute groups to create
> + *
> + * hwmon_device_unregister() must be called when the device is no
> + * longer needed.
> + *
> + * Returns the pointer to the new device.
> + */
> +struct device *
> +hwmon_device_register_with_groups(struct device *dev, const char *name,
> +				  void *drvdata,
> +				  const struct attribute_group **groups)
> +{
> +	return __hwmon_device_register(dev, name, drvdata, NULL, groups);
> +}
>   EXPORT_SYMBOL_GPL(hwmon_device_register_with_groups);
>
>   /**
> + * hwmon_device_register_with_info - register w/ hwmon
> + * @dev: the parent device
> + * @name: hwmon name attribute
> + * @drvdata: driver data to attach to created device
> + * @info: Pointer to hwmon chip information
> + * @groups - pointer to list of driver specific attribute groups
> + *
> + * hwmon_device_unregister() must be called when the device is no
> + * longer needed.
> + *
> + * Returns the pointer to the new device.
> + */
> +struct device *
> +hwmon_device_register_with_info(struct device *dev, const char *name,
> +				void *drvdata,
> +				const struct hwmon_chip_info *chip,
> +				const struct attribute_group **groups)
> +{
> +	if (chip && (!chip->ops || !chip->info))
> +		return ERR_PTR(-EINVAL);
> +
> +	return __hwmon_device_register(dev, name, drvdata, chip, groups);
> +}
> +EXPORT_SYMBOL_GPL(hwmon_device_register_with_info);
> +
> +/**
>    * hwmon_device_register - register w/ hwmon
>    * @dev: the device to register
>    *
> @@ -211,6 +600,48 @@ error:
>   }
>   EXPORT_SYMBOL_GPL(devm_hwmon_device_register_with_groups);
>
> +/**
> + * devm_hwmon_device_register_with_info - register w/ hwmon
> + * @dev: the parent device
> + * @name: hwmon name attribute
> + * @drvdata: driver data to attach to created device
> + * @info: Pointer to hwmon chip information
> + * @groups - pointer to list of driver specific attribute groups
> + *
> + * Returns the pointer to the new device. The new device is automatically
> + * unregistered with the parent device.
> + */
> +struct device *
> +devm_hwmon_device_register_with_info(struct device *dev, const char *name,
> +				     void *drvdata,
> +				     const struct hwmon_chip_info *chip,
> +				     const struct attribute_group **groups)
> +{
> +	struct device **ptr, *hwdev;
> +
> +	if (!dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	ptr = devres_alloc(devm_hwmon_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	hwdev = hwmon_device_register_with_info(dev, name, drvdata, chip,
> +						groups);
> +	if (IS_ERR(hwdev))
> +		goto error;
> +
> +	*ptr = hwdev;
> +	devres_add(dev, ptr);
> +
> +	return hwdev;
> +
> +error:
> +	devres_free(ptr);
> +	return hwdev;
> +}
> +EXPORT_SYMBOL_GPL(devm_hwmon_device_register_with_info);
> +
>   static int devm_hwmon_match(struct device *dev, void *res, void *data)
>   {
>   	struct device **hwdev = res;
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index 09354f6c1d63..52e56d71d742 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -14,9 +14,147 @@
>   #ifndef _HWMON_H_
>   #define _HWMON_H_
>
> +#include <linux/bitops.h>
> +
>   struct device;
>   struct attribute_group;
>
> +enum hwmon_sensor_types {
> +	hwmon_chip,
> +	hwmon_temp,
> +	hwmon_in,
> +	hwmon_curr,
> +	hwmon_power,
> +	hwmon_energy,
> +};
> +
> +enum hwmon_chip_attributes {
> +	hwmon_chip_temp_reset_history,
> +	hwmon_chip_register_tz,
> +	hwmon_chip_update_interval,
> +	hwmon_chip_alarms,
> +};
> +
> +#define HWMON_C_TEMP_RESET_HISTORY	BIT(hwmon_chip_temp_reset_history)
> +#define HWMON_C_IN_RESET_HISTORY	BIT(hwmon_chip_in_reset_history)
> +#define HWMON_C_REGISTER_TZ		BIT(hwmon_chip_register_tz)
> +#define HWMON_C_UPDATE_INTERVAL		BIT(hwmon_chip_update_interval)
> +#define HWMON_C_ALARMS			BIT(hwmon_chip_alarms)
> +
> +enum hwmon_temp_attributes {
> +	hwmon_temp_input = 0,
> +	hwmon_temp_type,
> +	hwmon_temp_lcrit,
> +	hwmon_temp_lcrit_hyst,
> +	hwmon_temp_min,
> +	hwmon_temp_min_hyst,
> +	hwmon_temp_max,
> +	hwmon_temp_max_hyst,
> +	hwmon_temp_crit,
> +	hwmon_temp_crit_hyst,
> +	hwmon_temp_emergency,
> +	hwmon_temp_emergency_hyst,
> +	hwmon_temp_alarm,
> +	hwmon_temp_lcrit_alarm,
> +	hwmon_temp_min_alarm,
> +	hwmon_temp_max_alarm,
> +	hwmon_temp_crit_alarm,
> +	hwmon_temp_emergency_alarm,
> +	hwmon_temp_fault,
> +	hwmon_temp_offset,
> +	hwmon_temp_label,
> +	hwmon_temp_lowest,
> +	hwmon_temp_highest,
> +	hwmon_temp_reset_history,
> +};
> +
> +#define HWMON_T_INPUT		BIT(hwmon_temp_input)
> +#define HWMON_T_TYPE		BIT(hwmon_temp_type)
> +#define HWMON_T_LCRIT		BIT(hwmon_temp_lcrit)
> +#define HWMON_T_LCRIT_HYST	BIT(hwmon_temp_lcrit_hyst)
> +#define HWMON_T_MIN		BIT(hwmon_temp_min)
> +#define HWMON_T_MIN_HYST	BIT(hwmon_temp_min_hyst)
> +#define HWMON_T_MAX		BIT(hwmon_temp_max)
> +#define HWMON_T_MAX_HYST	BIT(hwmon_temp_max_hyst)
> +#define HWMON_T_CRIT		BIT(hwmon_temp_crit)
> +#define HWMON_T_CRIT_HYST	BIT(hwmon_temp_crit_hyst)
> +#define HWMON_T_EMERGENCY	BIT(hwmon_temp_emergency)
> +#define HWMON_T_EMERGENCY_HYST	BIT(hwmon_temp_emergency_hyst)
> +#define HWMON_T_MIN_ALARM	BIT(hwmon_temp_min_alarm)
> +#define HWMON_T_MAX_ALARM	BIT(hwmon_temp_max_alarm)
> +#define HWMON_T_CRIT_ALARM	BIT(hwmon_temp_crit_alarm)
> +#define HWMON_T_EMERGENCY_ALARM	BIT(hwmon_temp_emergency_alarm)
> +#define HWMON_T_FAULT		BIT(hwmon_temp_fault)
> +#define HWMON_T_OFFSET		BIT(hwmon_temp_offset)
> +#define HWMON_T_LABEL		BIT(hwmon_temp_label)
> +#define HWMON_T_LOWEST		BIT(hwmon_temp_lowest)
> +#define HWMON_T_HIGHEST		BIT(hwmon_temp_highest)
> +#define HWMON_T_RESET_HISTORY	BIT(hwmon_temp_reset_history)
> +
> +/**
> + * struct hwmon_ops - hwmon device operations
> + * @is_visible: Callback to return attribute visibility. Mandatory.
> + *		Parameters are:
> + *		@const void *drvdata:
> + *			Pointer to driver-private data structure passed
> + *			as argument to hwmon_device_register_with_info().
> + *		@type:	Sensor type
> + *		@attr:	Sensor attribute
> + *		@channel:
> + *			Channel number
> + *		The function returns the file permissions.
> + *		If the return value is 0, no attribute will be created.
> + * @read:       Read callback. Optional. If not provided, attributes
> + *		will not be readable.
> + *		Parameters are:
> + *		@dev:	Pointer to hardware monitoring device
> + *		@type:	Sensor type
> + *		@attr:	Sensor attribute
> + *		@channel:
> + *			Channel number
> + *		@val:	Pointer to returned value
> + *		The function returns 0 on success or a negative error number.
> + * @write:	Write callback. Optional. If not provided, attributes
> + *		will not be writable.
> + *		Parameters are:
> + *		@dev:	Pointer to hardware monitoring device
> + *		@type:	Sensor type
> + *		@attr:	Sensor attribute
> + *		@channel:
> + *			Channel number
> + *		@val:	Value to write
> + *		The function returns 0 on success or a negative error number.
> + */
> +struct hwmon_ops {
> +	umode_t (*is_visible)(const void *drvdata, enum hwmon_sensor_types type,
> +			      u32 attr, int channel);
> +	int (*read)(struct device *dev, enum hwmon_sensor_types type,
> +		    u32 attr, int channel, long *val);
> +	int (*write)(struct device *dev, enum hwmon_sensor_types type,
> +		     u32 attr, int channel, long val);
> +};
> +
> +/**
> + * Channel information
> + * @type:	Channel type.
> + * @config:	Pointer to NULL-terminated list of channel parameters.
> + *		Use for per-channel attributes.
> + */
> +struct hwmon_channel_info {
> +	enum hwmon_sensor_types type;
> +	const u32 *config;
> +};
> +
> +/**
> + * Chip configuration
> + * @ops:	Pointer to hwmon operations.
> + * @info:	Null-terminated list of channel information.
> + */
> +struct hwmon_chip_info {
> +	const struct hwmon_ops *ops;
> +	const struct hwmon_channel_info **info;
> +};
> +
>   struct device *hwmon_device_register(struct device *dev);
>   struct device *
>   hwmon_device_register_with_groups(struct device *dev, const char *name,
> @@ -26,6 +164,16 @@ struct device *
>   devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
>   				       void *drvdata,
>   				       const struct attribute_group **groups);
> +struct device *
> +hwmon_device_register_with_info(struct device *dev,
> +				const char *name, void *drvdata,
> +				const struct hwmon_chip_info *info,
> +				const struct attribute_group **groups);
> +struct device *
> +devm_hwmon_device_register_with_info(struct device *dev,
> +				     const char *name, void *drvdata,
> +				     const struct hwmon_chip_info *info,
> +				     const struct attribute_group **groups);
>
>   void hwmon_device_unregister(struct device *dev);
>   void devm_hwmon_device_unregister(struct device *dev);
>
