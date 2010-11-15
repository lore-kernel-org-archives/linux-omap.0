From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v3 3/6] OMAP4: PM: Program correct init voltages for
 scalable VDDs
Date: Mon, 15 Nov 2010 20:21:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035EFF4F6E@dbde02.ent.ti.com>
References: <1288196196-15469-1-git-send-email-thara@ti.com>
 <1288196196-15469-4-git-send-email-thara@ti.com>
 <20101104172010.GB9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56555 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab0KOOv1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 09:51:27 -0500
In-Reply-To: <20101104172010.GB9264@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Tony Lindgren [mailto:tony@atomide.com]
>>Sent: Thursday, November 04, 2010 10:50 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; khilman@deeprootsystems.com;
>>Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v3 3/6] OMAP4: PM: Program correct init voltages for
>>scalable VDDs
>>
>>Hi Thara,
>>
>>* Thara Gopinath <thara@ti.com> [101027 09:08]:
>>> By default the system boots up at nominal voltage for every
>>> voltage domain in the system. This patch puts vdd_mpu, vdd_iva
>>> and vdd_core to the correct boot up voltage as per the opp tables
>>> specified. This patch implements this by matching the rate of
>>> the main clock of the voltage domain with the opp table and
>>> picking up the correct voltage.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/pm.c |    4 ++++
>>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>>> index 353e155..0651667 100644
>>> --- a/arch/arm/mach-omap2/pm.c
>>> +++ b/arch/arm/mach-omap2/pm.c
>>> @@ -211,6 +211,10 @@ static int __init omap2_common_pm_init(void)
>>>  	if (cpu_is_omap34xx()) {
>>>  		omap2_set_init_voltage("mpu", "dpll1_ck", mpu_dev);
>>>  		omap2_set_init_voltage("core", "l3_ick", l3_dev);
>>> +	} else if (cpu_is_omap44xx()) {
>>> +		omap2_set_init_voltage("mpu", "dpll_mpu_ck", mpu_dev);
>>> +		omap2_set_init_voltage("core", "l3_div_ck", l3_dev);
>>> +		omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", iva_dev);
>>>  	}
>>>
>>>  	omap_pm_if_init();
>>
>>In general, we want to avoid adding these "if cpu_is_ompa34xx else if"
>>things all over the place. That makes the code hard to maintain and
>>requires patching all over the place to add support for new omaps.
>>
>>Instead, please do something like this:
>>
>>static int __init omap_common_whatever_init(struct whatever_data *d)
>>{
>>	...
>>
>>	return 0;
>>}
>>
>>static int __init omap3_whatever_init(void)
>>{
>>	struct whatever_data *d;
>>
>>	if (!cpu_is_omap34xx())
>>		return -ENODEV;
>>
>>	/* Initialize omap3 specific things */
>>	...
>>
>>	return omap_common_whatever_init(d);
>>}
>>device_initcall(omap3_whatever_init);
>>
>>static int __init omap4_whatever_init(void)
>>{
>>	struct whatever_data *d;
>>
>>	if (!cpu_is_omap44xx())
>>		return -ENODEV;
>>
>>	/* Initialize omap4 specific things */
>>	...
>>
>>	return omap_common_whatever_init(d);
>>}
>>device_initcall(omap4_whatever_init);
>>...
>>
>>This way the common code stays readable and does not need
>>to be patched when support for new omaps is added. Also the
>>code for unselected omaps gets optimized out and an extra
>>level of code indentation is left out.

Yes. Will take care of this in the next version

Regards
Thara
