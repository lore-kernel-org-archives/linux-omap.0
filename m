From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 07/19] OMAP3: voltage: add scalable flag to voltagedomain
Date: Thu, 24 Mar 2011 07:12:38 -0700
Message-ID: <87wrjo1uax.fsf@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-8-git-send-email-khilman@ti.com>
	<8989339cfa18407f4caacb718eec831d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:57266 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752665Ab1CXOMo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 10:12:44 -0400
Received: by mail-pz0-f49.google.com with SMTP id 5so1355621pzk.8
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 07:12:41 -0700 (PDT)
In-Reply-To: <8989339cfa18407f4caacb718eec831d@mail.gmail.com> (Vishwanath
	Sripathy's message of "Thu, 24 Mar 2011 10:53:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Vishwanath Sripathy <vishwanath.bs@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Thursday, March 24, 2011 5:30 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Paul Walmsely; Benoit Cousson
>> Subject: [PATCH/RFC 07/19] OMAP3: voltage: add scalable flag to
>> voltagedomain
>>
>> Add a 'bool scalable' flag to the struct powerdomain and set it for
>
> I suppose you meant "struct voltagedomain".

yes

> But shouldn't this flag be part of PMIC struct?
> Voltage scalability depends on the kind of VDD supply from PMIC. So even
> if OMAP supports voltage scaling, we may not be able to scale the voltage
> if PMIC does not support it.

That's a good point.  Probably I can drop this flag and just use the
existence of the various fields of the voltage domain (pmic, vc, vp,
etc.) to determine if the voltdm can scale.

Kevin

>> the MPU_IVA and CORE voltage domains.
>
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>>  arch/arm/mach-omap2/voltage.c                 |    3 +++
>>  arch/arm/mach-omap2/voltage.h                 |    2 ++
>>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 ++
>>  3 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
>> omap2/voltage.c
>> index f995003..bc944ff 100644
>> --- a/arch/arm/mach-omap2/voltage.c
>> +++ b/arch/arm/mach-omap2/voltage.c
>> @@ -1054,6 +1054,9 @@ int __init omap_voltage_late_init(void)
>>  		pr_err("%s: Unable to create voltage debugfs main dir\n",
>>  			__func__);
>>  	list_for_each_entry(voltdm, &voltdm_list, node) {
>> +		if (!voltdm->scalable)
>> +			continue;
>> +
>>  		if (voltdm->vdd) {
>>  			if (omap_vdd_data_configure(voltdm))
>>  				continue;
>> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-
>> omap2/voltage.h
>> index 5440298..25cfb5c 100644
>> --- a/arch/arm/mach-omap2/voltage.h
>> +++ b/arch/arm/mach-omap2/voltage.h
>> @@ -53,11 +53,13 @@ struct omap_vfsm_instance_data {
>>  /**
>>   * struct voltagedomain - omap voltage domain global structure.
>>   * @name: Name of the voltage domain which can be used as a unique
>> identifier.
>> + * @scalable: Whether or not this voltage domain is scalable
>>   * @node: list_head linking all voltage domains
>>   * @vdd: to be removed
>>   */
>>  struct voltagedomain {
>>  	char *name;
>> +	bool scalable;
>>  	struct list_head node;
>>  	struct omap_vdd_info *vdd;
>>  };
>> diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
>> b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
>> index b476ee6..e9664843 100644
>> --- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
>> +++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
>> @@ -61,11 +61,13 @@ static struct omap_vdd_info omap3_vdd2_info =
>> {
>>
>>  static struct voltagedomain omap3_voltdm_mpu = {
>>  	.name = "mpu_iva",
>> +	.scalable = true,
>>  	.vdd = &omap3_vdd1_info,
>>  };
>>
>>  static struct voltagedomain omap3_voltdm_core = {
>>  	.name = "core",
>> +	.scalable = true,
>>  	.vdd = &omap3_vdd2_info,
>>  };
> Why is this applicable only for OMAP3 and not for OMAP4?
>
> Vishwa
>>
>> --
>> 1.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
