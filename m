From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
Date: Fri, 7 Sep 2018 12:20:21 -0500
Message-ID: <e10bdc74-8138-055e-c829-7befbc7161b4@ti.com>
References: <20180829093108.GB22065@amd> <20180907093954.GA26364@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907093954.GA26364@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, lee.jones@linaro.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 09/07/2018 04:39 AM, Pavel Machek wrote:
> On Wed 2018-08-29 11:31:08, Pavel Machek wrote:
>> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>
>> mfd: ti-lmu: constify mfd_cell tables
>>     
>> Add const attribute to all mfd_cell structures.
>>     
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> Lee, I guess this is for you to apply. Any news there?
> 
> There are more patches ready,

As I stated in another email thread.  I don't see the need for this level of LMU framework.

Here is the reference thread

https://lore.kernel.org/patchwork/patch/982550/

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-v4.19
> 
> and it would be good to get them in. (Alternatively, you can just
> cherry-pick them from droid4-pending-v4.19).
> 
> Thanks,
> 							Pavel
> 							
> 
>> diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
>> index cfb411c..990437e 100644
>> --- a/drivers/mfd/ti-lmu.c
>> +++ b/drivers/mfd/ti-lmu.c
>> @@ -25,7 +25,7 @@
>>  #include <linux/slab.h>
>>  
>>  struct ti_lmu_data {
>> -	struct mfd_cell *cells;
>> +	const struct mfd_cell *cells;
>>  	int num_cells;
>>  	unsigned int max_register;
>>  };
>> @@ -63,7 +63,7 @@ static void ti_lmu_disable_hw(struct ti_lmu *lmu)
>>  		gpio_set_value(lmu->en_gpio, 0);
>>  }
>>  
>> -static struct mfd_cell lm3532_devices[] = {
>> +static const struct mfd_cell lm3532_devices[] = {
>>  	{
>>  		.name          = "ti-lmu-backlight",
>>  		.id            = LM3532,
>> @@ -78,7 +78,7 @@ static struct mfd_cell lm3532_devices[] = {
>>  	.of_compatible = "ti,lm363x-regulator",	\
>>  }						\
>>  
>> -static struct mfd_cell lm3631_devices[] = {
>> +static const struct mfd_cell lm3631_devices[] = {
>>  	LM363X_REGULATOR(LM3631_BOOST),
>>  	LM363X_REGULATOR(LM3631_LDO_CONT),
>>  	LM363X_REGULATOR(LM3631_LDO_OREF),
>> @@ -91,7 +91,7 @@ static struct mfd_cell lm3631_devices[] = {
>>  	},
>>  };
>>  
>> -static struct mfd_cell lm3632_devices[] = {
>> +static const struct mfd_cell lm3632_devices[] = {
>>  	LM363X_REGULATOR(LM3632_BOOST),
>>  	LM363X_REGULATOR(LM3632_LDO_POS),
>>  	LM363X_REGULATOR(LM3632_LDO_NEG),
>> @@ -102,7 +102,7 @@ static struct mfd_cell lm3632_devices[] = {
>>  	},
>>  };
>>  
>> -static struct mfd_cell lm3633_devices[] = {
>> +static const struct mfd_cell lm3633_devices[] = {
>>  	{
>>  		.name          = "ti-lmu-backlight",
>>  		.id            = LM3633,
>> @@ -120,7 +120,7 @@ static struct mfd_cell lm3633_devices[] = {
>>  	},
>>  };
>>  
>> -static struct mfd_cell lm3695_devices[] = {
>> +static const struct mfd_cell lm3695_devices[] = {
>>  	{
>>  		.name          = "ti-lmu-backlight",
>>  		.id            = LM3695,
>> @@ -128,7 +128,7 @@ static struct mfd_cell lm3695_devices[] = {
>>  	},
>>  };
>>  
>> -static struct mfd_cell lm3697_devices[] = {
>> +static const struct mfd_cell lm3697_devices[] = {
>>  	{
>>  		.name          = "ti-lmu-backlight",
>>  		.id            = LM3697,
>>
> 
> 
> 


-- 
------------------
Dan Murphy
