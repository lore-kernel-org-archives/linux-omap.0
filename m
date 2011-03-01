From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 18/19] omap3630+: sr: add support for class 1.5
Date: Tue, 1 Mar 2011 17:50:46 +0530
Message-ID: <AANLkTikkZqT01fpRjyiBqrJUaM-YnSGh0mqomAi0AOOu@mail.gmail.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-19-git-send-email-nm@ti.com>
	<AANLkTikCFz2gv=0KXWecHF6YKsZ5GuL+L__-izzriW=T@mail.gmail.com>
	<AANLkTi=Jde-XZ3O7Uojmz-PrD4jJvR9fW-aFdrNejY+M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:40170 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752512Ab1CAMUt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 07:20:49 -0500
Received: by bwz8 with SMTP id 8so5050627bwz.7
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 04:20:46 -0800 (PST)
In-Reply-To: <AANLkTi=Jde-XZ3O7Uojmz-PrD4jJvR9fW-aFdrNejY+M@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Ambresh K <ambresh@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Igor Dmitriev <ext-dmitriev.igor@nokia.com>, Paul <paul@pwsan.com>, Peter 'p2' De Schrijver <Peter.De-Schrijver@nokia.com>

Hi,

On Tue, Mar 1, 2011 at 3:47 PM, Menon, Nishanth <nm@ti.com> wrote:
> On Tue, Mar 1, 2011 at 15:23, Gulati, Shweta <shweta.gulati@ti.com> w=
rote:
>>
>> Hi,
>>
>> On Sat, Feb 19, 2011 at 5:31 PM, Nishanth Menon <nm@ti.com> wrote:
>> > Traditional SmartReflex AVS(Automatic Voltage Scaling) classes are=
:
>> > * Class 0 - Product test calibration
>> > =A0 =A0 =A0 =A0Silicon is calibration at production floor and fuse=
d with voltages
>> > =A0 =A0 =A0 =A0for each OPP
>> > * Class 1 - Boot time calibration
>> > =A0 =A0 =A0 =A0Silicon is calibrated once at boot time and voltage=
s are stored for
>> > =A0 =A0 =A0 =A0the lifetime of operation.
>> > * Class 2 - continuous s/w calibration
>> > =A0 =A0 =A0 =A0SR module notifies s/w for any change in the system=
 which is desired
>> > =A0 =A0 =A0 =A0and the s/w makes runtime decisions in terms of set=
ting the voltage,
>> > =A0 =A0 =A0 =A0this mechanism could be used in the system which do=
es not have PMIC
>> > =A0 =A0 =A0 =A0capable of SR without using the voltage controller =
and voltage
>> > =A0 =A0 =A0 =A0processor blocks.
>> > * Class 3 - continuous h/w calibration
>> > =A0 =A0 =A0 =A0SR module is switch on after reaching a voltage lev=
el and SR
>> > =A0 =A0 =A0 =A0continuously monitors the system and makes runtime =
adjustments without
>> > =A0 =A0 =A0 =A0s/w involvement.
>> >
>> > OMAP3430 has used SmartReflex AVS and with a a PMIC which understa=
nds the SR
>> > protocol, Class 3 has been used. With OMAP3630 onwards, a new Smar=
tReflex AVS
>> > class of operation Class 1.5 was introduced.
>> > * Class 1.5 - periodic s/w calibration
>> > =A0 =A0 =A0 =A0This uses the h/w calibration loop and at the end o=
f calibration
>> > =A0 =A0 =A0 =A0stores the voltages to be used run time, periodic r=
ecalibration is
>> > =A0 =A0 =A0 =A0performed as well.
>> >
>> > The operational mode is describes as the following:
>> > * SmartReflex AVS h/w calibration loop is essential to identify th=
e optimal
>> > =A0 =A0 =A0 =A0voltage for a given OPP.
>> > * Once this optimal voltage is detected, SmartReflex AVS loop is d=
isabled in
>> > =A0 =A0 =A0 =A0class 1.5 mode of operation.
>> > * Until there is a need for a recalibration, any further transitio=
n to an OPP
>> > =A0 =A0 =A0 =A0voltage which is calibrated can use the calibrated =
voltage and does not
>> > =A0 =A0 =A0 =A0require enabling the SR AVS h/w loop.
>> > * On a periodic basis (recommendation being once approximately eve=
ry 24 hours),
>> > =A0 =A0 =A0 =A0software is expected to perform a recalibration to =
find a new optimal
>> > =A0 =A0 =A0 =A0voltage which is compensated for device aging.
>> > =A0 =A0 =A0 =A0- For performing this recalibration, the start volt=
age does not need to
>> > =A0 =A0 =A0 =A0be the nominal voltage anymore. instead, the system=
 can start with a
>> > =A0 =A0 =A0 =A0voltage which is 50mV higher than the previously ca=
librated voltage to
>> > =A0 =A0 =A0 =A0identify the new optimal voltage as the aging facto=
r within a period of
>> > =A0 =A0 =A0 =A01 day is not going to be anywhere close to 50mV.
>> > =A0 =A0 =A0 =A0- This "new starting point" for recalibration is ca=
lled a dynamic
>> > =A0 =A0 =A0 =A0nominal voltage for that voltage point.
>> > In short, with the introduction of SmartReflex class 1.5, there ar=
e three new
>> > voltages possible in a system's dvfs transition:
>> > * Nominal Voltage - The maximum voltage needed for a worst possibl=
e device
>> > =A0 =A0 =A0 =A0in the worst possible conditions. This is the volta=
ge we choose as
>> > =A0 =A0 =A0 =A0the starting point for the h/w loop to optimize for=
 the first time
>> > =A0 =A0 =A0 =A0calibration on system bootup.
>> > * Dynamic Nominal Voltage - Worst case voltage for a specific devi=
ce in
>> > =A0 =A0 =A0 =A0considering the system aging on the worst process d=
evice.
>> > * Calibrated Voltage - Best voltage for the current device at a gi=
ven point
>> > =A0 =A0 =A0 =A0of time.
>> >
>> > In terms of the implementation, doing calibration involves waiting=
 for the
>> > smartreflex h/w loop to settle down, and doing this as part of the=
 dvfs flow
>> > itself is to increase the latency of dvfs transition when there is=
 a need to
>> > calibrate that opp. instead, the calibration is performed "out of =
path" using
>> > a workqueue statemachine. The workqueue waits for the system stabi=
lization,
>> > then enables VP interrupts to monitor for system instability inter=
ms of voltage
>> > oscillations that are reported back to the system as interrupts, i=
n case of
>> > prolonged system oscillations, nominal voltage is chosen as a safe=
 voltage and
>> > this event is logged in the system log for developer debug and fix=
ing.
>> >
>> > For the recalibration, a common workqueue for all domains is start=
ed at the
>> > start of the class initialization and it resets the calibrated vol=
tages
>> > on a periodic basis. For distros that may choose not to do the rec=
ommended
>> > periodic recalibration, instead choose to perform boot time calibr=
ation,
>> > kconfig configuration option is provided to do so.
>> >
>> > TODO:
>> > a) Cpuidle and suspend paths are not integrated with SmartReflex d=
river at
>> > =A0 this point.
>> > b) Since the SR registers are accessed and controlled in parallel =
to DVFS
>> > =A0 some sort of mechanism is necessary to be introduced along wit=
h OMAP
>> > =A0 dvfs layer to ensure mutual exclusivity
>> > c) Additional debug interfaces for vmin analysis for platform char=
acterization
>> > =A0 and addition of system margin needs to be introduced from smar=
treflex
>> > =A0 perspective.
>> >
>> > This implementation also includes the following contributors:
>> > Tony Lindgren for suggestion on using interrupt based mechanism in=
stead of
>> > polling to detect voltage oscillations.
>> > Peter 'p2' De Schrijver for debating alternatives on recalibration=
 mechanisms
>> > Paul Walmsey, Eduardo Valentin, Ambresh K, Igor Dmitriev and quiet=
 a few others
>> > for patient review, testing and reporting of issues of a previous =
incarnation
>> > of this implemenation. Last, but not the least, the TI H/w team in=
 introducing
>> > this new SR AVS class and patiently debating it's various facets.
>> >
>> > Cc: Ambresh K <ambresh@ti.com>
>> > Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
>> > Cc: Igor Dmitriev <ext-dmitriev.igor@nokia.com>
>> > Cc: Paul <paul@pwsan.com>
>> > Cc: Peter 'p2' De Schrijver <Peter.De-Schrijver@nokia.com>
>> > Cc: Tony Lindgren <tony@atomide.com>
>> >
>> > Signed-off-by: Nishanth Menon <nm@ti.com>
>> > ---
>> > =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
>> > =A0arch/arm/mach-omap2/smartreflex-class1p5.c =A0 =A0| =A0556 ++++=
+++++++++++++++++++++
>> > =A0arch/arm/mach-omap2/smartreflex-class3.c =A0 =A0 =A0| =A0 =A04 =
+-
>> > =A0arch/arm/mach-omap2/smartreflex.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 34 ++-
>> > =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 69 +++
>> > =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 17 +
>> > =A0arch/arm/plat-omap/include/plat/smartreflex.h | =A0 13 +-
>> > =A0arch/arm/plat-omap/include/plat/voltage.h =A0 =A0 | =A0 23 +-
>> > =A08 files changed, 709 insertions(+), 8 deletions(-)
>> > =A0create mode 100644 arch/arm/mach-omap2/smartreflex-class1p5.c
>> >
>> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Ma=
kefile
>> > index 1c0c2b0..1a82e6d 100644
>> > --- a/arch/arm/mach-omap2/Makefile
>> > +++ b/arch/arm/mach-omap2/Makefile
>> > @@ -66,6 +66,7 @@ obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0+=3D pm44xx.o voltage.o pm_bus.o
>> > =A0obj-$(CONFIG_PM_DEBUG) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm-=
debug.o
>> > =A0obj-$(CONFIG_OMAP_SMARTREFLEX) =A0 =A0 =A0 =A0 =A0+=3D sr_devic=
e.o smartreflex.o
>> > =A0obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3) =A0+=3D smartreflex-class=
3.o
>> > +obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS1P5) =A0 =A0 =A0 =A0+=3D smart=
reflex-class1p5.o
>> >
>> > =A0AFLAGS_sleep24xx.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D=
-Wa,-march=3Darmv6
>> > =A0AFLAGS_sleep34xx.o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D=
-Wa,-march=3Darmv7-a
>> > diff --git a/arch/arm/mach-omap2/smartreflex-class1p5.c b/arch/arm=
/mach-omap2/smartreflex-class1p5.c
>> > new file mode 100644
>> > index 0000000..832f10b
>> > --- /dev/null
>> > +++ b/arch/arm/mach-omap2/smartreflex-class1p5.c
>> > @@ -0,0 +1,556 @@
>> > +/*
>> > + * Smart reflex Class 1.5 specific implementations
>> > + *
>> > + * Copyright (C) 2010-2011 Texas Instruments, Inc.
>> > + * Nishanth Menon <nm@ti.com>
>> > + *
>> > + * Smart reflex class 1.5 is also called periodic SW Calibration
>> > + * Some of the highlights are as follows:
>> > + * =96 Host CPU triggers OPP calibration when transitioning to no=
n calibrated
>> > + * =A0 OPP
>> > + * =96 SR-AVS + VP modules are used to perform calibration
>> > + * =96 Once completed, the SmartReflex-AVS module can be disabled
>> > + * =96 Enables savings based on process, supply DC accuracy and a=
ging
>> > + *
>> > + * This program is free software; you can redistribute it and/or =
modify
>> > + * it under the terms of the GNU General Public License version 2=
 as
>> > + * published by the Free Software Foundation.
>> > + */
>> > +#include <linux/kernel.h>
>> > +#include <linux/delay.h>
>> > +#include <linux/err.h>
>> > +#include <linux/io.h>
>> > +#include <linux/fs.h>
>> > +#include <linux/string.h>
>> > +#include <linux/uaccess.h>
>> > +#include <linux/kobject.h>
>> > +#include <linux/workqueue.h>
>> > +#include <linux/opp.h>
>> > +
>> > +#include <plat/smartreflex.h>
>> > +#include <plat/voltage.h>
>> > +
>> > +#define MAX_VDDS 3
>> > +#define SR1P5_SAMPLING_DELAY_MS =A0 =A0 =A0 =A01
>> > +#define SR1P5_STABLE_SAMPLES =A0 5
>> > +#define SR1P5_MAX_TRIGGERS =A0 =A0 5
>> > +
>> > +/*
>> > + * we expect events in 10uS, if we dont get 2wice times as much,
>> > + * we could kind of ignore this as a missed event.
>> > + */
>> > +#define MAX_CHECK_VPTRANS_US =A0 20
>> > +
>> > +/**
>> > + * struct sr_class1p5_work_data - data meant to be used by calibr=
ation work
>> > + * @work: =A0 =A0 =A0calibration work
>> > + * @voltdm: =A0 =A0 =A0 =A0 =A0 =A0voltage domain for which we ar=
e triggering
>> > + * @vdata: =A0 =A0 voltage data we are calibrating
>> > + * @num_calib_triggers: =A0 =A0 =A0 =A0number of triggers from ca=
libration loop
>> > + * @num_osc_samples: =A0 number of samples collected by isr
>> > + * @work_active: =A0 =A0 =A0 have we scheduled a work item?
>> > + */
>> > +struct sr_class1p5_work_data {
>> > + =A0 =A0 =A0 struct delayed_work work;
>> > + =A0 =A0 =A0 struct voltagedomain *voltdm;
>> > + =A0 =A0 =A0 struct omap_volt_data *vdata;
>> > + =A0 =A0 =A0 u8 num_calib_triggers;
>> > + =A0 =A0 =A0 u8 num_osc_samples;
>> > + =A0 =A0 =A0 bool work_active;
>> > +};
>> > +
>> > +#if CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY
>> > +/* recal_work: recalibration calibration work */
>> > +static struct delayed_work recal_work;
>> > +#endif
>> > +
>> > +/**
>> > + * struct sr_class1p5_data - private data for class 1p5
>> > + * @work_data: =A0 =A0 =A0 =A0 work item data per voltage domain
>> > + */
>> > +struct sr_class1p5_data {
>> > + =A0 =A0 =A0 struct sr_class1p5_work_data work_data[MAX_VDDS];
>> > +};
>> > +
>> > +static void sr_class1p5_reset_calib(struct voltagedomain *voltdm,=
 bool reset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 bool recal);
>> > +
>> > +/* our instance of class 1p5 private data */
>> > +static struct sr_class1p5_data class_1p5_data;
>> > +
>> > +static struct sr_class1p5_work_data *get_sr1p5_work(struct voltag=
edomain
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *voltdm)
>> > +{
>> > + =A0 =A0 =A0 int idx;
>> > + =A0 =A0 =A0 for (idx =3D 0; idx < MAX_VDDS; idx++) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (class_1p5_data.work_data[idx].vo=
ltdm && !strcmp
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (class_1p5_data.work_data[id=
x].voltdm->name, voltdm->name))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &class_1p5_da=
ta.work_data[idx];
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 return ERR_PTR(-ENODATA);
>> > +}
>> > +
>> > +/**
>> > + * sr_class1p5_notify() - isr notifier for status events
>> > + * @voltdm: =A0 =A0voltage domain for which we were triggered
>> > + * @status: =A0 =A0notifier event to use
>> > + *
>> > + * This basically collects data for the work to use.
>> > + */
>> > +static int sr_class1p5_notify(struct voltagedomain *voltdm, u32 s=
tatus)
>> > +{
>> > + =A0 =A0 =A0 struct sr_class1p5_work_data *work_data;
>> > + =A0 =A0 =A0 int idx =3D 0;
>> > + =A0 =A0 =A0 work_data =3D get_sr1p5_work(voltdm);
>> > +
>> > + =A0 =A0 =A0 if (unlikely(!work_data)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:%s no work data!!\n", __f=
unc__, voltdm->name);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 /* Wait for transdone so that we know the voltage to=
 read */
>> > + =A0 =A0 =A0 do {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vp_is_transdone(voltdm))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx++;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* get some constant delay */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> > + =A0 =A0 =A0 } while (idx < MAX_CHECK_VPTRANS_US);
>> > +
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* If we timeout, we still read the data,
>> > + =A0 =A0 =A0 =A0* if we are oscillating+irq latencies are too hig=
h, we could
>> > + =A0 =A0 =A0 =A0* have scenarios where we miss transdone event. s=
ince
>> > + =A0 =A0 =A0 =A0* we waited long enough, it is still safe to read=
 the voltage
>> > + =A0 =A0 =A0 =A0* as we would have waited long enough - still fla=
g it..
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 if (idx >=3D MAX_CHECK_VPTRANS_US)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: timed out waiting fo=
r transdone!!\n", __func__);
>> > +
>> > + =A0 =A0 =A0 omap_vp_clear_transdone(voltdm);
>> > +
>> > + =A0 =A0 =A0 idx =3D (work_data->num_osc_samples) % SR1P5_STABLE_=
SAMPLES;
>> > + =A0 =A0 =A0 work_data->num_osc_samples++;
>> > +
>> > + =A0 =A0 =A0 return 0;
>> > +}
>> > +
>> > +/**
>> > + * do_calibrate() - work which actually does the calibration
>> > + * @work: pointer to the work
>> > + *
>> > + * calibration routine uses the following logic:
>> > + * on the first trigger, we start the isr to collect sr voltages
>> > + * wait for stabilization delay (reschdule self instead of sleepi=
ng)
>> > + * after the delay, see if we collected any isr events
>> > + * if none, we have calibrated voltage.
>> > + * if there are any, we retry untill we giveup.
>> > + * on retry timeout, select a voltage to use as safe voltage.
>> > + */
>> > +static void do_calibrate(struct work_struct *work)
>> > +{
>> > + =A0 =A0 =A0 struct sr_class1p5_work_data *work_data =3D
>> > + =A0 =A0 =A0 =A0 =A0 container_of(work, struct sr_class1p5_work_d=
ata, work.work);
>> > + =A0 =A0 =A0 unsigned long u_volt_safe =3D 0, u_volt_current =3D =
0;
>> > + =A0 =A0 =A0 struct omap_volt_data *volt_data;
>> > + =A0 =A0 =A0 struct voltagedomain *voltdm;
>> > +
>> > + =A0 =A0 =A0 if (unlikely(!work_data)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: ooops.. null work_data?\=
n", __func__);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* TODO:Handle the case where we might have just b=
een scheduled AND
>> > + =A0 =A0 =A0 =A0* 1.5 disable was called. check and HOLD dvfs
>> > + =A0 =A0 =A0 =A0*/
>> > +
>> > + =A0 =A0 =A0 voltdm =3D work_data->voltdm;
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* In the unlikely case that we did get through wh=
en unplanned,
>> > + =A0 =A0 =A0 =A0* flag and return.
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 if (unlikely(!work_data->work_active)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:%s unplanned work invocat=
ion!\n", __func__,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0voltdm->name);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* TODO release the dvfs */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 work_data->num_calib_triggers++;
>> > + =A0 =A0 =A0 /* if we are triggered first time, we need to start =
isr to sample */
>> > + =A0 =A0 =A0 if (work_data->num_calib_triggers =3D=3D 1)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto start_sampling;
>> > +
>> > + =A0 =A0 =A0 /* Stop isr from interrupting our measurements :) */
>> > + =A0 =A0 =A0 sr_notifier_control(voltdm, false);
>> > +
>> > + =A0 =A0 =A0 volt_data =3D work_data->vdata;
>> > +
>> > + =A0 =A0 =A0 /* if there are no samples captured.. SR is silent, =
aka stability! */
>> > + =A0 =A0 =A0 if (!work_data->num_osc_samples) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u_volt_safe =3D omap_vp_get_curr_vol=
t(voltdm);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u_volt_current =3D u_volt_safe;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done_calib;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 if (work_data->num_calib_triggers =3D=3D SR1P5_MAX_T=
RIGGERS) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: %s recalib timeout!\=
n", __func__,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0work_data->vo=
ltdm->name);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto oscillating_calib;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 /* we have potential oscillations/first sample */
>> > +start_sampling:
>> > + =A0 =A0 =A0 work_data->num_osc_samples =3D 0;
>> > + =A0 =A0 =A0 /* Clear pending events */
>> > + =A0 =A0 =A0 sr_notifier_control(voltdm, false);
>> > + =A0 =A0 =A0 /* Clear all transdones */
>> > + =A0 =A0 =A0 while (omap_vp_is_transdone(voltdm))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vp_clear_transdone(voltdm);
>> > + =A0 =A0 =A0 /* trigger sampling */
>> > + =A0 =A0 =A0 sr_notifier_control(voltdm, true);
>> > + =A0 =A0 =A0 schedule_delayed_work(&work_data->work,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to=
_jiffies(SR1P5_SAMPLING_DELAY_MS *
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0SR1P5_STABLE_SAMPLES));
>> > + =A0 =A0 =A0 /* TODO: release dvfs */
>> > + =A0 =A0 =A0 return;
>> > +
>> > +oscillating_calib:
>> > + =A0 =A0 =A0 /* Use the nominal voltage as the safe voltage */
>> > + =A0 =A0 =A0 u_volt_safe =3D volt_data->volt_nominal;
>> > + =A0 =A0 =A0 /* pick up current voltage to switch if needed */
>> > + =A0 =A0 =A0 u_volt_current =3D omap_vp_get_curr_volt(voltdm);
>> > +
>> > + =A0 =A0 =A0 /* Fall through to close up common stuff */
>> > +done_calib:
>> > + =A0 =A0 =A0 omap_vp_disable(voltdm);
>> > + =A0 =A0 =A0 sr_disable(voltdm);
>> > +
>> > + =A0 =A0 =A0 volt_data->volt_calibrated =3D u_volt_safe;
>> > + =A0 =A0 =A0 /* Setup my dynamic voltage for the next calibration=
 for this opp */
>> > + =A0 =A0 =A0 volt_data->volt_dynamic_nominal =3D omap_get_dyn_nom=
inal(volt_data);
>> > +
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* if the voltage we decided as safe is not the cu=
rrent voltage,
>> > + =A0 =A0 =A0 =A0* switch
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 if (volt_data->volt_calibrated !=3D u_volt_current) =
{
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s:%s reconfiguring to vol=
tage %d\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, voltdm-=
>name, volt_data->volt_calibrated);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_voltage_scale_vdd(voltdm, volt_=
data);
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* TODO: Setup my wakeup voltage to allow immediat=
e going to OFF and
>> > + =A0 =A0 =A0 =A0* on - Pending twl and voltage layer cleanups.
>> > + =A0 =A0 =A0 =A0* This is necessary, as this is not done as part =
of regular
>> > + =A0 =A0 =A0 =A0* Dvfs flow.
>> > + =A0 =A0 =A0 =A0* vc_setup_on_voltage(voltdm, volt_data->volt_cal=
ibrated);
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 work_data->work_active =3D false;
>> > + =A0 =A0 =A0 /* TODO: release dvfs */
>> > +}
>> > +
>> > +#if CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY
>> > +/**
>> > + * do_recalibrate() - work which actually does the calibration
>> > + * @work: pointer to the work
>> > + *
>> > + * on a periodic basis, we come and reset our calibration setup
>> > + * so that a recalibration of the OPPs take place. This takes
>> > + * care of aging factor in the system.
>> > + */
>> > +static void do_recalibrate(struct work_struct *work)
>> > +{
>> > + =A0 =A0 =A0 struct voltagedomain *voltdm;
>> > + =A0 =A0 =A0 int idx;
>> > + =A0 =A0 =A0 static struct sr_class1p5_work_data *work_data;
>> > +
>> > + =A0 =A0 =A0 for (idx =3D 0; idx < MAX_VDDS; idx++) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 work_data =3D &class_1p5_data.work_d=
ata[idx];
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm =3D work_data->voltdm;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (voltdm) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if sr is not enab=
led, we check later */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!is_sr_enabled(v=
oltdm))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cont=
inue;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* TODO: Pause the d=
vfs transitions */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if sr is not enab=
led, we check later */
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Reset and force a=
 recalibration for current opp */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_class1p5_reset_ca=
lib(voltdm, true, true);
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* TODO: unpause DVF=
S transitions */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 /* We come back again after time the usual delay */
>> > + =A0 =A0 =A0 schedule_delayed_work(&recal_work,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies(CONFIG_OMAP_SR_CLASS1P5=
_RECALIBRATION_DELAY));
>> > +}
>> > +#endif /* CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY */
>> > +
>> > +/**
>> > + * sr_class1p5_enable() - class 1.5 mode of enable
>> > + * @voltdm: =A0 =A0 =A0 =A0 =A0 =A0voltage domain to enable SR fo=
r
>> > + * @volt_data: voltdata to the voltage transition taking place
>> > + *
>> > + * when this gets called, we use the h/w loop to setup our voltag=
es
>> > + * to an calibrated voltage, detect any oscillations, recover fro=
m the same
>> > + * and finally store the optimized voltage as the calibrated volt=
age in the
>> > + * system
>> > + */
>> > +static int sr_class1p5_enable(struct voltagedomain *voltdm,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct o=
map_volt_data *volt_data)
>> > +{
>> > + =A0 =A0 =A0 int r;
>> > + =A0 =A0 =A0 struct sr_class1p5_work_data *work_data;
>> > + =A0 =A0 =A0 /* if already calibrated, nothing to do here.. */
>> > + =A0 =A0 =A0 if (volt_data->volt_calibrated)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> > +
>> > + =A0 =A0 =A0 work_data =3D get_sr1p5_work(voltdm);
>> > + =A0 =A0 =A0 if (unlikely(!work_data)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: aieeee.. bad work data??=
\n", __func__);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 if (work_data->work_active)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> > +
>> > + =A0 =A0 =A0 omap_vp_enable(voltdm);
>> > + =A0 =A0 =A0 r =3D sr_enable(voltdm, volt_data);
>> > + =A0 =A0 =A0 if (r) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: sr[%s] failed\n", __func=
__, voltdm->name);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vp_disable(voltdm);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 work_data->vdata =3D volt_data;
>> > + =A0 =A0 =A0 work_data->work_active =3D true;
>> > + =A0 =A0 =A0 work_data->num_calib_triggers =3D 0;
>> > + =A0 =A0 =A0 /* program the workqueue and leave it to calibrate o=
ffline.. */
>> > + =A0 =A0 =A0 schedule_delayed_work(&work_data->work,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to=
_jiffies(SR1P5_SAMPLING_DELAY_MS *
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0SR1P5_STABLE_SAMPLES));
>> > +
>> > + =A0 =A0 =A0 return 0;
>> > +}
>> > +
>> > +/**
>> > + * sr_class1p5_disable() - disable for class 1p5
>> > + * @voltdm: voltage domain for the sr which needs disabling
>> > + * @volt_data: voltagedata to disable
>> > + * @is_volt_reset: reset the voltage?
>> > + *
>> > + * we dont do anything if the class 1p5 is being used. this is be=
cause we
>> > + * already disable sr at the end of calibration and no h/w loop i=
s actually
>> > + * active when this is called.
>> > + */
>> > +static int sr_class1p5_disable(struct voltagedomain *voltdm,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struc=
t omap_volt_data *volt_data,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int i=
s_volt_reset)
>> > +{
>> > + =A0 =A0 =A0 struct sr_class1p5_work_data *work_data;
>> > +
>> > + =A0 =A0 =A0 work_data =3D get_sr1p5_work(voltdm);
>> > + =A0 =A0 =A0 if (work_data->work_active) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if volt reset and work is active,=
 we dont allow this */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_volt_reset)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* flag work is dead and remove the =
old work */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 work_data->work_active =3D false;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&work_data-=
>work);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_notifier_control(voltdm, false);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vp_disable(voltdm);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_disable(voltdm);
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 /* if already calibrated, nothin special to do here.=
=2E */
>> > + =A0 =A0 =A0 if (volt_data->volt_calibrated)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> > +
>> > + =A0 =A0 =A0 if (is_volt_reset)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_voltage_reset(voltdm);
>> > + =A0 =A0 =A0 return 0;
>> > +}
>> > +
>> > +/**
>> > + * sr_class1p5_configure() - configuration function
>> > + * @voldm: =A0 =A0 configure for which voltage domain
>> > + *
>> > + * we dont do much here other than setup some registers for
>> > + * the sr module involved.
>> > + */
>> > +static int sr_class1p5_configure(struct voltagedomain *voltdm)
>> > +{
>> > + =A0 =A0 =A0 return sr_configure_errgen(voltdm);
>> > +}
>> > +
>> > +/**
>> > + * sr_class1p5_reset_calib() - reset all calibrated voltages
>> > + * @srid: =A0 =A0 =A0srid to reset the calibration for
>> > + * @reset: =A0 =A0 reset voltage before we recal?
>> > + * @recal: =A0 =A0 should I recalibrate my current opp?
>> > + *
>> > + * if we call this, it means either periodic calibration trigger =
was
>> > + * fired(either from sysfs or other mechanisms) or we have disabl=
ed class 1p5,
>> > + * meaning we cant trust the calib voltages anymore, it is better=
 to use
>> > + * nominal in the system
>> > + */
>> > +static void sr_class1p5_reset_calib(struct voltagedomain *voltdm,=
 bool reset,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 bool recal)
>> > +{
>> > + =A0 =A0 =A0 struct sr_class1p5_work_data *work_data;
>> > +
>> > + =A0 =A0 =A0 /* I dont need to go further if sr is not present */
>> > + =A0 =A0 =A0 if (!is_sr_enabled(voltdm))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > +
>> > + =A0 =A0 =A0 work_data =3D get_sr1p5_work(voltdm);
>> > +
>> > + =A0 =A0 =A0 if (work_data->work_active)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_class1p5_disable(voltdm, work_dat=
a->vdata, 0);
>> > +
>> > + =A0 =A0 =A0 omap_voltage_calib_reset(voltdm);
>> > +
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* I should now reset the voltages to my nominal t=
o be safe
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 if (reset)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_voltage_reset(voltdm);
>> > +
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* I should fire a recalibration for current opp i=
f needed
>> > + =A0 =A0 =A0 =A0* Note: i have just reset my calibrated voltages,=
 and if
>> > + =A0 =A0 =A0 =A0* i call sr_enable equivalent, I will cause a rec=
alibration
>> > + =A0 =A0 =A0 =A0* loop, even though the function is called sr_ena=
ble.. we
>> > + =A0 =A0 =A0 =A0* are in class 1.5 ;)
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 if (reset && recal)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_class1p5_enable(voltdm, work_data=
->vdata);
>> > +}
>> > +
>> > +/**
>> > + * sr_class1p5_cinit() - class 1p5 init
>> > + * @voltdm: =A0 =A0 =A0 =A0 =A0 =A0sr voltage domain
>> > + * @class_priv_data: =A0 private data for the class
>> > + *
>> > + * we do class specific initialization like creating sysfs/debugf=
s entries
>> > + * needed, spawning of a kthread if needed etc.
>> > + */
>> > +static int sr_class1p5_cinit(struct voltagedomain *voltdm,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *cla=
ss_priv_data)
>> > +{
>> > + =A0 =A0 =A0 struct sr_class1p5_work_data *work_data;
>> > + =A0 =A0 =A0 int idx;
>> > +
>> > + =A0 =A0 =A0 if (!class_priv_data) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: bad param? no priv data!=
\n", __func__);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 /* setup our work params */
>> > + =A0 =A0 =A0 work_data =3D get_sr1p5_work(voltdm);
>> > + =A0 =A0 =A0 if (!IS_ERR_OR_NULL(work_data)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: ooopps.. class already i=
nitialized for %s! bug??\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, voltdm->nam=
e);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 work_data =3D NULL;
>> > + =A0 =A0 =A0 /* get the next spare work_data */
>> > + =A0 =A0 =A0 for (idx =3D 0; idx < MAX_VDDS; idx++) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!class_1p5_data.work_data[idx].v=
oltdm) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 work_data =3D &class=
_1p5_data.work_data[idx];
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 if (!work_data) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: no more space for work d=
ata for domains!\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 work_data->voltdm =3D voltdm;
>> > + =A0 =A0 =A0 INIT_DELAYED_WORK_DEFERRABLE(&work_data->work, do_ca=
librate);
>> > + =A0 =A0 =A0 return 0;
>> > +}
>> > +
>> > +/**
>> > + * sr_class1p5_cdeinit() - class 1p5 deinitialization
>> > + * @voltdm: =A0 =A0voltage domain for which to do this.
>> > + * @class_priv_data: class private data for deinitialiation
>> > + *
>> > + * currently only resets the calibrated voltage forcing dvfs volt=
ages
>> > + * to be used in the system
>> > + */
>> > +static int sr_class1p5_cdeinit(struct voltagedomain *voltdm,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void =
*class_priv_data)
>> > +{
>> > + =A0 =A0 =A0 struct sr_class1p5_work_data *work_data;
>> > +
>> > + =A0 =A0 =A0 /* setup our work params */
>> > + =A0 =A0 =A0 work_data =3D get_sr1p5_work(voltdm);
>> > + =A0 =A0 =A0 if (IS_ERR_OR_NULL(work_data)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: ooopps.. class not initi=
alized for %s! bug??\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, voltdm->nam=
e);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* we dont have SR periodic calib anymore.. so res=
et calibs
>> > + =A0 =A0 =A0 =A0* we are already protected by sr debugfs lock, so=
 no lock needed
>> > + =A0 =A0 =A0 =A0* here.
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 sr_class1p5_reset_calib(voltdm, true, false);
>> > +
>> > + =A0 =A0 =A0 /* reset all data for this work data */
>> > + =A0 =A0 =A0 memset(work_data, 0, sizeof(*work_data));
>> > +
>> > + =A0 =A0 =A0 return 0;
>> > +}
>> > +
>> > +/* SR class1p5 structure */
>> > +static struct omap_sr_class_data class1p5_data =3D {
>> > + =A0 =A0 =A0 .enable =3D sr_class1p5_enable,
>> > + =A0 =A0 =A0 .disable =3D sr_class1p5_disable,
>> > + =A0 =A0 =A0 .configure =3D sr_class1p5_configure,
>> > + =A0 =A0 =A0 .class_type =3D SR_CLASS1P5,
>> > + =A0 =A0 =A0 .class_init =3D sr_class1p5_cinit,
>> > + =A0 =A0 =A0 .class_deinit =3D sr_class1p5_cdeinit,
>> > + =A0 =A0 =A0 .notify =3D sr_class1p5_notify,
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* trigger for bound - this tells VP that SR has a=
 voltage
>> > + =A0 =A0 =A0 =A0* change. we should ensure transdone is set befor=
e reading
>> > + =A0 =A0 =A0 =A0* vp voltage.
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 .notify_flags =3D SR_NOTIFY_MCUBOUND,
>> > + =A0 =A0 =A0 .class_priv_data =3D (void *)&class_1p5_data,
>> > +};
>> > +
>> > +/**
>> > + * sr_class1p5_init() - register class 1p5 as default
>> > + *
>> > + * board files call this function to use class 1p5, we register w=
ith the
>> > + * smartreflex subsystem
>> > + */
>> > +static int __init sr_class1p5_init(void)
>> > +{
>> > + =A0 =A0 =A0 int r;
>> > +
>> > + =A0 =A0 =A0 /* Enable this class only for OMAP3630 and OMAP4 */
>> > + =A0 =A0 =A0 if (!(cpu_is_omap3630() || cpu_is_omap44xx()))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > +
>> > + =A0 =A0 =A0 r =3D sr_register_class(&class1p5_data);
>> > + =A0 =A0 =A0 if (r) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("SmartReflex class 1.5 driver=
: "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed to register w=
ith %d\n", r);
>> > + =A0 =A0 =A0 } else {
>> > +#if CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_DELAYED_WORK_DEFERRABLE(&recal_=
work, do_recalibrate);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_delayed_work(&recal_work, m=
secs_to_jiffies(
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONF=
IG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY));
>> > +#endif
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("SmartReflex class 1.5 drive=
r: initialized (%dms)\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CONFIG_OMAP_SR_CLASS=
1P5_RECALIBRATION_DELAY);
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 return r;
>> > +}
>> > +late_initcall(sr_class1p5_init);
>> > diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/m=
ach-omap2/smartreflex-class3.c
>> > index 7ac88da..5f7a33e 100644
>> > --- a/arch/arm/mach-omap2/smartreflex-class3.c
>> > +++ b/arch/arm/mach-omap2/smartreflex-class3.c
>> > @@ -21,7 +21,9 @@ static int sr_class3_enable(struct voltagedomain=
 *voltdm,
>> > =A0 =A0 =A0 =A0return sr_enable(voltdm, volt_data);
>> > =A0}
>> >
>> > -static int sr_class3_disable(struct voltagedomain *voltdm, int is=
_volt_reset)
>> > +static int sr_class3_disable(struct voltagedomain *voltdm,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stru=
ct omap_volt_data *vdata,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =
is_volt_reset)
>> > =A0{
>> > =A0 =A0 =A0 =A0omap_vp_disable(voltdm);
>> > =A0 =A0 =A0 =A0sr_disable(voltdm);
>> > diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-oma=
p2/smartreflex.c
>> > index 3a5f2f6..bb55b65 100644
>> > --- a/arch/arm/mach-omap2/smartreflex.c
>> > +++ b/arch/arm/mach-omap2/smartreflex.c
>> > @@ -317,7 +317,9 @@ static void sr_stop_vddautocomp(struct omap_sr=
 *sr)
>> > =A0 =A0 =A0 =A0}
>> >
>> > =A0 =A0 =A0 =A0if (sr->autocomp_active) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_class->disable(sr->voltdm, 1);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sr_class->disable(sr->voltdm,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap=
_voltage_get_nom_volt(sr->voltdm),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (sr_class->class_deinit &&
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sr_class->class_deinit(sr->=
voltdm,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sr_class->c=
lass_priv_data)) {
>> > @@ -471,6 +473,28 @@ static u32 sr_retrieve_nvalue(struct omap_sr =
*sr, u32 efuse_offs)
>> > =A0/* Public Functions */
>> >
>> > =A0/**
>> > + * is_sr_enabled() - is Smart reflex enabled for this domain?
>> > + * @voltdm: voltage domain to check
>> > + *
>> > + * Returns 0 if SR is enabled for this domain, else returns err
>> > + */
>> > +bool is_sr_enabled(struct voltagedomain *voltdm)
>> > +{
>> > + =A0 =A0 =A0 struct omap_sr *sr;
>> > + =A0 =A0 =A0 if (IS_ERR_OR_NULL(voltdm)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: invalid param voltdm=
\n", __func__);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 sr =3D _sr_lookup(voltdm);
>> > + =A0 =A0 =A0 if (IS_ERR(sr)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: omap_sr struct for s=
r_%s not found\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->na=
me);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 return sr->autocomp_active;
>> > +}
>> > +
>> > +/**
>> > =A0* sr_configure_errgen() - Configures the smrtreflex to perform =
AVS using the
>> > =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error generator mo=
dule.
>> > =A0* @voltdm: =A0 =A0VDD pointer to which the SR module to be conf=
igured belongs to.
>> > @@ -839,6 +863,7 @@ void omap_sr_enable(struct voltagedomain *volt=
dm,
>> > =A0* omap_sr_disable() - API to disable SR without resetting the v=
oltage
>> > =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 processor voltage
>> > =A0* @voltdm: =A0 =A0VDD pointer to which the SR module to be conf=
igured belongs to.
>> > + * @volt_data: Voltage data to go to
>> > =A0*
>> > =A0* This API is to be called from the kernel in order to disable
>> > =A0* a particular smartreflex module. This API will in turn call
>> > @@ -846,7 +871,8 @@ void omap_sr_enable(struct voltagedomain *volt=
dm,
>> > =A0* the smartreflex class disable not to reset the VP voltage aft=
er
>> > =A0* disabling smartreflex.
>> > =A0*/
>> > -void omap_sr_disable(struct voltagedomain *voltdm)
>> > +void omap_sr_disable(struct voltagedomain *voltdm,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_data *vdata)
>> > =A0{
>> > =A0 =A0 =A0 =A0struct omap_sr *sr =3D _sr_lookup(voltdm);
>> >
>> > @@ -865,7 +891,7 @@ void omap_sr_disable(struct voltagedomain *vol=
tdm)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> > =A0 =A0 =A0 =A0}
>> >
>> > - =A0 =A0 =A0 sr_class->disable(voltdm, 0);
>> > + =A0 =A0 =A0 sr_class->disable(voltdm, vdata, 0);
>> > =A0}
>> >
>> > =A0/**
>> > @@ -898,7 +924,7 @@ void omap_sr_disable_reset_volt(struct voltage=
domain *voltdm)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> > =A0 =A0 =A0 =A0}
>> >
>> > - =A0 =A0 =A0 sr_class->disable(voltdm, 1);
>> > + =A0 =A0 =A0 sr_class->disable(voltdm, omap_voltage_get_nom_volt(=
voltdm), 1);
>> > =A0}
>> >
>> > =A0/**
>> > diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/v=
oltage.c
>> > index 77cb0cd..c451835 100644
>> > --- a/arch/arm/mach-omap2/voltage.c
>> > +++ b/arch/arm/mach-omap2/voltage.c
>> > @@ -374,9 +374,45 @@ static int nom_volt_debug_get(void *data, u64=
 *val)
>> > =A0 =A0 =A0 =A0return 0;
>> > =A0}
>> >
>> > +static int dyn_volt_debug_get(void *data, u64 *val)
>> > +{
>> > + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D (struct omap_vdd_info =
*) data;
>> > + =A0 =A0 =A0 struct omap_volt_data *volt_data;
>> > +
>> > + =A0 =A0 =A0 if (!vdd) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("Wrong paramater passed\n=
");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 volt_data =3D omap_voltage_get_nom_volt(&vdd->voltdm=
);
>> > +
>> > + =A0 =A0 =A0 *val =3D volt_data->volt_dynamic_nominal;
>> > +
>> > + =A0 =A0 =A0 return 0;
>> > +}
>> > +
>> > +static int calib_volt_debug_get(void *data, u64 *val)
>> > +{
>> > + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D (struct omap_vdd_info =
*) data;
>> > + =A0 =A0 =A0 struct omap_volt_data *volt_data;
>> > +
>> > + =A0 =A0 =A0 if (!vdd) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("Wrong paramater passed\n=
");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 volt_data =3D omap_voltage_get_nom_volt(&vdd->voltdm=
);
>> > +
>> > + =A0 =A0 =A0 *val =3D volt_data->volt_calibrated;
>> > +
>> > + =A0 =A0 =A0 return 0;
>> > +}
>> > +
>> > =A0DEFINE_SIMPLE_ATTRIBUTE(vp_volt_debug_fops, vp_volt_debug_get, =
NULL, "%llu\n");
>> > =A0DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops, nom_volt_debug_get=
, NULL,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%llu\n");
>> > +DEFINE_SIMPLE_ATTRIBUTE(dyn_volt_debug_fops, dyn_volt_debug_get, =
NULL,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%llu\n");
>> > +DEFINE_SIMPLE_ATTRIBUTE(calib_volt_debug_fops, calib_volt_debug_g=
et, NULL,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%llu\n");
>> > =A0static void vp_latch_vsel(struct omap_vdd_info *vdd)
>> > =A0{
>> > =A0 =A0 =A0 =A0u32 vpconfig;
>> > @@ -504,6 +540,12 @@ static void __init vdd_debugfs_init(struct om=
ap_vdd_info *vdd)
>> > =A0 =A0 =A0 =A0(void) debugfs_create_file("curr_nominal_volt", S_I=
RUGO,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd=
->debug_dir, (void *) vdd,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&no=
m_volt_debug_fops);
>> > + =A0 =A0 =A0 (void) debugfs_create_file("curr_dyn_nominal_volt", =
S_IRUGO,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd-=
>debug_dir, (void *) vdd,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &dyn=
_volt_debug_fops);
>> > + =A0 =A0 =A0 (void) debugfs_create_file("curr_calibrated_volt", S=
_IRUGO,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd-=
>debug_dir, (void *) vdd,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &cal=
ib_volt_debug_fops);
>> > =A0}
>> >
>> > =A0/* Voltage scale and accessory APIs */
>> > @@ -1132,6 +1174,33 @@ struct omap_volt_data *omap_voltage_get_nom=
_volt(struct voltagedomain *voltdm)
>> > =A0}
>> >
>> > =A0/**
>> > + * omap_voltage_calib_reset() - reset the calibrated voltage entr=
ies
>> > + * @voltdm: voltage domain to reset the entries for
>> > + *
>> > + * when the calibrated entries are no longer valid, this api allo=
ws
>> > + * the calibrated voltages to be reset.
>> > + */
>> > +int omap_voltage_calib_reset(struct voltagedomain *voltdm)
>> > +{
>> > + =A0 =A0 =A0 struct omap_vdd_info *vdd;
>> > + =A0 =A0 =A0 struct omap_volt_data *volt_data;
>> > +
>> > + =A0 =A0 =A0 if (IS_ERR_OR_NULL(voltdm)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: VDD specified does n=
ot exist!\n", __func__);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, v=
oltdm);
>> > + =A0 =A0 =A0 volt_data =3D vdd->volt_data;
>> > + =A0 =A0 =A0 /* reset the calibrated voltages as 0 */
>> > + =A0 =A0 =A0 while (volt_data->volt_nominal) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt_data->volt_calibrated =3D 0;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt_data++;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 return 0;
>> > +}
>> > +
>> > +/**
>> > =A0* omap_vp_get_curr_volt() - API to get the current vp voltage.
>> > =A0* @voltdm: =A0 =A0pointer to the VDD.
>> > =A0*
>> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconf=
ig
>> > index b6333ae..dba7939 100644
>> > --- a/arch/arm/plat-omap/Kconfig
>> > +++ b/arch/arm/plat-omap/Kconfig
>> > @@ -67,6 +67,23 @@ config OMAP_SMARTREFLEX_CLASS3
>> > =A0 =A0 =A0 =A0 =A0Class 3 implementation of Smartreflex employs c=
ontinuous hardware
>> > =A0 =A0 =A0 =A0 =A0voltage calibration.
>> >
>> > +config OMAP_SMARTREFLEX_CLASS1P5
>> > + =A0 =A0 =A0 bool "Class 1.5 mode of Smartreflex Implementation"
>> > + =A0 =A0 =A0 depends on OMAP_SMARTREFLEX && TWL4030_CORE
>> > + =A0 =A0 =A0 help
>> > + =A0 =A0 =A0 =A0 Say Y to enable Class 1.5 implementation of Smar=
treflex
>> > + =A0 =A0 =A0 =A0 Class 1.5 implementation of Smartreflex employs =
software controlled
>> > + =A0 =A0 =A0 =A0 hardware voltage calibration.
>> > +
>> > +config OMAP_SR_CLASS1P5_RECALIBRATION_DELAY
>> > + =A0 =A0 =A0 int "Class 1.5 mode recalibration recalibration dela=
y(ms)"
>> > + =A0 =A0 =A0 depends on OMAP_SMARTREFLEX_CLASS1P5
>> > + =A0 =A0 =A0 default 86400000
>> > + =A0 =A0 =A0 help
>> > + =A0 =A0 =A0 =A0 Setup the recalibration delay in milliseconds. U=
se 0 for never doing
>> > + =A0 =A0 =A0 =A0 a recalibration. Defaults to recommended recalib=
ration every 24hrs.
>> > + =A0 =A0 =A0 =A0 If you do not understand this, use the default.
>> > +
>> > =A0config OMAP_RESET_CLOCKS
>> > =A0 =A0 =A0 =A0bool "Reset unused clocks during boot"
>> > =A0 =A0 =A0 =A0depends on ARCH_OMAP
>> > diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/=
arm/plat-omap/include/plat/smartreflex.h
>> > index 07f35b2..ee5c58f 100644
>> > --- a/arch/arm/plat-omap/include/plat/smartreflex.h
>> > +++ b/arch/arm/plat-omap/include/plat/smartreflex.h
>> > @@ -167,6 +167,7 @@ struct omap_sr_pmic_data {
>> > =A0#define SR_CLASS1 =A0 =A0 =A00x1
>> > =A0#define SR_CLASS2 =A0 =A0 =A00x2
>> > =A0#define SR_CLASS3 =A0 =A0 =A00x3
>> > +#define SR_CLASS1P5 =A0 =A00x4
>> >
>> > =A0/**
>> > =A0* struct omap_sr_class_data - Smartreflex class driver info
>> > @@ -187,7 +188,9 @@ struct omap_sr_pmic_data {
>> > =A0struct omap_sr_class_data {
>> > =A0 =A0 =A0 =A0int (*enable)(struct voltagedomain *voltdm,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_volt_da=
ta *volt_data);
>> > - =A0 =A0 =A0 int (*disable)(struct voltagedomain *voltdm, int is_=
volt_reset);
>> > + =A0 =A0 =A0 int (*disable)(struct voltagedomain *voltdm,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_dat=
a *volt_data,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int is_volt_reset);
>> > =A0 =A0 =A0 =A0int (*class_init)(struct voltagedomain *voltdm, voi=
d *class_priv_data);
>> > =A0 =A0 =A0 =A0int (*class_deinit)(struct voltagedomain *voltdm,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *class_priv_da=
ta);
>> > @@ -235,7 +238,8 @@ struct omap_sr_data {
>> > =A0/* Smartreflex module enable/disable interface */
>> > =A0void omap_sr_enable(struct voltagedomain *voltdm,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_volt_da=
ta *volt_data);
>> > -void omap_sr_disable(struct voltagedomain *voltdm);
>> > +void omap_sr_disable(struct voltagedomain *voltdm,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_dat=
a *volt_data);
>> > =A0void omap_sr_disable_reset_volt(struct voltagedomain *voltdm);
>> >
>> > =A0/* API to register the pmic specific data with the smartreflex =
driver. */
>> > @@ -250,6 +254,7 @@ int sr_configure_minmax(struct voltagedomain *=
voltdm);
>> >
>> > =A0/* API to register the smartreflex class driver with the smartr=
eflex driver */
>> > =A0int sr_register_class(struct omap_sr_class_data *class_data);
>> > +bool is_sr_enabled(struct voltagedomain *voltdm);
>> > =A0#else
>> > =A0static inline void omap_sr_enable(struct voltagedomain *voltdm)=
 {}
>> > =A0static inline void omap_sr_disable(struct voltagedomain *voltdm=
) {}
>> > @@ -264,5 +269,9 @@ static inline void omap_sr_disable_reset_volt(
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct voltagedomain *voltdm) {}
>> > =A0static inline void omap_sr_register_pmic(
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_sr_pmic_data *pmic_data=
) {}
>> > +static inline bool is_sr_enabled(struct voltagedomain *voltdm)
>> > +{
>> > + =A0 =A0 =A0 return false;
>> > +}
>> > =A0#endif
>> > =A0#endif
>> > diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/=
plat-omap/include/plat/voltage.h
>> > index 332c581..54445f0 100644
>> > --- a/arch/arm/plat-omap/include/plat/voltage.h
>> > +++ b/arch/arm/plat-omap/include/plat/voltage.h
>> > @@ -58,6 +58,8 @@
>> > =A0#define OMAP4430_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 9300=
00
>> > =A0#define OMAP4430_VDD_CORE_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A01100=
000
>> >
>> > +#define OMAP3PLUS_DYNAMIC_NOMINAL_MARGIN_UV =A0 =A050000
>> > +
>> > =A0/**
>> > =A0* struct voltagedomain - omap voltage domain global structure.
>> > =A0* @name: =A0 =A0 =A0Name of the voltage domain which can be use=
d as a unique
>> > @@ -81,6 +83,8 @@ struct voltagedomain {
>> > =A0*/
>> > =A0struct omap_volt_data {
>> > =A0 =A0 =A0 =A0u32 =A0 =A0 volt_nominal;
>> > + =A0 =A0 =A0 u32 =A0 =A0 volt_calibrated;
>> > + =A0 =A0 =A0 u32 =A0 =A0 volt_dynamic_nominal;
>> > =A0 =A0 =A0 =A0u32 =A0 =A0 sr_efuse_offs;
>> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0sr_errminlimit;
>> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0vp_errgain;
>> > @@ -127,6 +131,7 @@ struct omap_volt_data *omap_voltage_get_nom_vo=
lt(struct voltagedomain *voltdm);
>> > =A0bool omap_vp_is_transdone(struct voltagedomain *voltdm);
>> > =A0bool omap_vp_clear_transdone(struct voltagedomain *voltdm);
>> > =A0struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *vo=
ltdm);
>> > +int omap_voltage_calib_reset(struct voltagedomain *voltdm);
>> > =A0#ifdef CONFIG_PM
>> > =A0int omap_voltage_register_pmic(struct voltagedomain *voltdm,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_volt_pmic_info *pmic_in=
fo);
>> > @@ -160,7 +165,23 @@ static inline unsigned long omap_get_operatio=
n_voltage(
>> > =A0{
>> > =A0 =A0 =A0 =A0if (IS_ERR_OR_NULL(vdata))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>> > - =A0 =A0 =A0 return vdata->volt_nominal;
>> > + =A0 =A0 =A0 return (vdata->volt_calibrated) ? vdata->volt_calibr=
ated :
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (vdata->volt_dynamic_nominal) ? vdat=
a->volt_dynamic_nominal :
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdata->volt_nominal;
>> > =A0}
>> >
>> > +/* what is my dynamic nominal? */
>> > +static inline unsigned long omap_get_dyn_nominal(struct omap_volt=
_data *vdata)
>> > +{
>> > + =A0 =A0 =A0 if (IS_ERR_OR_NULL(vdata))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> > + =A0 =A0 =A0 if (vdata->volt_calibrated) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long v =3D vdata->volt_cali=
brated +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3PLUS_DYNAMIC_NO=
MINAL_MARGIN_UV;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (v > vdata->volt_nominal)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return vdata->volt_n=
ominal;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return v;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 return vdata->volt_nominal;
>> > +}
>> > =A0#endif
>> > --
>> > 1.7.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>> I have tested this Patch Series on OMAP 3630 SDP, =A0for MPU and IVA=
 Powerdomains
> Could you clarify on null pointer issue: on SDP3630? or OMAP4SDP? I
> see there is a risk with OMAP4 where there is a bug in the following
> scenario:
> bootloader setups the OPP frequency for an OPP(e.g. 1GHz) which is
> disabled by default on OPP table in kernel. this needs to be cleanly
> fixed in pm.c, at the same time, the exposed functions in class1p5
> needs parameter validation as well.
Sorry, it is reproduced on OMAP 4430 SDP.
>> it throws error log "Unable to refer to NULL pointer" if
>> curr_nominal_volt, curr_calibrated_volt
>> or curr_dynamical_volt is accessed through debugfs.
>> Could you please provide fix for this.
>
>
> Regards,
> Nishanth Menon
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
