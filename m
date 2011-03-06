From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 05/19] OMAP3+: voltage: use IS_ERR_OR_NULL
Date: Sun, 06 Mar 2011 08:15:06 +0530
Message-ID: <4D72F532.3020909@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>	<1299338962-5602-6-git-send-email-nm@ti.com> <AANLkTi=q_ASfvLbZv=D8p3XvuMX8ek3hcEHU5wtfkm7J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:49329 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752071Ab1CFCpU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 21:45:20 -0500
Received: by gyd12 with SMTP id 12so1694755gyd.2
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 18:45:18 -0800 (PST)
In-Reply-To: <AANLkTi=q_ASfvLbZv=D8p3XvuMX8ek3hcEHU5wtfkm7J@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

David Cohen wrote, on 03/05/2011 11:06 PM:
[..]
>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
>> index 53c399f..76bcaee 100644
>> --- a/arch/arm/mach-omap2/voltage.c
>> +++ b/arch/arm/mach-omap2/voltage.c
>> @@ -682,7 +682,7 @@ unsigned long omap_voltage_get_nom_volt(struct voltagedomain *voltdm)
>>   {
>>         struct omap_vdd_info *vdd;
>>
>> -       if (!voltdm || IS_ERR(voltdm)) {
>> +       if (IS_ERR_OR_NULL(voltdm)) {
>
> I have one comment here. voltdm is received as parameter and it's
> already checked by IS_ERR(). Is there any specific reason for that?
yes:
1. omap_voltage_domain_lookup can return ERR_PTR() in certain conditions
2. the !voltdm is coz of the usage of these APIs from external to 
voltage.c (sr, pm, dvfs etc) - it is possible (and has happend) when 
mistakes have been made and NULL pointers passed as voltdm.


> IS_ERR() doesn't suppose to be a macro to check if the pointer is
> valid or not, but to know if there's an invalid value with error code
> in the pointer value. It's useful when you have a function which
> returns a pointer but it can return an error code when it fails.
> Please, note that IS_ERR() won't detect invalid pointers which does
> not represent an error code, so it's not correct to rely on it for
> this purpose.
> IMO, instead of change to IS_ERR_OR_NULL(), you could only remove
> IS_ERR(). The same apply for the other cases.
no, I am not convinced with your argument.

omap_voltage_get_nom_volt(omap_voltage_domain_lookup("me"));
IS_ERR is useful in this case. If I were to remove vdata, 
PTR_ERR(something)== vdata and vdata !=NULL and it will try to 
dereference and crash.

my_dumb_func(){
	struct voltagedomain *vdata = NULL;
	if (cpu_is_omap3630()_) {
		vdata = omap_voltage_domain_lookup("mpu")
	}
	/* forgot to add other cpu types or a else case */
	/* do other things */
	me_volt=omap_voltage_get_nom_volt(vdata);
	/* do things with me_volt */
}

Sorry, but i think the check, even if seems superfluous is sane IMHO. 
even if the above code worked on 3630, it'd fail on o4/3430 without the 
check, it can even crash. and given that we've all seen our fair share 
of developers who develop for one platform without consideration that 
the rest of the world uses others as well... I do feel cases like above 
example might infact be a reality.

[...]

-- 
Regards,
Nishanth Menon
