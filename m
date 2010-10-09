From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv3 11/17] dmtimer: early boot infrastructure
Date: Sat, 9 Oct 2010 20:37:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E840682@dbde02.ent.ti.com>
References: <1285059286-26566-1-git-send-email-tarun.kanti@ti.com>
 <4CA505EC.7070105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59436 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab0JIPHc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Oct 2010 11:07:32 -0400
In-Reply-To: <4CA505EC.7070105@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Benoit,

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Friday, October 01, 2010 3:20 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Paul Walmsley; Kevin Hilman; Tony Lindgren
> Subject: Re: [PATCHv3 11/17] dmtimer: early boot infrastructure
>
> On 9/21/2010 10:54 AM, DebBarma, Tarun Kanti wrote:
> > During dmtimer early init, when device model is not up yet and dmtimer
> > devices are not yet registered, the initialization routine is unable
> > to read clock sources supported by the dmtimers using clk_get() because
> > it searches the list using device names. This problem is overcome by
> > assigning timer device names to the .init_name field. The advantage is
> > that there is one common set of routines for clock access routines for
> > early init and normal access.
> >
> > This patch also modifies the name of millisecond timers (1,2,10) on
> > OMAP3 and OMAP4 from"timer_1ms" to "timer". This means all timers
>
> typo
Thanks, will take care!

>
> So here is the change that is mentioned already in the code 6 patches
> before...
> You don't have to split that in 2 patches. You can introduce the new
> name in the first hwmod data patch since that will not impact your code.
> Moreover that will avoid discrepancies between the comments in the code
> and the code.
Ok.

>
> > now have common name. This is to allow any one of the available timers
> > as an early timer instead of restricting it just to millisecond timers.
> > The hwmod routine which searches by class name can now search and find
> > all timers for initialization and bind to device model during early
> init.
> >
> > Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> > Cc: Cousson, Benoit<b-cousson@ti.com>
> > Cc: Paul Walmsley<paul@pwsan.com>
> > Cc: Kevin Hilman<khilman@deeprootsystems.com>
> > Cc: Tony Lindgren<tony@atomide.com>
> > ---
> >   arch/arm/mach-omap2/omap_hwmod_2420_data.c |   91
> ++++++++++++++++++++++++++++
> >   arch/arm/mach-omap2/omap_hwmod_2430_data.c |   91
> ++++++++++++++++++++++++++++
> >   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   86
> ++++++++++++++++++++++++++-
> >   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   86
> ++++++++++++++++++++++++++-
> >   4 files changed, 352 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-
> omap2/omap_hwmod_2420_data.c
> > index b3dd8ac..fc761a5 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> > @@ -177,6 +177,85 @@ static struct omap_hwmod_class
> omap2420_timer_hwmod_class = {
> >          .rev = OMAP_TIMER_IP_VERSION_1,
> >   };
> >
> > +/*
> > + * during dmtimer early init, when device model is not up yet and
> dmtimer
> > + * devices are not yet registered, the initialization routine is unable
> > + * to read clock sources supported by the dmtimers using clk_get()
> because
> > + * it searches the list using device names. this problem is overcome by
> > + * assigning timer device names to the .init_name field.
> > + */
> > +static struct omap_device timer1_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.0" },
>
> And here is the reason why you added an include to omap_device.h 8
> patches ago.
>
> You should not do that, at all. hwmod is about SOC HW information only.
> It will be use by omap_device, but it does not have to know anything
> about the layer above it.
> Moreover, in that case, you can easily extract the device name using the
> hwmod name, so you can build these devices dynamically and only if
> needed at init time.
Thanks, I will change the design.
>
> > +       },
> > +};
> > +
> > +static struct omap_device timer2_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.1" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer3_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.2" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer4_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.3" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer5_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.4" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer6_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.5" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer7_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.6" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer8_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.7" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer9_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.8" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer10_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.9" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer11_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.10" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer12_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.11" },
> > +       },
> > +};
> > +
> >   /* timer1 */
> >   static struct omap_hwmod omap2420_timer1_hwmod;
> >   static struct omap_hwmod_irq_info omap2420_timer1_mpu_irqs[] = {
> > @@ -223,6 +302,7 @@ static struct omap_hwmod omap2420_timer1_hwmod = {
> >          .slaves         = omap2420_timer1_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer1_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer1_init_name,
>
> And don't do that either... this is internal pointer populated during
> omap_device_build.
> This is not HW related information at all.
Ok, I will change.

>
> That's enough for today, I'll try to finalize the review tomorrow.
>
Appreciate all your valuable inputs!!
-tarun

>
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -272,6 +352,7 @@ static struct omap_hwmod omap2420_timer2_hwmod = {
> >          .slaves         = omap2420_timer2_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer2_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer2_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -321,6 +402,7 @@ static struct omap_hwmod omap2420_timer3_hwmod = {
> >          .slaves         = omap2420_timer3_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer3_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer3_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -368,6 +450,7 @@ static struct omap_hwmod omap2420_timer4_hwmod = {
> >          .slaves         = omap2420_timer4_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer4_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer4_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -417,6 +500,7 @@ static struct omap_hwmod omap2420_timer5_hwmod = {
> >          .slaves         = omap2420_timer5_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer5_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer5_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -466,6 +550,7 @@ static struct omap_hwmod omap2420_timer6_hwmod = {
> >          .slaves         = omap2420_timer6_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer6_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer6_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -514,6 +599,7 @@ static struct omap_hwmod omap2420_timer7_hwmod = {
> >          .slaves         = omap2420_timer7_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer7_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer7_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -562,6 +648,7 @@ static struct omap_hwmod omap2420_timer8_hwmod = {
> >          .slaves         = omap2420_timer8_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer8_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer8_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -610,6 +697,7 @@ static struct omap_hwmod omap2420_timer9_hwmod = {
> >          .slaves         = omap2420_timer9_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer9_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer9_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -658,6 +746,7 @@ static struct omap_hwmod omap2420_timer10_hwmod = {
> >          .slaves         = omap2420_timer10_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer10_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer10_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -706,6 +795,7 @@ static struct omap_hwmod omap2420_timer11_hwmod = {
> >          .slaves         = omap2420_timer11_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer11_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer11_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > @@ -754,6 +844,7 @@ static struct omap_hwmod omap2420_timer12_hwmod = {
> >          .slaves         = omap2420_timer12_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2420_timer12_slaves),
> >          .class          =&omap2420_timer_hwmod_class,
> > +       .od             =&timer12_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
> >   };
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-
> omap2/omap_hwmod_2430_data.c
> > index 787d3ce..2ac463f 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > @@ -183,6 +183,85 @@ static struct omap_hwmod_class
> omap2430_timer_hwmod_class = {
> >          .rev = OMAP_TIMER_IP_VERSION_1,
> >   };
> >
> > +/*
> > + * during dmtimer early init, when device model is not up yet and
> dmtimer
> > + * devices are not yet registered, the initialization routine is unable
> > + * to read clock sources supported by the dmtimers using clk_get()
> because
> > + * it searches the list using device names. this problem is overcome by
> > + * assigning timer device names to the .init_name field.
> > + */
> > +static struct omap_device timer1_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.0" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer2_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.1" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer3_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.2" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer4_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.3" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer5_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.4" },
> > +       },
> > +};
> > +
> > +
> > +static struct omap_device timer6_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.5" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer7_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.6" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer8_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.7" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer9_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.8" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer10_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.9" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer11_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.10" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer12_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.11" },
> > +       },
> > +};
> >
> >   /* timer1 */
> >   static struct omap_hwmod omap2430_timer1_hwmod;
> > @@ -232,6 +311,7 @@ static struct omap_hwmod omap2430_timer1_hwmod = {
> >          .slaves         = omap2430_timer1_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer1_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer1_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -281,6 +361,7 @@ static struct omap_hwmod omap2430_timer2_hwmod = {
> >          .slaves         = omap2430_timer2_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer2_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer2_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -328,6 +409,7 @@ static struct omap_hwmod omap2430_timer3_hwmod = {
> >          .slaves         = omap2430_timer3_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer3_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer3_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -377,6 +459,7 @@ static struct omap_hwmod omap2430_timer4_hwmod = {
> >          .slaves         = omap2430_timer4_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer4_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer4_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -424,6 +507,7 @@ static struct omap_hwmod omap2430_timer5_hwmod = {
> >          .slaves         = omap2430_timer5_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer5_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer5_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -472,6 +556,7 @@ static struct omap_hwmod omap2430_timer6_hwmod = {
> >          .slaves         = omap2430_timer6_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer6_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer6_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -520,6 +605,7 @@ static struct omap_hwmod omap2430_timer7_hwmod = {
> >          .slaves         = omap2430_timer7_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer7_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer7_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -567,6 +653,7 @@ static struct omap_hwmod omap2430_timer8_hwmod = {
> >          .slaves         = omap2430_timer8_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer8_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer8_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -615,6 +702,7 @@ static struct omap_hwmod omap2430_timer9_hwmod = {
> >          .slaves         = omap2430_timer9_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer9_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer9_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -662,6 +750,7 @@ static struct omap_hwmod omap2430_timer10_hwmod = {
> >          .slaves         = omap2430_timer10_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer10_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer10_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -709,6 +798,7 @@ static struct omap_hwmod omap2430_timer11_hwmod = {
> >          .slaves         = omap2430_timer11_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer11_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer11_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > @@ -757,6 +847,7 @@ static struct omap_hwmod omap2430_timer12_hwmod = {
> >          .slaves         = omap2430_timer12_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap2430_timer12_slaves),
> >          .class          =&omap2430_timer_hwmod_class,
> > +       .od             =&timer12_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >   };
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-
> omap2/omap_hwmod_3xxx_data.c
> > index 4765cda..1ce40e0 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> > @@ -151,7 +151,7 @@ static struct omap_hwmod_class_sysconfig
> omap3xxx_timer_1ms_sysc = {
> >   };
> >
> >   static struct omap_hwmod_class omap3xxx_timer_1ms_hwmod_class = {
> > -       .name = "timer_1ms",
> > +       .name = "timer",
> >          .sysc =&omap3xxx_timer_1ms_sysc,
> >          .rev = OMAP_TIMER_IP_VERSION_1,
> >   };
> > @@ -180,6 +180,79 @@ static struct omap_hwmod_class
> omap3xxx_timer_hwmod_class = {
> >          .rev =  OMAP_TIMER_IP_VERSION_1,
> >   };
> >
> > +/*
> > + * during dmtimer early init, when device model is not up yet and
> dmtimer
> > + * devices are not yet registered, the initialization routine is unable
> > + * to read clock sources supported by the dmtimers using clk_get()
> because
> > + * it searches the list using device names. this problem is overcome by
> > + * assigning timer device names to the .init_name field.
> > + */
> > +static struct omap_device timer1_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.0" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer2_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.1" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer3_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.2" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer4_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.3" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer5_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.4" },
> > +       },
> > +};
> > +
> > +
> > +static struct omap_device timer6_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.5" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer7_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.6" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer8_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.7" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer9_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.8" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer10_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.9" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer11_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.10" },
> > +       },
> > +};
> >
> >   /* timer10 */
> >   static struct omap_hwmod omap3xxx_timer10_hwmod;
> > @@ -236,6 +309,7 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
> >          .slaves         = omap3xxx_timer10_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer10_slaves),
> >          .class          =&omap3xxx_timer_1ms_hwmod_class,
> > +       .od             =&timer10_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > @@ -294,6 +368,7 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
> >          .slaves         = omap3xxx_timer11_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer11_slaves),
> >          .class          =&omap3xxx_timer_hwmod_class,
> > +       .od             =&timer11_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > @@ -364,6 +439,7 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
> >          .slaves         = omap3xxx_timer2_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer2_slaves),
> >          .class          =&omap3xxx_timer_1ms_hwmod_class,
> > +       .od             =&timer2_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > @@ -422,6 +498,7 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
> >          .slaves         = omap3xxx_timer3_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer3_slaves),
> >          .class          =&omap3xxx_timer_hwmod_class,
> > +       .od             =&timer3_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > @@ -480,6 +557,7 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
> >          .slaves         = omap3xxx_timer4_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer4_slaves),
> >          .class          =&omap3xxx_timer_hwmod_class,
> > +       .od             =&timer4_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > @@ -538,6 +616,7 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
> >          .slaves         = omap3xxx_timer5_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer5_slaves),
> >          .class          =&omap3xxx_timer_hwmod_class,
> > +       .od             =&timer5_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > @@ -595,6 +674,7 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
> >          .slaves         = omap3xxx_timer6_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer6_slaves),
> >          .class          =&omap3xxx_timer_hwmod_class,
> > +       .od             =&timer6_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > @@ -653,6 +733,7 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
> >          .slaves         = omap3xxx_timer7_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer7_slaves),
> >          .class          =&omap3xxx_timer_hwmod_class,
> > +       .od             =&timer7_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > @@ -711,6 +792,7 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
> >          .slaves         = omap3xxx_timer8_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer8_slaves),
> >          .class          =&omap3xxx_timer_hwmod_class,
> > +       .od             =&timer8_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > @@ -770,6 +852,7 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
> >          .slaves         = omap3xxx_timer9_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer9_slaves),
> >          .class          =&omap3xxx_timer_hwmod_class,
> > +       .od             =&timer9_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > @@ -849,6 +932,7 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
> >          .slaves         = omap3xxx_timer1_slaves,
> >          .slaves_cnt     = ARRAY_SIZE(omap3xxx_timer1_slaves),
> >          .class          =&omap3xxx_timer_1ms_hwmod_class,
> > +       .od             =&timer1_init_name,
> >          .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> >   };
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-
> omap2/omap_hwmod_44xx_data.c
> > index 0390270..9edc518 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -549,7 +549,7 @@ static struct omap_hwmod_class_sysconfig
> omap44xx_timer_1ms_sysc = {
> >    * belongs the .name field is assigned a uniform name 'timer'.
> >    */
> >   static struct omap_hwmod_class omap44xx_timer_1ms_hwmod_class = {
> > -       .name = "timer_1ms",
> > +       .name = "timer",
> >          .sysc =&omap44xx_timer_1ms_sysc,
> >          .rev = OMAP_TIMER_IP_VERSION_1,
> >   };
> > @@ -569,6 +569,79 @@ static struct omap_hwmod_class
> omap44xx_timer_hwmod_class = {
> >          .rev = OMAP_TIMER_IP_VERSION_2,
> >   };
> >
> > +/*
> > + * during dmtimer early init, when device model is not up yet and
> dmtimer
> > + * devices are not yet registered, the initialization routine is unable
> > + * to read clock sources supported by the dmtimers using clk_get()
> because
> > + * it searches the list using device names. this problem is overcome by
> > + * assigning timer device names to the .init_name field.
> > + */
> > +static struct omap_device timer1_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.0" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer2_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.1" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer3_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.2" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer4_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.3" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer5_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.4" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer6_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.5" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer7_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.6" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer8_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.7" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer9_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.8" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer10_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.9" },
> > +       },
> > +};
> > +
> > +static struct omap_device timer11_init_name = {
> > +       .pdev = {
> > +               .dev = { .init_name = "dmtimer.10" },
> > +       },
> > +};
> > +
> >   /* timer1 */
> >   static struct omap_hwmod omap44xx_timer1_hwmod;
> >   static struct omap_hwmod_irq_info omap44xx_timer1_irqs[] = {
> > @@ -601,6 +674,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer1_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer1_hwmod = {
> >          .name           = "timer1",
> >          .class          =&omap44xx_timer_1ms_hwmod_class,
> > +       .od             =&timer1_init_name,
> >          .mpu_irqs       = omap44xx_timer1_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer1_irqs),
> >          .main_clk       = "timer1_fck",
> > @@ -647,6 +721,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer2_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer2_hwmod = {
> >          .name           = "timer2",
> >          .class          =&omap44xx_timer_1ms_hwmod_class,
> > +       .od             =&timer2_init_name,
> >          .mpu_irqs       = omap44xx_timer2_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer2_irqs),
> >          .main_clk       = "timer2_fck",
> > @@ -693,6 +768,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer3_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer3_hwmod = {
> >          .name           = "timer3",
> >          .class          =&omap44xx_timer_hwmod_class,
> > +       .od             =&timer3_init_name,
> >          .mpu_irqs       = omap44xx_timer3_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer3_irqs),
> >          .main_clk       = "timer3_fck",
> > @@ -739,6 +815,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer4_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer4_hwmod = {
> >          .name           = "timer4",
> >          .class          =&omap44xx_timer_hwmod_class,
> > +       .od             =&timer4_init_name,
> >          .mpu_irqs       = omap44xx_timer4_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer4_irqs),
> >          .main_clk       = "timer4_fck",
> > @@ -804,6 +881,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer5_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer5_hwmod = {
> >          .name           = "timer5",
> >          .class          =&omap44xx_timer_hwmod_class,
> > +       .od             =&timer5_init_name,
> >          .mpu_irqs       = omap44xx_timer5_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer5_irqs),
> >          .main_clk       = "timer5_fck",
> > @@ -869,6 +947,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer6_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer6_hwmod = {
> >          .name           = "timer6",
> >          .class          =&omap44xx_timer_hwmod_class,
> > +       .od             =&timer6_init_name,
> >          .mpu_irqs       = omap44xx_timer6_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer6_irqs),
> >          .main_clk       = "timer6_fck",
> > @@ -934,6 +1013,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer7_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer7_hwmod = {
> >          .name           = "timer7",
> >          .class          =&omap44xx_timer_hwmod_class,
> > +       .od             =&timer7_init_name,
> >          .mpu_irqs       = omap44xx_timer7_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer7_irqs),
> >          .main_clk       = "timer7_fck",
> > @@ -999,6 +1079,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer8_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer8_hwmod = {
> >          .name           = "timer8",
> >          .class          =&omap44xx_timer_hwmod_class,
> > +       .od             =&timer8_init_name,
> >          .mpu_irqs       = omap44xx_timer8_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer8_irqs),
> >          .main_clk       = "timer8_fck",
> > @@ -1045,6 +1126,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer9_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer9_hwmod = {
> >          .name           = "timer9",
> >          .class          =&omap44xx_timer_hwmod_class,
> > +       .od             =&timer9_init_name,
> >          .mpu_irqs       = omap44xx_timer9_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer9_irqs),
> >          .main_clk       = "timer9_fck",
> > @@ -1091,6 +1173,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer10_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer10_hwmod = {
> >          .name           = "timer10",
> >          .class          =&omap44xx_timer_1ms_hwmod_class,
> > +       .od             =&timer10_init_name,
> >          .mpu_irqs       = omap44xx_timer10_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer10_irqs),
> >          .main_clk       = "timer10_fck",
> > @@ -1137,6 +1220,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer11_slaves[] = {
> >   static struct omap_hwmod omap44xx_timer11_hwmod = {
> >          .name           = "timer11",
> >          .class          =&omap44xx_timer_hwmod_class,
> > +       .od             =&timer11_init_name,
> >          .mpu_irqs       = omap44xx_timer11_irqs,
> >          .mpu_irqs_cnt   = ARRAY_SIZE(omap44xx_timer11_irqs),
> >          .main_clk       = "timer11_fck",
> > --
> > 1.6.0.4
> >

