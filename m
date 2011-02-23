From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 03/19] omap3+: voltage: remove initial voltage
Date: Wed, 23 Feb 2011 13:48:02 +0530
Message-ID: <AANLkTinW+ekEy6uSQcFYYFiUkSYi2h9Mp5q_ct3p5nat@mail.gmail.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com> <1298116918-30744-4-git-send-email-nm@ti.com>
 <bd6822eaf1535de0f30aa64a31c15f6c@mail.gmail.com> <4D60A2AC.1030704@ti.com> <1000eadc0be6e053b04840566bb7c98a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:52974 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754430Ab1BWISY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 03:18:24 -0500
Received: by mail-ww0-f54.google.com with SMTP id 31so8368880wwb.11
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 00:18:23 -0800 (PST)
In-Reply-To: <1000eadc0be6e053b04840566bb7c98a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

 Wed, Feb 23, 2011 at 12:24, Vishwanath Sripathy <vishwanath.bs@ti.com>=
 wrote:
>> -----Original Message-----
>> From: Nishanth Menon [mailto:nm@ti.com]
>> Sent: Sunday, February 20, 2011 10:42 AM
>> To: Vishwanath Sripathy
>> Cc: linux-omap; Tony Lindgren; Kevin Hilman
>> Subject: Re: [PATCH 03/19] omap3+: voltage: remove initial voltage
>>
>> Vishwanath Sripathy wrote, on 02/19/2011 06:54 PM:
>> [..]
>> >> omap2_set_init_voltage should setup the curr_volt based on which
>> OPP
>> >> the system is functioning at. Blindly setting a 1.2v setting in t=
he
>> >> initial structure may not even match the default voltages stored =
in
>> >> the voltage table which are supported for the domain.
>> >>
>> >> For example, OMAP3430 core domain does not use 1.2v and ends up
>> >> generating a warning on the first transition.
>> >>
>> [..]
>> >> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
>> >> omap2/voltage.c
>> >> index 12be525..280ee12 100644
>> >> --- a/arch/arm/mach-omap2/voltage.c
>> >> +++ b/arch/arm/mach-omap2/voltage.c
>> [..]
>> >> =A0 =A0/* Generic voltage parameters */
>> >> - =A0vdd->curr_volt =3D 1200000;
>> > Where do you update this parameter upon initialization? Shouldn't =
you
>> read
>> > the VP register and find the actual current voltage and update thi=
s
>> param?
>>
>> The sequence is as follows:
>> a) omapx_vdd_data configure is called as part of sr init sequence.
>> =A0 =A0 =A0 And the curr_volt with this patch is not updated at this=
 stage.
>> b) somewhere down in the boot sequence, pm.c's
>> omap2_set_init_voltage
>> starts up. This looks up the current clk frequency from clock layer =
of
>> the parent device for the domain, picks up the nominal voltages stor=
ed
>> in the opp layer, then does a omap_voltage_scale_vdd to that voltage=
=2E In
>> omap_voltage_scale_vdd, The current voltage is merely picked off the=
 vp
>> (in _pre_volt_scale). the last step it does is to setup vdd->curr_vo=
lt.
>> This can then be used by dvfs layer etc to make appropriate decision=
s.
>>
>> So, No, I dont think I need to update it here, it should happen as p=
art
>> of the pm init sequence.
>>
>> Could you explain what problem do you foresee by doing this?
> What if omap_voltage_scale_vdd fails when called from
> omap2_set_init_voltage? Or omap2_set_init_voltage returns error even
> before calling omap_voltage_scale_vdd because it could not find the
> matching voltage for the frequency set by bootloader?
>
> Your assumption that curr_volt is always set by omap2_set_init_voltag=
e
> need not be true always.

set_init_voltage's job is to set the initial voltage. if it is
incapable of doing it, I say fix that instead of hacking in some
random number as curr_volt.

The logic involved for set_init_voltage is what we need for filling in
cur_volt. just replicating the logic makes no sense to me.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
