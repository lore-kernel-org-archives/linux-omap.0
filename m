From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V2] OMAP4: Intialize IVA Device in addition to DSP device.
Date: Wed, 16 Mar 2011 08:35:18 -0700
Message-ID: <8739mngjt5.fsf@ti.com>
References: <1299926361-28482-1-git-send-email-shweta.gulati@ti.com>
	<AANLkTinympnok4Qw_n15ukDNE2L5yp9xvuhoP64B=2wJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:59455 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752446Ab1CPPf0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Mar 2011 11:35:26 -0400
Received: by yie30 with SMTP id 30so855912yie.37
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 08:35:22 -0700 (PDT)
In-Reply-To: <AANLkTinympnok4Qw_n15ukDNE2L5yp9xvuhoP64B=2wJ@mail.gmail.com>
	(Nishanth Menon's message of "Tue, 15 Mar 2011 10:48:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Menon, Nishanth" <nm@ti.com> writes:

> On Sat, Mar 12, 2011 at 16:09, Shweta Gulati <shweta.gulati@ti.com> w=
rote:
>> OMAP4 has two different Devices IVA and DSP. DSP is bound
>> with IVA for DVFS. The registration of IVA dev in API
>> 'omap2_init_processor_devices' was missing. Init dev for
>> 'iva_dev' is added.
>>
>> This also fixes the following error seen during boot as
>> omap2_set_init_voltage can now find the iva device
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_set_init_voltage: Invalid parameter=
s!
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_set_init_voltage: Unable to put vdd=
_iva to its init voltage
>>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> ---
>>
>> Tested on OMAP4430 SDP Board.
>> Baseline:
>> http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm=
=2Egit
>> Branch :pm-core
>>
>> V2:
>> Rephrased the Commit log.
>>
>> =C2=A0arch/arm/mach-omap2/pm.c | =C2=A0 =C2=A01 +
>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index 30af335..49486f5 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -89,6 +89,7 @@ static void omap2_init_processor_devices(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpu_is_omap44xx()) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_init_omap_de=
vice("l3_main_1", &l3_dev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_init_omap_de=
vice("dsp", &dsp_dev);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _init_omap_device=
("iva", &iva_dev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_init_omap_de=
vice("l3_main", &l3_dev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> --
> Looks fine to me.

Thanks, I'll take this as an ack.

Will queue as a fix for the .39-rc fixes cycle.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
