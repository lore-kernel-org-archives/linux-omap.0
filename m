From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 3/5] arm: omap3: add common twl configurations for
 vdd1 and vdd2
Date: Fri, 17 Feb 2012 13:06:54 +0200
Message-ID: <1329476814.4102.433.camel@sokoban>
References: <1329388073-17879-1-git-send-email-t-kristo@ti.com>
	 <1329388073-17879-4-git-send-email-t-kristo@ti.com>
	 <CAOMWX4d8C4pjYSr+i3qmqfJHDsHQdtRkvfbGR29U7hXf0SkVZg@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33829 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab2BQLHC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 06:07:02 -0500
In-Reply-To: <CAOMWX4d8C4pjYSr+i3qmqfJHDsHQdtRkvfbGR29U7hXf0SkVZg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 2012-02-16 at 12:23 -0600, Menon, Nishanth wrote:
> On Thu, Feb 16, 2012 at 04:27, Tero Kristo <t-kristo@ti.com> wrote:
> > VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
> > to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
> > are needed by DVFS.
> >
> > Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data manual.
> 
> Please provide documentation version referenced, else we will loose
> track of details at a later point of time.

How should this be marked down? There are too many naming conventions
for the TI docs, and I couldn't find any example from kernel commit logs
for this. Personally I was using twl5030 es1.2 DM rev E / twl4030 es3.1
DM rev L. Or should the literature code be used? Or is there also some
numerical version info available somewhere?

> 
> Also should we rename VDD1 with vdd_mpu_iva and VDD2 as vdd_core to be readable?

This can be changed if needed, it is just a name.
regulator/twl-regulator.c is using vdd1 / vdd2 though, and also
pmic_data struct uses these. All the other regulators use Vxx type
naming also. These are the names I see on my board through
sys/class/regulator:

dummy
VDD1
VDD2
VMMC1
VDAC
VDVI
VSIM


-Tero

> 
> Regards,
> Nishanth Menon
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/twl-common.c |   36 ++++++++++++++++++++++++++++++++++++
> >  1 files changed, 36 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> > index 10b20c6..5f62e51 100644
> > --- a/arch/arm/mach-omap2/twl-common.c
> > +++ b/arch/arm/mach-omap2/twl-common.c
> > @@ -126,6 +126,38 @@ static struct regulator_init_data omap3_vpll2_idata = {
> >        .consumer_supplies              = omap3_vpll2_supplies,
> >  };
> >
> > +static struct regulator_consumer_supply omap3_vdd1_supply[] = {
> > +       REGULATOR_SUPPLY("vcc", "mpu.0"),
> > +};
> > +
> > +static struct regulator_consumer_supply omap3_vdd2_supply[] = {
> > +       REGULATOR_SUPPLY("vcc", "l3_main.0"),
> > +};
> > +
> > +static struct regulator_init_data omap3_vdd1 = {
> > +       .constraints = {
> > +               .name                   = "VDD1",
> > +               .min_uV                 = 600000,
> > +               .max_uV                 = 1450000,
> > +               .valid_modes_mask       = REGULATOR_MODE_NORMAL,
> > +               .valid_ops_mask         = REGULATOR_CHANGE_VOLTAGE,
> > +       },
> > +       .num_consumer_supplies          = ARRAY_SIZE(omap3_vdd1_supply),
> > +       .consumer_supplies              = omap3_vdd1_supply,
> > +};
> > +
> > +static struct regulator_init_data omap3_vdd2 = {
> > +       .constraints = {
> > +               .name                   = "VDD2",
> > +               .min_uV                 = 600000,
> > +               .max_uV                 = 1450000,
> > +               .valid_modes_mask       = REGULATOR_MODE_NORMAL,
> > +               .valid_ops_mask         = REGULATOR_CHANGE_VOLTAGE,
> > +       },
> > +       .num_consumer_supplies          = ARRAY_SIZE(omap3_vdd2_supply),
> > +       .consumer_supplies              = omap3_vdd2_supply,
> > +};
> > +
> >  void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
> >                                  u32 pdata_flags, u32 regulators_flags)
> >  {
> > @@ -133,6 +165,10 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
> >                pmic_data->irq_base = TWL4030_IRQ_BASE;
> >        if (!pmic_data->irq_end)
> >                pmic_data->irq_end = TWL4030_IRQ_END;
> > +       if (!pmic_data->vdd1)
> > +               pmic_data->vdd1 = &omap3_vdd1;
> > +       if (!pmic_data->vdd2)
> > +               pmic_data->vdd2 = &omap3_vdd2;
> >
> >        /* Common platform data configurations */
> >        if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
> > --
> > 1.7.4.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


