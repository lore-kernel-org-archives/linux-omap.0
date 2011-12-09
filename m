From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv7 1/3] OMAP: I2C: Reset support
Date: Fri, 09 Dec 2011 12:51:09 +0530
Message-ID: <4EE1B6E5.6080401@ti.com>
References: <1322817674-25384-1-git-send-email-shubhrajyoti@ti.com> <1322817674-25384-2-git-send-email-shubhrajyoti@ti.com> <alpine.DEB.2.00.1112081812530.6289@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1112081812530.6289-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Friday 09 December 2011 06:45 AM, Paul Walmsley wrote:
> Hi
>
> some comments
>
> On Fri, 2 Dec 2011, Shubhrajyoti D wrote:
>
>> Under some error conditions the i2c driver may do a reset.
>> Adding a reset field and support in the device-specific code.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/plat-omap/i2c.c |   18 ++++++++++++++++++
>>  include/linux/i2c-omap.h |    1 +
>>  2 files changed, 19 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
>> index db071bc..883229c 100644
>> --- a/arch/arm/plat-omap/i2c.c
>> +++ b/arch/arm/plat-omap/i2c.c
>> @@ -74,6 +74,22 @@ static struct omap_i2c_bus_platform_data i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
>>  static struct platform_device omap_i2c_devices[] = {
>>  	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
>>  };
>> +/**
>> + * omap2_i2c_reset - reset the omap i2c module.
>> + * @dev: struct device*
>> + */
>> +
>> +static int omap2_i2c_reset(struct device *dev)
>> +{
>> +	int r = 0;
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct omap_device *odev = to_omap_device(pdev);
>> +	struct omap_hwmod *oh;
>> +
>> +	oh = odev->hwmods[0];
>> +	r = omap_hwmod_reset(oh);
>> +	return r;
>> +}
> This function should go into arch/arm/plat-omap/omap_device.c, and it 
agree
> should be renamed to omap_device_reset(), since it's not I2C specific.  
> Also it shouldn't assume that there's only one hwmod - it should iterate 
> over all of the hwmods in the omap_device and call omap_hwmod_reset() on 
> each.
Yes agree will fix in the next version.

>>  
>>  #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
>>  
>> @@ -179,6 +195,8 @@ static inline int omap2_i2c_add_bus(int bus_id)
>>  	 */
>>  	if (cpu_is_omap34xx())
>>  		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
>> +
>> +	pdata->device_reset = omap2_i2c_reset;
> omap_device_reset
>
>>  	pdev = omap_device_build(name, bus_id, oh, pdata,
>>  			sizeof(struct omap_i2c_bus_platform_data),
>>  			NULL, 0, 0);
>> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
>> index 92a0dc7..fd38249 100644
>> --- a/include/linux/i2c-omap.h
>> +++ b/include/linux/i2c-omap.h
>> @@ -35,6 +35,7 @@ struct omap_i2c_bus_platform_data {
>>  	u32		rev;
>>  	u32		flags;
>>  	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
>> +	int		(*device_reset) (struct device *dev);
>>  };
>>  
>>  #endif
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> - Paul
