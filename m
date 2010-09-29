From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v3 07/11] OMAP3: PM: Adding T2 enabling of smartreflex
 support
Date: Wed, 29 Sep 2010 20:11:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E1739F6@dbde02.ent.ti.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-8-git-send-email-thara@ti.com>
 <87aan19zt4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36074 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030Ab0I2OmF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 10:42:05 -0400
In-Reply-To: <87aan19zt4.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, September 29, 2010 5:38 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v3 07/11] OMAP3: PM: Adding T2 enabling of smartreflex
>>support
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch adds support in the twl4030 driver to hook up
>>> the API enabling smartreflex support on PMIC side with the
>>> smartreflex driver. Without this the OMAP smartreflex modules
>>> will not function.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>This one should be a separate patch with a subject something like
>>
>>     mfd: twl4030: add SmartReflex support
>>
>>and the changelog should indicate its dependency on this SR/voltage
>>series.

Do you mean to say this patch should not be a part of this series at all ??

Regards
Thara
>>
>>Kevin
>>
>>> ---
>>>  drivers/mfd/twl-core.c      |    7 +++++--
>>>  drivers/mfd/twl4030-power.c |   29 +++++++++++++++++++++++++++++
>>>  include/linux/i2c/twl.h     |    1 +
>>>  3 files changed, 35 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
>>> index 720e099..677b903 100644
>>> --- a/drivers/mfd/twl-core.c
>>> +++ b/drivers/mfd/twl-core.c
>>> @@ -1009,8 +1009,11 @@ twl_probe(struct i2c_client *client, const struct
>>i2c_device_id *id)
>>>  	clocks_init(&client->dev, pdata->clock);
>>>
>>>  	/* load power event scripts */
>>> -	if (twl_has_power() && pdata->power)
>>> -		twl4030_power_init(pdata->power);
>>> +	if (twl_has_power()) {
>>> +		twl4030_power_sr_init();
>>> +		 if (pdata->power)
>>> +			twl4030_power_init(pdata->power);
>>> +	}
>>>
>>>  	/* Maybe init the T2 Interrupt subsystem */
>>>  	if (client->irq
>>> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
>>> index 7efa878..6d0ad2d 100644
>>> --- a/drivers/mfd/twl4030-power.c
>>> +++ b/drivers/mfd/twl4030-power.c
>>> @@ -31,6 +31,8 @@
>>>
>>>  #include <asm/mach-types.h>
>>>
>>> +#include <plat/smartreflex.h>
>>> +
>>>  static u8 twl4030_start_script_address = 0x2b;
>>>
>>>  #define PWR_P1_SW_EVENTS	0x10
>>> @@ -63,6 +65,10 @@ static u8 twl4030_start_script_address = 0x2b;
>>>  #define R_MEMORY_ADDRESS	PHY_TO_OFF_PM_MASTER(0x59)
>>>  #define R_MEMORY_DATA		PHY_TO_OFF_PM_MASTER(0x5a)
>>>
>>> +/* Smartreflex Control */
>>> +#define R_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECEIVER(0x61)
>>> +#define CFG_ENABLE_SRFLX	0x08
>>> +
>>>  #define R_PROTECT_KEY		0x0E
>>>  #define R_KEY_1			0xC0
>>>  #define R_KEY_2			0x0C
>>> @@ -511,6 +517,29 @@ int twl4030_remove_script(u8 flags)
>>>  	return err;
>>>  }
>>>
>>> +/* API to enable smrtreflex on Triton side */
>>> +static void twl4030_smartreflex_init(void)
>>> +{
>>> +	int ret = 0;
>>> +	u8 read_val;
>>> +
>>> +	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &read_val,
>>> +			R_DCDC_GLOBAL_CFG);
>>> +	read_val |= CFG_ENABLE_SRFLX;
>>> +	ret |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, read_val,
>>> +			R_DCDC_GLOBAL_CFG);
>>> +}
>>> +
>>> +struct omap_smartreflex_pmic_data twl4030_sr_data = {
>>> +	.sr_pmic_init   = twl4030_smartreflex_init,
>>> +};
>>> +
>>> +void __init twl4030_power_sr_init()
>>> +{
>>> +	/* Register the SR init API with the Smartreflex driver */
>>> +	omap_sr_register_pmic(&twl4030_sr_data);
>>> +}
>>> +
>>>  void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
>>>  {
>>>  	int err = 0;
>>> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
>>> index 6de90bf..b02011e 100644
>>> --- a/include/linux/i2c/twl.h
>>> +++ b/include/linux/i2c/twl.h
>>> @@ -550,6 +550,7 @@ struct twl4030_power_data {
>>>  };
>>>
>>>  extern void twl4030_power_init(struct twl4030_power_data
>>*triton2_scripts);
>>> +extern void twl4030_power_sr_init(void);
>>>  extern int twl4030_remove_script(u8 flags);
>>>
>>>  struct twl4030_codec_audio_data {
