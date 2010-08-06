From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PM-SR][PATCH 09/12] omap3: sr: enable/disable sr only if required
Date: Fri, 06 Aug 2010 05:54:45 -0500
Message-ID: <4C5BE9F5.6090509@gmail.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com> <1281047052-21346-10-git-send-email-nm@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401CD1B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33999 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab0HFKyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 06:54:50 -0400
Received: by yxg6 with SMTP id 6so2798546yxg.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Aug 2010 03:54:49 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032401CD1B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On 08/05/2010 11:51 PM, Gopinath, Thara wrote:
>
>
>>> -----Original Message-----
>>> From: Menon, Nishanth
>>> Sent: Friday, August 06, 2010 3:54 AM
>>> To: linux-omap
>>> Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara
>>> Subject: [PM-SR][PATCH 09/12] omap3: sr: enable/disable sr only if required
>>>
>>> We dont need to go down the path of enabling/disabling the SR
>>> if we dont need to. do some sanity check and trigger if needed
>>>
>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>> Cc: Thara Gopinath<thara@ti.com>
>>>
>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>> ---
>>> arch/arm/mach-omap2/smartreflex.c |   19 +++++++++++++++----
>>> 1 files changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>> index d63691b..9b5a10e 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -778,15 +778,26 @@ static int omap_sr_autocomp_show(void *data, u64 *val)
>>> static int omap_sr_autocomp_store(void *data, u64 val)
>>> {
>>> 	struct omap_sr *sr_info = (struct omap_sr *) data;
>>> +	u32 value = (u32) val;
>>>
>>> 	if (!sr_info) {
>>> 		pr_warning("%s: omap_sr struct for SR not found\n", __func__);
>>> 		return -EINVAL;
>>> 	}
>>> -	if (!val)
>>> -		sr_stop_vddautocomp(sr_info);
>>> -	else
>>> -		sr_start_vddautocomp(sr_info);
>>> +
>>> +	/* Sanity check */
>>> +	if (value&&  (value != 1)) {
>>> +		pr_err("%s: invalid value %d\n", __func__, value);
>>> +		return -EINVAL;
>>> +	}
> Will take this in.
>
>>> +
>>> +	/* change only if needed */
>>> +	if (sr_info->is_autocomp_active ^ value) {
>
> I do not think this is necessary. sr_start_vddautocomp and sr_stop_vddautocomp will take care of
> enabling and disabling intelligently.

hypothesis 1: helper level code is intelligent:
So, lets see where that intelligence exists:
in start autocomp:
static void sr_start_vddautocomp(struct omap_sr *sr) 

{
         if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
                 dev_warn(&sr->pdev->dev,
                         "%s: smartreflex class driver not registered\n",
                         __func__);
                 return;
         }
[NM - Till here we ensured we have an SR class]
         sr->is_autocomp_active = 1;
[NM - aha, we already enabled autocomp]
         if (sr_class->enable(sr->srid))
[NM - this is where the intelligence is -> Class drivers should be now 
intelligent to know if autocomp was previously enabled]
                 sr->is_autocomp_active = 0;
[NM - if we failed we set it then we disable autocomp_active]
}

ok now, lets dig a little further into class3 enable function -> how 
intelligent it really is:
static int sr_class3_enable(int id)
{
         unsigned long volt = 0;

         volt = get_curr_voltage(id);
         if (!volt) {
                 pr_warning("%s: Current voltage unknown.Cannot enable 
SR%d\n",
                                 __func__, id);
                 return -ENODATA;
         }
[NM - so far no intelligence]
         omap_voltageprocessor_enable(id);
[NM - woops we renable voltage processor if we were already enabled]
         return sr_enable(id, volt);
[NM - aha so we are back to Smartreflex core driver for intelligence]
}

digging futher into sr_enable for "intelligent check":
int sr_enable(int srid, unsigned long volt)
{
	u32 nvalue_reciprocal;
	struct omap_volt_data *volt_data;
	struct omap_sr *sr = _sr_lookup(srid);
	int ret;

	if (!sr) {
		pr_warning("%s: omap_sr struct for SR%d not found\n",
			__func__, srid + 1);
		return -EINVAL;
	}

	volt_data = omap_get_volt_data(sr->srid, volt);

	if (IS_ERR(volt_data)) {
		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table"
			" for nominal voltage %ld\n", __func__, volt);
		return -ENODATA;
	}

	nvalue_reciprocal = volt_data->sr_nvalue;

	if (!nvalue_reciprocal) {
		dev_warn(&sr->pdev->dev, "%s: NVALUE = 0 at voltage %ld\n",
			__func__, volt);
		return -ENODATA;
	}
[NM: So far no intelligence]
	/*
	 * errminlimit is opp dependent and hence linked to voltage
	 * if the debug option is enabled, the user might have over ridden
	 * this parameter so do not get it from voltage table
	 */
	if (!enable_sr_vp_debug)
		sr->err_minlimit = volt_data->sr_errminlimit;

	/* Enable the clocks */
	if (!sr->is_sr_enable) {
		struct omap_sr_data *pdata =
				sr->pdev->dev.platform_data;
		if (pdata->device_enable) {
			ret = pdata->device_enable(sr->pdev);
			if (ret)
				return ret;
		} else {
			dev_warn(&sr->pdev->dev, "%s: Not able to turn on SR"
				"clocks during enable. So returning\n",
				__func__);
			return -EPERM;
		}
		sr->is_sr_enable = 1;
	}
[NM: Dont think this matters too much but yeah, we do set is_sr_enable 
to 1 - the fact that we came to this depth implies something is horribly 
screwed up we are in our normal enable flow!!!]
	/* Check if SR is already enabled. If yes do nothing */
	if (sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE)
		return 0;

[NM - this is where the real "intelligence" is - since we already have 
sr_enable set in previous operation in Class3, it will detect and return.

HOWEVER, this "intelligence" will fail miserably in the case of class 2 
or class 1.5]


Hypothesis 2: it is a good practice to do verification of parameters in 
helper functions.

as I show in the previous example, there actual verification is 3 
functions deep and not really a good way of "intelligent" check - for as 
far as I think,
a)  I dont even care to have to pay a single function call penalty that 
I can check with a single if statement
b) as a caller of a function, i make every effort to ensure that the 
parameters that I call the function with are correct and I call it only 
when needed

in short, I dont think your analysis is right, we dont have that 
intelligence there, and my suggestion - it is better to do the check 
before calling a helper function.

Regards,
Nishanth Menon
