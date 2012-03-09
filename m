From: Aneesh V <aneesh@ti.com>
Subject: Re: [PATCH 4/4] misc: emif: add device tree support to emif driver
Date: Fri, 09 Mar 2012 18:20:51 +0530
Message-ID: <4F59FCAB.5040107@ti.com>
References: <1331224437-4808-1-git-send-email-aneesh@ti.com> <1331224437-4808-5-git-send-email-aneesh@ti.com> <20120309053704.E40433E0901@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:59609 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753711Ab2CIMu6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 07:50:58 -0500
Received: by mail-yx0-f178.google.com with SMTP id m14so918043yen.37
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 04:50:57 -0800 (PST)
In-Reply-To: <20120309053704.E40433E0901@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi Grant,

On Friday 09 March 2012 11:07 AM, Grant Likely wrote:
> On Thu,  8 Mar 2012 22:03:57 +0530, Aneesh V<aneesh@ti.com>  wrote:
>> Cc: Rajendra Nayak<rnayak@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Aneesh V<aneesh@ti.com>
>> ---
>> Changes since RFC v4:
>> - Rebased to the latest version of EMIF series
>> - Replace kzalloc()/kfree() with devm_* variants
>> ---
>>   drivers/misc/emif.c |  289 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 files changed, 288 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/misc/emif.c b/drivers/misc/emif.c
>> index 79fb161..0aaa61e 100644
>> --- a/drivers/misc/emif.c
>> +++ b/drivers/misc/emif.c
>> @@ -18,6 +18,7 @@
>>   #include<linux/platform_device.h>
>>   #include<linux/interrupt.h>
>>   #include<linux/slab.h>
>> +#include<linux/of.h>
>>   #include<linux/debugfs.h>
>>   #include<linux/seq_file.h>
>>   #include<linux/module.h>
>> @@ -49,6 +50,7 @@
>>    *				frequency in effect at the moment)
>>    * @plat_data:			Pointer to saved platform data.
>>    * @debugfs_root:		dentry to the root folder for EMIF in debugfs
>> + * @np_ddr:			Pointer to ddr device tree node
>>    */
>>   struct emif_data {
>>   	u8				duplicate;
>> @@ -63,6 +65,9 @@ struct emif_data {
>>   	struct emif_regs		*curr_regs;
>>   	struct emif_platform_data	*plat_data;
>>   	struct dentry			*debugfs_root;
>> +#if defined(CONFIG_OF)
>> +	struct device_node		*np_ddr;
>> +#endif
>
> Don't bother with the #if/#endif wrapper here.

Ok.

>
>>   };
>>
>>   static struct emif_data *emif1;
>> @@ -1147,6 +1152,270 @@ static int is_custom_config_valid(struct emif_custom_configs *cust_cfgs,
>>   	return valid;
>>   }
>>
>> +#if defined(CONFIG_OF)
>> +static void __init of_get_custom_configs(struct device_node *np_emif,
>
> __devinit. Same through the rest of the file.

I am not sure if we need __devinit. I see that __devinit will not have
any effect if CONFIG_HOTPLUG is enabled and CONFIG_HOTPLUG is always
enabled in our configuration. EMIF devices are not hot-pluggable
devices and are always added at boot-time from the board file. They are
on-chip IP modules and dynamic discovery and addition doesn't make
sense for them. So, can't we save some memory by making them __init.

AFAIU, __init doesn't have any effect in a module. However, I can make
that more explicit by using '__init_or_module'. Is that ok?

>
> [...]
>> +	return NULL;
>> +out:
>> +	return emif;
>> +}
>> +#endif
>> +
>>   static struct emif_data * __init get_device_details(
>
> This function also must be __devinit
>
>>   		struct platform_device *pdev)
>>   {
>> @@ -1266,7 +1535,13 @@ static int __init emif_probe(struct platform_device *pdev)
>>   	struct resource		*res;
>>   	int			irq;
>>
>> -	emif = get_device_details(pdev);
>> +#if defined(CONFIG_OF)
>> +	if (pdev->dev.of_node)
>> +		emif = of_get_device_details(pdev->dev.of_node,&pdev->dev);
>> +	else
>> +#endif
>> +		emif = get_device_details(pdev);
>> +
>>   	if (!emif) {
>>   		pr_err("%s: error getting device data\n", __func__);
>>   		goto error;
>> @@ -1643,11 +1918,23 @@ static void __attribute__((unused)) freq_post_notify_handling(void)
>>   	spin_unlock_irqrestore(&emif_lock, irq_state);
>>   }
>>
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id emif_of_match[] = {
>> +		{ .compatible = "ti,emif-4d" },
>> +		{ .compatible = "ti,emif-4d5" },
>> +		{},
>> +};
>> +MODULE_DEVICE_TABLE(of, emif_of_match);
>> +#endif
>> +
>>   static struct platform_driver emif_driver = {
>>   	.remove		= __exit_p(emif_remove),
>
> Not part of this patch I realize, but this is a bug.  .remove must
> be in the __devexit section and the __devexit_p() wrapper must
> be used.  Similarly, emif_probe must be in the __devinit section.

Again, in our case remove() is not needed unless the driver is built as
a module because the devices will never be un-registered. When it is
built as a module the effect is same for both:

#if defined(MODULE) || defined(CONFIG_HOTPLUG)
#define __devexit_p(x) x
#else
#define __devexit_p(x) NULL
#endif

#ifdef MODULE
#define __exit_p(x) x
#else
#define __exit_p(x) NULL
#endif

>
>>   	.shutdown	= emif_shutdown,
>>   	.driver = {
>>   		.name = "emif",
>> +#if defined(CONFIG_OF)
>> +		.of_match_table = of_match_ptr(emif_of_match),
>> +#endif
>
> The of_match_ptr() macro makes the #if/#endif wrapper redundant.

Ok. I will remove it.

>
> Otherwise, on brief review this patch looks right.

Thanks for the review. Are you ok with the bindings too?

br,
Aneesh
