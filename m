From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH 06/11] ARM: OMAP2+: Fix voltage scaling init for device tree
Date: Mon, 19 May 2014 20:48:26 +0200
Message-ID: <CAGhQ9Vw38vJCS5TGRMz0MMif15narY=9=C8-vwzGuGormhwcYw@mail.gmail.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
	<1397173639-29587-7-git-send-email-tony@atomide.com>
	<CAGhQ9VxS+Hg6EX=CDxbibV2TFw++LwZY+GQomZEHx--JGuWHNg@mail.gmail.com>
	<20140519180104.GL4849@atomide.com>
	<CAGo_u6oGHFAFimYSc8Utgbp=oCahXzO0ZoYjhFgOkT3YkppS6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53299 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaESSs2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 14:48:28 -0400
Received: by mail-lb0-f174.google.com with SMTP id n15so4416959lbi.33
        for <linux-omap@vger.kernel.org>; Mon, 19 May 2014 11:48:26 -0700 (PDT)
In-Reply-To: <CAGo_u6oGHFAFimYSc8Utgbp=oCahXzO0ZoYjhFgOkT3YkppS6A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 19 May 2014 20:32, Nishanth Menon <nm@ti.com> wrote:
> On Mon, May 19, 2014 at 1:01 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Joachim Eastwood <manabian@gmail.com> [140519 10:51]:
>>> Hi Tony,
>>>
>>> If found this patch in your omap-for-v3.16/pm-signed tag and tested it
>>> on top of Linus master + omap 3.16 dt + Tomi fbdev omap. I assumed
>>> it's going upstream for 3.16(?).
>>
>> Yes.
>>
>>> First of all; is this safe on OMAP4460?
>>> As far as I understand voltage scaling on 4460 has never been
>>> mainline, but this code enables voltage scaling for all omap4 parts.
>>> More below.
>>
>> Sounds like something's not right then. This should just restore
>> the earlier code path we had for legacy booting for omap4.
>>
>>> On 11 April 2014 01:47, Tony Lindgren <tony@atomide.com> wrote:
>>> > We are currently disabling the init of voltage scaling
>>> > for device tree. With the voltage scaling problems fixed
>>> > for omap3 in general, there's no need to disable the voltage
>>> > scaling init for device tree based booting.
>>> >
>>> > Cc: Kevin Hilman <khilman@linaro.org>
>>> > Cc: Nishanth Menon <nm@ti.com>
>>> > Cc: Paul Walmsley <paul@pwsan.com>
>>> > Cc: Tero Kristo <t-kristo@ti.com>
>>> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>>> > ---
>>> >  arch/arm/mach-omap2/pm.c | 28 ++++++++++++----------------
>>> >  1 file changed, 12 insertions(+), 16 deletions(-)
>>> >
>>> > diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>>> > index e1b4141..ccefd11 100644
>>> > --- a/arch/arm/mach-omap2/pm.c
>>> > +++ b/arch/arm/mach-omap2/pm.c
>>> > @@ -287,25 +287,21 @@ omap_postcore_initcall(omap2_common_pm_init);
>>> >
>>> >  int __init omap2_common_pm_late_init(void)
>>> >  {
>>> > -       /*
>>> > -        * In the case of DT, the PMIC and SR initialization will be done using
>>> > -        * a completely different mechanism.
>>> > -        * Disable this part if a DT blob is available.
>>> > -        */
>>> > -       if (!of_have_populated_dt()) {
>>> > -
>>> > -               /* Init the voltage layer */
>>> > -               omap_pmic_late_init();
>>> > -               omap_voltage_late_init();
>>> > +       if (of_have_populated_dt()) {
>>> > +               omap3_twl_init();
>>> > +               omap4_twl_init();
>>> > +       }
>>> >
>>> > -               /* Initialize the voltages */
>>> > -               omap3_init_voltages();
>>> > -               omap4_init_voltages();
>>> > +       /* Init the voltage layer */
>>> > +       omap_pmic_late_init();
>>> > +       omap_voltage_late_init();
>>> >
>>> > -               /* Smartreflex device init */
>>> > -               omap_devinit_smartreflex();
>>> > +       /* Initialize the voltages */
>>> > +       omap3_init_voltages();
>>> > +       omap4_init_voltages();
>>> >
>>> > -       }
>>> > +       /* Smartreflex device init */
>>> > +       omap_devinit_smartreflex();
>>> >
>>> >         /* cpufreq dummy device instantiation */
>>> >         omap_init_cpufreq();
>>> > --
>>>
>>> In omap4_twl_init() we have:
>>> if (!cpu_is_omap44xx())
>>>     return -ENODEV;
>>>
>>> voltdm = voltdm_lookup("mpu");
>>> omap_voltage_register_pmic(voltdm, &omap4_mpu_pmic);
>>>
>>> voltdm = voltdm_lookup("iva");
>>> omap_voltage_register_pmic(voltdm, &omap4_iva_pmic);
>>>
>>> voltdm = voltdm_lookup("core");
>>> omap_voltage_register_pmic(voltdm, &omap4_core_pmic);
>>>
>>> As far as I understand the setup above is only valid for 4430 and not
>>> 4460 since it is hook up to the twl in diffent way. External switcher
>>> (TPS62361) for mpu rail and the other rails are used differently.
>>
>> Hmm interesting, I think we had this enabled with legacy booting?
>>
>>> I also get the following messages on boot now:
>>> [ 2.458740] twl: not initialized
>>> [ 2.462127] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
>>> 1375000 Vs max 1316660
>>> [ 2.470581] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
>>> 1375000 Vs max 1316660
>>> [ 2.479003] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
>>> 1375000 Vs max 1316660
>>> [ 2.487457] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
>>> 1375000 Vs max 1316660
>>> [ 2.495880] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
>>> 1375000 Vs max 1316660
>>> [ 2.504302] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
>>> 1375000 Vs max 1316660
>>> [ 2.512725] twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for
>>> 1410000 Vs max 1316660
>>> [ 2.521179] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
>>> [ 2.528411] omap2_set_init_voltage: unable to set vdd_mpu
>>> [ 2.534088] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
>>> [ 2.541412] omap2_set_init_voltage: unable to set vdd_core
>>> [ 2.547210] omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
>>> [ 2.554443] omap2_set_init_voltage: unable to set vdd_iva
>>>
>>> It doesn't seem too happy on my 4460.
>>
>> Indeed, we need to fix it. Nishant, any comments on how we should
>> deal with this one?
>
>
>
> we can add TPS data here for 4460 mpu (panda-ES) if that is
> interesting to us - given that the common voltage domain/VC/VP stuff
> so far has gone in no positive direction in our discussions last year.

If this means that voltage scaling and 1.5GHz would work for 4460 it
would make me very happy :)
But I assume that would bring lots of more code into mach-omap2 which
wouldn't be good either. Escaping the old 3.4 kernel would be nice,
though.

regards
Joachim Eastwood
