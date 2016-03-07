From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 09/26] mtd: nand: omap: Clean up device tree support
Date: Mon, 7 Mar 2016 11:06:58 +0200
Message-ID: <56DD44B2.9030402@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
 <1455916548-3441-10-git-send-email-rogerq@ti.com>
 <20160305021035.GM55664@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160305021035.GM55664-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/03/16 04:10, Brian Norris wrote:
> A couple of sparse warnings.
> 
> On Fri, Feb 19, 2016 at 11:15:31PM +0200, Roger Quadros wrote:
>> Move NAND specific device tree parsing to NAND driver.
>>
>> The NAND controller node must have a compatible id, register space
>> resource and interrupt resource.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/mach-omap2/gpmc-nand.c              |   5 +-
>>  drivers/memory/omap-gpmc.c                   | 143 +++++++--------------------
>>  drivers/mtd/nand/omap2.c                     | 133 +++++++++++++++++++++----
>>  include/linux/platform_data/mtd-nand-omap2.h |   3 +-
>>  4 files changed, 152 insertions(+), 132 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
>> index 04e6998..f6ac027 100644
>> --- a/arch/arm/mach-omap2/gpmc-nand.c
>> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> 
> [...]
> 
>> @@ -2039,9 +1939,42 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>  		goto err;
>>  	}
>>  
>> -	ret = of_property_read_u32(child, "bank-width", &gpmc_s.device_width);
>> -	if (ret < 0)
>> -		goto err;
>> +	if (of_node_cmp(child->name, "nand") == 0) {
>> +		/* NAND specific setup */
>> +		u32 val;
> 
> drivers/memory/omap-gpmc.c:1952:13: originally declared here [sparse]
> drivers/memory/omap-gpmc.c:2029:21: warning: symbol 'val' shadows an earlier one [sparse]

I'll get rid of this duplicate val.
> 
>> +
>> +		/* Warn about older DT blobs with no compatible property */
>> +		if (!of_property_read_bool(child, "compatible")) {
>> +			dev_warn(&pdev->dev,
>> +				 "Incompatible NAND node: missing compatible");
>> +			ret = -EINVAL;
>> +			goto err;
>> +		}
>> +
> 
> [...]
> 
>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>> index 9e99199..0a637c4 100644
>> --- a/drivers/mtd/nand/omap2.c
>> +++ b/drivers/mtd/nand/omap2.c
> 
> [...]
> 
>> +static int omap_get_dt_info(struct device *dev, struct omap_nand_info *info)
>> +{
>> +	struct device_node *child = dev->of_node;
>> +	int i;
>> +	const char *s;
>> +
>> +	/* In old bindings, CS num is embedded in reg property */
>> +	if (of_property_read_u32(child, "reg", &info->gpmc_cs) < 0) {
> 
> Sparse doesn't like this one:
> 
> drivers/mtd/nand/omap2.c:1660:49: warning: incorrect type in argument 3 (different signedness) [sparse]
> drivers/mtd/nand/omap2.c:1660:49:    expected unsigned int [usertype] *out_value [sparse]
> drivers/mtd/nand/omap2.c:1660:49:    got int *<noident> [sparse]

I'll use a temporary unsigned int variable instead.

> 
>> +		dev_err(dev, "reg not found in DT\n");
>> +		return -EINVAL;
>> +	}
>> +
> 
> [...]
> 

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
