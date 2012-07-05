From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v1 03/14] ARM: OMAP5: id: Add cpu id for ES versions
Date: Thu, 5 Jul 2012 19:59:45 +0530
Message-ID: <CAMQu2gwChUq4oj1-8N2S5ymK8aCRoM-EwLE+xE-Ri_gLWq+87w@mail.gmail.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
 <1341490136-25901-6-git-send-email-santosh.shilimkar@ti.com> <20120705142637.GD1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:58892 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756046Ab2GEOaH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 10:30:07 -0400
Received: by qcsc21 with SMTP id c21so5666294qcs.21
        for <linux-omap@vger.kernel.org>; Thu, 05 Jul 2012 07:30:05 -0700 (PDT)
In-Reply-To: <20120705142637.GD1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, R Sricharan <r.sricharan@ti.com>

On Thu, Jul 5, 2012 at 7:56 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [120705 05:13]:
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> Adding the OMAP5 ES1.0, 2.0 and OMAP5432 cpu revision
>> detection support.
>>
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -50,6 +50,11 @@ int omap_type(void)
>>               val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
>>       } else if (cpu_is_omap44xx()) {
>>               val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
>> +     } else if (cpu_is_omap54xx()) {
>> +             val = omap_ctrl_readl(OMAP5XXX_CONTROL_STATUS);
>> +             val &= OMAP5_DEVICETYPE_MASK;
>> +             val >>= 6;
>> +             goto out;
>>       } else {
>>               pr_err("Cannot detect omap type!\n");
>>               goto out;
>> @@ -100,7 +105,7 @@ static u16 tap_prod_id;
>>
>>  void omap_get_die_id(struct omap_die_id *odi)
>>  {
>> -     if (cpu_is_omap44xx()) {
>> +     if (cpu_is_omap44xx() || cpu_is_omap54xx()) {
>
> Please update all these patches to use soc_is_omap54xx()
> instead of cpu_is_omap54xx() as that's where we are heading.
>
Damn. We missed to update this. Will fix this and update the
branch. Thanks for pointing it out.

Regards
santosh
