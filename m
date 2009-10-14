From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 2/3] OMAP3: PM: Configure PRM setup times from board
 files
Date: Wed, 14 Oct 2009 17:51:26 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A46CD07@dbde02.ent.ti.com>
References: <873a5njddy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58556 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459AbZJNMWI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 08:22:08 -0400
In-Reply-To: <873a5njddy.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: Wednesday, October 14, 2009 1:05 AM
>To: Nayak, Rajendra
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 2/3] OMAP3: PM: Configure PRM setup times 
>from board files
>
>Rajendra Nayak <rnayak@ti.com> writes:
>
>> The setup times to be programmed in the PRM module on OMAP
>> (for clksetup, voltsetup etc) are board specific.
>> They depend heavily on the PMIC used and even on different boards
>> with the same PMIC, they vary based on the sleep/wake
>> sequence used, system clock speed et al.
>>
>> This patch makes it possible for these setup values to be
>> configured from different board files.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
>[...]
>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index 2242d23..6f2fb51 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -1084,6 +1084,9 @@ int omap3_pm_set_suspend_state(struct 
>powerdomain *pwrdm, int state)
>>  
>>  void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc)
>>  {
>> +	if (!setup_vc)
>> +		return;
>> +
>>  	prm_setup.clksetup = setup_vc->clksetup;
>>  	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
>>  	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
>> @@ -1285,13 +1288,15 @@ static void __init configure_vc(void)
>>  
>>  void omap3_pm_early_init(struct omap_opp *mpu_opps,
>>  			 struct omap_opp *dsp_opps,
>> -			 struct omap_opp *l3_opps)
>> +			 struct omap_opp *l3_opps,
>> +			 struct prm_setup_vc *setup_times)
>>  {
>>  	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
>>  				OMAP3_PRM_POLCTRL_OFFSET);
>>  
>>  	configure_vc();
>>  	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
>> +	omap3_set_prm_setup_vc(setup_times);
>
>I think there's an ordering problem here since the configure_vc()
>which uses the values is called before the setup_vc().

Yes, the ordering seems to be certainly wrong. I will fix that in the
updated patch-set.

>
>Also, if setup_times is passed as NULL, configure_vc() will be writing
>wrong values with undefined results to the VC.

I guess not, since it uses default values from the prm_setup table defined
in pm34xx.c which are not optimal but certainally not wrong. No?
Same is the case with cpuidle params as well.

>
>Also, if my proposed omap3_pm_init_vc() approach is taken and it is
>optional, some sort of defaults should probably be set.
>
>Kevin
>
>
>
>