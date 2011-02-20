From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 03/19] omap3+: voltage: remove initial voltage
Date: Sun, 20 Feb 2011 10:42:12 +0530
Message-ID: <4D60A2AC.1030704@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com> <1298116918-30744-4-git-send-email-nm@ti.com> <bd6822eaf1535de0f30aa64a31c15f6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:51006 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819Ab1BTFMW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Feb 2011 00:12:22 -0500
Received: by yxn22 with SMTP id 22so201778yxn.5
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 21:12:21 -0800 (PST)
In-Reply-To: <bd6822eaf1535de0f30aa64a31c15f6c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

Vishwanath Sripathy wrote, on 02/19/2011 06:54 PM:
[..]
>> omap2_set_init_voltage should setup the curr_volt based on which OPP
>> the system is functioning at. Blindly setting a 1.2v setting in the
>> initial structure may not even match the default voltages stored in
>> the voltage table which are supported for the domain.
>>
>> For example, OMAP3430 core domain does not use 1.2v and ends up
>> generating a warning on the first transition.
>>
[..]
>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
>> omap2/voltage.c
>> index 12be525..280ee12 100644
>> --- a/arch/arm/mach-omap2/voltage.c
>> +++ b/arch/arm/mach-omap2/voltage.c
[..]
>>   	/* Generic voltage parameters */
>> -	vdd->curr_volt = 1200000;
> Where do you update this parameter upon initialization? Shouldn't you read
> the VP register and find the actual current voltage and update this param?

The sequence is as follows:
a) omapx_vdd_data configure is called as part of sr init sequence.
	And the curr_volt with this patch is not updated at this stage.
b) somewhere down in the boot sequence, pm.c's omap2_set_init_voltage 
starts up. This looks up the current clk frequency from clock layer of 
the parent device for the domain, picks up the nominal voltages stored 
in the opp layer, then does a omap_voltage_scale_vdd to that voltage. In 
omap_voltage_scale_vdd, The current voltage is merely picked off the vp 
(in _pre_volt_scale). the last step it does is to setup vdd->curr_volt. 
This can then be used by dvfs layer etc to make appropriate decisions.

So, No, I dont think I need to update it here, it should happen as part 
of the pm init sequence.

Could you explain what problem do you foresee by doing this?

-- 
Regards,
Nishanth Menon
