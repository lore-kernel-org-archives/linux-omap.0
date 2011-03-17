From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 18/19] OMAP3630+: SR: add support for class 1.5
Date: Thu, 17 Mar 2011 12:57:00 -0700
Message-ID: <87y64d1pwz.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-19-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50348 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754358Ab1CQUBT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 16:01:19 -0400
Received: by iym7 with SMTP id 7so3996748iym.18
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 13:01:14 -0700 (PDT)
In-Reply-To: <1299338962-5602-19-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Ambresh K <ambresh@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Igor Dmitriev <ext-dmitriev.igor@nokia.com>, Peter 'p2' De Schrijver <Peter.De-Schrijver@nokia.com>

Nishanth Menon <nm@ti.com> writes:

> Traditional SmartReflex AVS(Automatic Voltage Scaling) classes are:
> * Class 0 - Product test calibration
> 	Silicon is calibration at production floor and fused with voltages
> 	for each OPP
> * Class 1 - Boot time calibration
> 	Silicon is calibrated once at boot time and voltages are stored for
> 	the lifetime of operation.
> * Class 2 - Continuous s/w calibration
> 	SR module notifies s/w for any change in the system which is desired
> 	and the s/w makes runtime decisions in terms of setting the voltage,
> 	this mechanism could be used in the system which does not have PMIC
> 	capable of SR without using the voltage controller and voltage
> 	processor blocks.
> * Class 3 - Continuous h/w calibration
> 	SR module is switch on after reaching a voltage level and SR
> 	continuously monitors the system and makes runtime adjustments witho=
ut
> 	s/w involvement.
>
> OMAP3430 has used SmartReflex AVS and with a a PMIC which understands=
 the SR
> protocol, Class 3 has been used. With OMAP3630 onwards, a new SmartRe=
flex AVS
> class of operation Class 1.5 was introduced.
> * Class 1.5 - Periodic s/w calibration
> 	This uses the h/w calibration loop and at the end of calibration
> 	stores the voltages to be used run time, periodic recalibration is
> 	performed as well.
>
> The operational mode is describes as the following:
> * SmartReflex AVS h/w calibration loop is essential to identify the o=
ptimal
> 	voltage for a given OPP.
> * Once this optimal voltage is detected, SmartReflex AVS loop is disa=
bled in
> 	class 1.5 mode of operation.
> * Until there is a need for a recalibration, any further transition t=
o an OPP
> 	voltage which is calibrated can use the calibrated voltage and does =
not
> 	require enabling the SR AVS h/w loop.
> * On a periodic basis (recommendation being once approximately every =
24 hours),
> 	software is expected to perform a recalibration to find a new optima=
l
> 	voltage which is compensated for device aging.
> 	- For performing this recalibration, the start voltage does not need=
 to
> 	be the nominal voltage anymore. instead, the system can start with a
> 	voltage which is 50mV higher than the previously calibrated voltage =
to
> 	identify the new optimal voltage as the aging factor within a period=
 of
> 	1 day is not going to be anywhere close to 50mV.
> 	- This "new starting point" for recalibration is called a dynamic
> 	nominal voltage for that voltage point.
> In short, with the introduction of SmartReflex class 1.5, there are t=
hree new
> voltages possible in a system's DVFS transition:
> * Nominal Voltage - The maximum voltage needed for a worst possible d=
evice
> 	in the worst possible conditions. This is the voltage we choose as
> 	the starting point for the h/w loop to optimize for the first time
> 	calibration on system bootup.
> * Dynamic Nominal Voltage - Worst case voltage for a specific device =
in
> 	considering the system aging on the worst process device.
> * Calibrated Voltage - Best voltage for the current device at a given=
 point
> 	of time.
>
> In terms of the implementation, doing calibration involves waiting fo=
r the
> SmartReflex h/w loop to settle down, and doing this as part of the DV=
=46S flow
> itself is to increase the latency of DVFS transition when there is a =
need to
> calibrate that opp. instead, the calibration is performed "out of pat=
h" using
> a workqueue statemachine. The workqueue waits for the system stabiliz=
ation,
> then enables VP interrupts to monitor for system instability interms =
of voltage
> oscillations that are reported back to the system as interrupts, in c=
ase of
> prolonged system oscillations, nominal voltage is chosen as a safe vo=
ltage and
> this event is logged in the system log for developer debug and fixing=
=2E
>
> For the recalibration, a common workqueue for all domains is started =
at the
> start of the class initialization and it resets the calibrated voltag=
es
> on a periodic basis. For distros that may choose not to do the recomm=
ended
> periodic recalibration, instead choose to perform boot time calibrati=
on,
> kconfig configuration option is provided to do so.
>
> TODO:
> a) Cpuidle and suspend paths are not integrated with SmartReflex driv=
er at
>    this point.
> b) Since the SR registers are accessed and controlled in parallel to =
DVFS
>    some sort of mechanism is necessary to be introduced along with OM=
AP
>    DVFS layer to ensure mutual exclusivity
> c) Additional debug interfaces for vmin analysis for platform charact=
erization
>    and addition of system margin needs to be introduced from SmartRef=
lex
>    perspective.
>
> This implementation also includes the following contributors:
> Tony Lindgren for suggestion on using interrupt based mechanism inste=
ad of
> polling to detect voltage oscillations.
> Peter 'p2' De Schrijver for debating alternatives on recalibration me=
chanisms
> Paul Walmsey, Eduardo Valentin, Ambresh K, Igor Dmitriev and quiet a =
few others
> for patient review, testing and reporting of issues of a previous inc=
arnation
> of this implemenation. Last, but not the least, the TI H/w team in in=
troducing
> this new SR AVS class and patiently debating it's various facets.
>
> Cc: Ambresh K <ambresh@ti.com>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> Cc: Igor Dmitriev <ext-dmitriev.igor@nokia.com>
> Cc: Paul <paul@pwsan.com>
> Cc: Peter 'p2' De Schrijver <Peter.De-Schrijver@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

You're the expert on SR1.5, but I have some comments on code and data
structure organization to improve readability.  It may be because I'm
not deeply familiar with SR1.5, but I found code organization and data
structures difficult to follow and thus understand.

> ---
>
> NOTE: this patch generates a false postive checkpatch warning:
>  WARNING: please write a paragraph that describes the config symbol f=
ully
>  #989: FILE: arch/arm/plat-omap/Kconfig:73:
>  +	help
>
>  WARNING: please write a paragraph that describes the config symbol f=
ully
>  #998: FILE: arch/arm/plat-omap/Kconfig:82:
>  +	help
>
> There is a help documentation for each of these, but it looks like ch=
eckpatch
> aint too intelligent about it.

Agreed.  I think checkpatch wants to see a certain number of lines in
the help text, and whines if they're not there.=20

>  arch/arm/mach-omap2/Makefile               |    1 +
>  arch/arm/mach-omap2/smartreflex-class1p5.c |  582 ++++++++++++++++++=
++++++++++
>  arch/arm/mach-omap2/smartreflex-class3.c   |    4 +-
>  arch/arm/mach-omap2/smartreflex.c          |   26 ++-
>  arch/arm/mach-omap2/smartreflex.h          |   10 +-
>  arch/arm/mach-omap2/voltage.c              |   79 ++++
>  arch/arm/mach-omap2/voltage.h              |   23 +-
>  arch/arm/plat-omap/Kconfig                 |   17 +
>  8 files changed, 738 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/smartreflex-class1p5.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index d566e78..1d4d2ff 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+=3D pm44xx.o pm_bus.o
>  obj-$(CONFIG_PM_DEBUG)			+=3D pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)          +=3D sr_device.o smartreflex=
=2Eo
>  obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+=3D smartreflex-class3.o
> +obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS1P5)	+=3D smartreflex-class1p5.o

Minor: personal preference here, but I don't like the 1p5 naming.  I'd
rather see 1_5 or even 15, but I'll leave that to you.

>  AFLAGS_sleep24xx.o			:=3D-Wa,-march=3Darmv6
>  AFLAGS_sleep34xx.o			:=3D-Wa,-march=3Darmv7-a
> diff --git a/arch/arm/mach-omap2/smartreflex-class1p5.c b/arch/arm/ma=
ch-omap2/smartreflex-class1p5.c
> new file mode 100644
> index 0000000..fdd28f7
> --- /dev/null
> +++ b/arch/arm/mach-omap2/smartreflex-class1p5.c
> @@ -0,0 +1,582 @@
> +/*
> + * Smart reflex Class 1.5 specific implementations
> + *
> + * Copyright (C) 2010-2011 Texas Instruments, Inc.
> + * Nishanth Menon <nm@ti.com>
> + *
> + * Smart reflex class 1.5 is also called periodic SW Calibration
> + * Some of the highlights are as follows:
> + * =E2=80=93 Host CPU triggers OPP calibration when transitioning to=
 non calibrated
> + *   OPP
> + * =E2=80=93 SR-AVS + VP modules are used to perform calibration
> + * =E2=80=93 Once completed, the SmartReflex-AVS module can be disab=
led
> + * =E2=80=93 Enables savings based on process, supply DC accuracy an=
d aging
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/fs.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>

Is this header needed?

> +#include <linux/kobject.h>

or this one?

> +#include <linux/workqueue.h>
> +#include <linux/opp.h>
> +
> +#include "smartreflex.h"
> +#include "voltage.h"
> +
> +#define MAX_VDDS 3
> +#define SR1P5_SAMPLING_DELAY_MS	1
> +#define SR1P5_STABLE_SAMPLES	5
> +#define SR1P5_MAX_TRIGGERS	5
> +
> +/*
> + * we expect events in 10uS, if we dont get 2wice times as much,
> + * we could kind of ignore this as a missed event.
> + */
> +#define MAX_CHECK_VPTRANS_US	20
> +
> +/**
> + * struct sr_class1p5_work_data - data meant to be used by calibrati=
on work
> + * @work:	calibration work
> + * @voltdm:		voltage domain for which we are triggering
> + * @vdata:	voltage data we are calibrating
> + * @num_calib_triggers:	number of triggers from calibration loop
> + * @num_osc_samples:	number of samples collected by isr
> + * @work_active:	have we scheduled a work item?
> + */
> +struct sr_class1p5_work_data {
> +	struct delayed_work work;
> +	struct voltagedomain *voltdm;
> +	struct omap_volt_data *vdata;
> +	u8 num_calib_triggers;
> +	u8 num_osc_samples;
> +	bool work_active;
> +};

Again, the 1p5 naming I think is a hinderance to readability.

As these are file-local, I don't think you need the sr_class1p5_ prefix=
=2E

> +#if CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY
> +/* recal_work:	recalibration calibration work */
> +static struct delayed_work recal_work;
> +#endif

No Kconfig for this option please, let's make a reasonable default and
allow board code to override.

> +/**
> + * struct sr_class1p5_data - private data for class 1p5
> + * @work_data:		work item data per voltage domain
> + */
> +struct sr_class1p5_data {
> +	struct sr_class1p5_work_data work_data[MAX_VDDS];
> +};
> +
> +static void sr_class1p5_reset_calib(struct voltagedomain *voltdm, bo=
ol reset,
> +				    bool recal);
> +
> +/* our instance of class 1p5 private data */
> +static struct sr_class1p5_data class_1p5_data;

'class1p5_data' is also used below as the name of the 'struct
omap_sr_class_data'.  Another name for this would help readability/grep=
ability


> +static struct sr_class1p5_work_data *get_sr1p5_work(struct voltagedo=
main
> +						    *voltdm)

as a static function, get_work should suffice

> +{
> +	int idx;

insert blank line

> +	for (idx =3D 0; idx < MAX_VDDS; idx++) {
> +		if (class_1p5_data.work_data[idx].voltdm && !strcmp
> +		    (class_1p5_data.work_data[idx].voltdm->name, voltdm->name))
> +			return &class_1p5_data.work_data[idx];
> +	}

insert blank line

Also, should do this such that you don't need to do continually do
string compares.  Since you need to keep a mapping of voltdm -> SR clas=
s
data you should make something simple for it.

Using your current names, how about something like this (not even
compile tested):

static struct {
       struct voltagedomain *voltdm;
       struct sr_class1p5_work_data *work_data;
} voltdm_to_work[MAX_VDDS];

static struct sr_class1p5_work_data *get_sr1p5_work(struct voltagedomai=
n
						    *voltdm)
{
        int i;
        struct sr_class1p5_work_data *work_data =3D NULL;

        for( i =3D 0; i < MAX_VDDS; i++) {
             struct voltagedomain *v =3D voltdm_to_work[i];

             if (v && v =3D=3D voltdm)
                   work_data =3D voltdm_to_work[i].work_data;
        }

        return work_data;
}

And you could probably have a 'set_work' helper as well.  Maybe this ca=
n
be initialized in the class->configure hook instead of having to be don=
e
in the ->start hook each time ?


> +	return ERR_PTR(-ENODATA);
> +}
> +
> +/**
> + * sr_class1p5_notify() - isr notifier for status events
> + * @voltdm:	voltage domain for which we were triggered
> + * @status:	notifier event to use
> + *
> + * This basically collects data for the work to use.
> + */
> +static int sr_class1p5_notify(struct voltagedomain *voltdm, u32 stat=
us)
> +{
> +	struct sr_class1p5_work_data *work_data;
> +	int idx =3D 0;

s/idx/i/

> +	if (IS_ERR_OR_NULL(voltdm)) {

on input parameters checking for NULL should suffice.

Please fix throughout this patch (and series)

> +		pr_err("%s: bad parameters!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	work_data =3D get_sr1p5_work(voltdm);
> +	if (unlikely(!work_data)) {
> +		pr_err("%s:%s no work data!!\n", __func__, voltdm->name);
> +		return -EINVAL;
> +	}
> +
> +	/* Wait for transdone so that we know the voltage to read */
> +	do {

readablity: use:

   for(i =3D 0; i < MAX_CHECK_VPTRANS_US; i++)

> +		if (omap_vp_is_transdone(voltdm))
> +			break;
> +		idx++;

then drop this

> +		/* get some constant delay */

comment does not help understand code, remove

> +		udelay(1);
> +	} while (idx < MAX_CHECK_VPTRANS_US);

and this

> +	/*
> +	 * If we timeout, we still read the data,
> +	 * if we are oscillating+irq latencies are too high, we could

s/irq/IRQ/

> +	 * have scenarios where we miss transdone event. since
> +	 * we waited long enough, it is still safe to read the voltage
> +	 * as we would have waited long enough - still flag it..
> +	 */

/me no understand

> +	if (idx >=3D MAX_CHECK_VPTRANS_US)
> +		pr_warning("%s: timed out waiting for transdone!!\n", __func__);
> +
> +	omap_vp_clear_transdone(voltdm);
> +
> +	idx =3D (work_data->num_osc_samples) % SR1P5_STABLE_SAMPLES;

idx not used after this

> +	work_data->num_osc_samples++;
> +
> +	return 0;
> +}
> +
> +/**
> + * do_calibrate() - work which actually does the calibration
> + * @work: pointer to the work
> + *
> + * calibration routine uses the following logic:
> + * on the first trigger, we start the isr to collect sr voltages

s/isr/ISR/ (and below)

> + * wait for stabilization delay (reschdule self instead of sleeping)

"instead of sleeping"  ?  you'll indeed sleep until the delayed work is=
 run

> + * after the delay, see if we collected any isr events
> + * if none, we have calibrated voltage.
> + * if there are any, we retry untill we giveup.

until we give up

> + * on retry timeout, select a voltage to use as safe voltage.
> + */
> +static void do_calibrate(struct work_struct *work)
> +{
> +	struct sr_class1p5_work_data *work_data =3D
> +	    container_of(work, struct sr_class1p5_work_data, work.work);

Doesn't a work_struct have a data field?  I thought it was meant for
this kind of thing, so you don't have to do a container_of()

> +	unsigned long u_volt_safe =3D 0, u_volt_current =3D 0;
> +	struct omap_volt_data *volt_data;
> +	struct voltagedomain *voltdm;
> +
> +	if (unlikely(!work_data)) {
> +		pr_err("%s: ooops.. null work_data?\n", __func__);
> +		return;
> +	}
> +
> +	/*
> +	 * TODO:Handle the case where we might have just been scheduled AND
> +	 * 1.5 disable was called. check and HOLD DVFS
> +	 */
> +
> +	voltdm =3D work_data->voltdm;
> +	/*
> +	 * In the unlikely case that we did get through when unplanned,
> +	 * flag and return.
> +	 */
> +	if (unlikely(!work_data->work_active)) {
> +		pr_err("%s:%s unplanned work invocation!\n", __func__,
> +		       voltdm->name);
> +		/* TODO release the DVFS */
> +		return;
> +	}
> +
> +	work_data->num_calib_triggers++;
> +	/* if we are triggered first time, we need to start isr to sample *=
/
> +	if (work_data->num_calib_triggers =3D=3D 1)
> +		goto start_sampling;
> +
> +	/* Stop isr from interrupting our measurements :) */

ISR. =20

What is the smiley supposed to mean?

> +	sr_notifier_control(voltdm, false);
> +
> +	volt_data =3D work_data->vdata;
> +
> +	/* if there are no samples captured.. SR is silent, aka stability! =
*/

Couldn't this also be zero when sampling is initially triggered.  Is
there a race here?

> +	if (!work_data->num_osc_samples) {
> +		u_volt_safe =3D omap_vp_get_curr_volt(voltdm);
> +		u_volt_current =3D u_volt_safe;
> +		goto done_calib;
> +	}
> +	if (work_data->num_calib_triggers =3D=3D SR1P5_MAX_TRIGGERS) {
> +		pr_warning("%s: %s recalib timeout!\n", __func__,
> +			   work_data->voltdm->name);
> +		goto oscillating_calib;
> +	}
> +
> +	/* we have potential oscillations/first sample */
> +start_sampling:
> +	work_data->num_osc_samples =3D 0;
> +	/* Clear pending events */

comment doesn't match following code

> +	sr_notifier_control(voltdm, false);
> +	/* Clear all transdones */

comment doesn't add anything to code

> +	while (omap_vp_is_transdone(voltdm))
> +		omap_vp_clear_transdone(voltdm);
> +	/* trigger sampling */
> +	sr_notifier_control(voltdm, true);
> +	schedule_delayed_work(&work_data->work,
> +			      msecs_to_jiffies(SR1P5_SAMPLING_DELAY_MS *
> +					       SR1P5_STABLE_SAMPLES));
> +	/* TODO: release DVFS */
> +	return;
> +
> +oscillating_calib:
> +	/* Use the nominal voltage as the safe voltage */
> +	u_volt_safe =3D volt_data->volt_nominal;
> +	/* pick up current voltage to switch if needed */
> +	u_volt_current =3D omap_vp_get_curr_volt(voltdm);
> +
> +	/* Fall through to close up common stuff */
> +done_calib:
> +	omap_vp_disable(voltdm);
> +	sr_disable(voltdm);
> +
> +	volt_data->volt_calibrated =3D u_volt_safe;
> +	/* Setup my dynamic voltage for the next calibration for this opp *=
/
> +	volt_data->volt_dynamic_nominal =3D omap_get_dyn_nominal(volt_data)=
;
> +
> +	/*
> +	 * if the voltage we decided as safe is not the current voltage,
> +	 * switch
> +	 */
> +	if (volt_data->volt_calibrated !=3D u_volt_current) {
> +		pr_debug("%s:%s reconfiguring to voltage %d\n",
> +			 __func__, voltdm->name, volt_data->volt_calibrated);
> +		omap_voltage_scale_vdd(voltdm, volt_data);
> +	}
> +
> +	/*
> +	 * TODO: Setup my wakeup voltage to allow immediate going to OFF an=
d
> +	 * on - Pending twl and voltage layer cleanups.
> +	 * This is necessary, as this is not done as part of regular
> +	 * Dvfs flow.
> +	 * vc_setup_on_voltage(voltdm, volt_data->volt_calibrated);
> +	 */
> +	work_data->work_active =3D false;
> +	/* TODO: release DVFS */
> +}
> +
> +#if CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY
> +/**
> + * do_recalibrate() - work which actually does the calibration
> + * @work: pointer to the work
> + *
> + * on a periodic basis, we come and reset our calibration setup
> + * so that a recalibration of the OPPs take place. This takes
> + * care of aging factor in the system.
> + */
> +static void do_recalibrate(struct work_struct *work)
> +{
> +	struct voltagedomain *voltdm;
> +	int idx;
> +	static struct sr_class1p5_work_data *work_data;
> +
> +	for (idx =3D 0; idx < MAX_VDDS; idx++) {
> +		work_data =3D &class_1p5_data.work_data[idx];
> +		voltdm =3D work_data->voltdm;
> +		if (voltdm) {
> +			/* if sr is not enabled, we check later */
> +			if (!is_sr_enabled(voltdm))
> +				continue;
> +			/* TODO: Pause the DVFS transitions */
> +			/* if sr is not enabled, we check later */
> +
> +			/* Reset and force a recalibration for current opp */
> +			sr_class1p5_reset_calib(voltdm, true, true);
> +
> +			/* TODO: unpause DVFS transitions */
> +		}
> +	}
> +	/* We come back again after time the usual delay */
> +	schedule_delayed_work(&recal_work,
> +	      msecs_to_jiffies(CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY)=
);
> +}
> +#endif /* CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY */
> +
> +/**
> + * sr_class1p5_enable() - class 1.5 mode of enable
> + * @voltdm:		voltage domain to enable SR for
> + * @volt_data:	voltdata to the voltage transition taking place
> + *
> + * when this gets called, we use the h/w loop to setup our voltages
> + * to an calibrated voltage, detect any oscillations, recover from t=
he same
> + * and finally store the optimized voltage as the calibrated voltage=
 in the
> + * system
> + */
> +static int sr_class1p5_enable(struct voltagedomain *voltdm,
> +			      struct omap_volt_data *volt_data)
> +{
> +	int r;
> +	struct sr_class1p5_work_data *work_data;
> +
> +	if (IS_ERR_OR_NULL(voltdm) || IS_ERR_OR_NULL(volt_data)) {
> +		pr_err("%s: bad parameters!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/* if already calibrated, nothing to do here.. */
> +	if (volt_data->volt_calibrated)
> +		return 0;
> +
> +	work_data =3D get_sr1p5_work(voltdm);
> +	if (unlikely(!work_data)) {
> +		pr_err("%s: aieeee.. bad work data??\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (work_data->work_active)
> +		return 0;
> +
> +	omap_vp_enable(voltdm);
> +	r =3D sr_enable(voltdm, volt_data);
> +	if (r) {
> +		pr_err("%s: sr[%s] failed\n", __func__, voltdm->name);
> +		omap_vp_disable(voltdm);
> +		return r;
> +	}
> +	work_data->vdata =3D volt_data;
> +	work_data->work_active =3D true;
> +	work_data->num_calib_triggers =3D 0;
> +	/* program the workqueue and leave it to calibrate offline.. */
> +	schedule_delayed_work(&work_data->work,
> +			      msecs_to_jiffies(SR1P5_SAMPLING_DELAY_MS *
> +					       SR1P5_STABLE_SAMPLES));
> +
> +	return 0;
> +}
> +
> +/**
> + * sr_class1p5_disable() - disable for class 1p5
> + * @voltdm: voltage domain for the sr which needs disabling
> + * @volt_data:	voltagedata to disable
> + * @is_volt_reset: reset the voltage?
> + *
> + * we dont do anything if the class 1p5 is being used. this is becau=
se we
> + * already disable sr at the end of calibration and no h/w loop is a=
ctually
> + * active when this is called.
> + */
> +static int sr_class1p5_disable(struct voltagedomain *voltdm,
> +			       struct omap_volt_data *volt_data,
> +			       int is_volt_reset)
> +{
> +	struct sr_class1p5_work_data *work_data;
> +
> +	if (IS_ERR_OR_NULL(voltdm) || IS_ERR_OR_NULL(volt_data)) {
> +		pr_err("%s: bad parameters!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	work_data =3D get_sr1p5_work(voltdm);
> +	if (work_data->work_active) {
> +		/* if volt reset and work is active, we dont allow this */
> +		if (is_volt_reset)
> +			return -EBUSY;
> +		/* flag work is dead and remove the old work */
> +		work_data->work_active =3D false;
> +		cancel_delayed_work_sync(&work_data->work);
> +		sr_notifier_control(voltdm, false);
> +		omap_vp_disable(voltdm);
> +		sr_disable(voltdm);
> +	}
> +
> +	/* if already calibrated, nothin special to do here.. */
> +	if (volt_data->volt_calibrated)
> +		return 0;
> +
> +	if (is_volt_reset)
> +		omap_voltage_reset(voltdm);
> +	return 0;
> +}
> +
> +/**
> + * sr_class1p5_configure() - configuration function
> + * @voltdm:	configure for which voltage domain
> + *
> + * we dont do much here other than setup some registers for
> + * the sr module involved.
> + */
> +static int sr_class1p5_configure(struct voltagedomain *voltdm)
> +{
> +	if (IS_ERR_OR_NULL(voltdm)) {
> +		pr_err("%s: bad parameters!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	return sr_configure_errgen(voltdm);
> +}
> +
> +/**
> + * sr_class1p5_reset_calib() - reset all calibrated voltages
> + * @voltdm:	configure for which voltage domain
> + * @reset:	reset voltage before we recal?
> + * @recal:	should I recalibrate my current opp?
> + *
> + * if we call this, it means either periodic calibration trigger was
> + * fired(either from sysfs or other mechanisms) or we have disabled =
class 1p5,
> + * meaning we cant trust the calib voltages anymore, it is better to=
 use
> + * nominal in the system
> + */
> +static void sr_class1p5_reset_calib(struct voltagedomain *voltdm, bo=
ol reset,
> +				    bool recal)
> +{
> +	struct sr_class1p5_work_data *work_data;
> +
> +	/* I dont need to go further if sr is not present */
> +	if (!is_sr_enabled(voltdm))
> +		return;
> +
> +	work_data =3D get_sr1p5_work(voltdm);
> +
> +	if (work_data->work_active)
> +		sr_class1p5_disable(voltdm, work_data->vdata, 0);
> +
> +	omap_voltage_calib_reset(voltdm);
> +
> +	/*
> +	 * I should now reset the voltages to my nominal to be safe
> +	 */
> +	if (reset)
> +		omap_voltage_reset(voltdm);
> +
> +	/*
> +	 * I should fire a recalibration for current opp if needed
> +	 * Note: i have just reset my calibrated voltages, and if
> +	 * i call sr_enable equivalent, I will cause a recalibration
> +	 * loop, even though the function is called sr_enable.. we
> +	 * are in class 1.5 ;)
> +	 */
> +	if (reset && recal)
> +		sr_class1p5_enable(voltdm, work_data->vdata);
> +}
> +
> +/**
> + * sr_class1p5_start() - class 1p5 init
> + * @voltdm:		sr voltage domain
> + * @class_priv_data:	private data for the class
> + *
> + * we do class specific initialization like creating sysfs/debugfs e=
ntries
> + * needed, spawning of a kthread if needed etc.
> + */
> +static int sr_class1p5_start(struct voltagedomain *voltdm,
> +			     void *class_priv_data)
> +{
> +	struct sr_class1p5_work_data *work_data;
> +	int idx;
> +
> +	if (IS_ERR_OR_NULL(voltdm) || IS_ERR_OR_NULL(class_priv_data)) {
> +		pr_err("%s: bad parameters!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/* setup our work params */
> +	work_data =3D get_sr1p5_work(voltdm);
> +	if (!IS_ERR_OR_NULL(work_data)) {
> +		pr_err("%s: ooopps.. class already initialized for %s! bug??\n",
> +		       __func__, voltdm->name);
> +		return -EINVAL;
> +	}
> +	work_data =3D NULL;
> +	/* get the next spare work_data */
> +	for (idx =3D 0; idx < MAX_VDDS; idx++) {
> +		if (!class_1p5_data.work_data[idx].voltdm) {
> +			work_data =3D &class_1p5_data.work_data[idx];
> +			break;
> +		}
> +	}
> +	if (!work_data) {
> +		pr_err("%s: no more space for work data for domains!\n",
> +			__func__);
> +		return -ENOMEM;
> +	}
> +	work_data->voltdm =3D voltdm;
> +	INIT_DELAYED_WORK_DEFERRABLE(&work_data->work, do_calibrate);

Much of this looks to be one-time init stuff.  Wouldn't that be better
in the ->configure method?

> +	return 0;
> +}
> +
> +/**
> + * sr_class1p5_stop() - class 1p5 deinitialization
> + * @voltdm:	voltage domain for which to do this.
> + * @class_priv_data: class private data for deinitialiation
> + *
> + * currently only resets the calibrated voltage forcing DVFS voltage=
s
> + * to be used in the system
> + */
> +static int sr_class1p5_stop(struct voltagedomain *voltdm,
> +			       void *class_priv_data)
> +{
> +	struct sr_class1p5_work_data *work_data;
> +
> +	if (IS_ERR_OR_NULL(voltdm) || IS_ERR_OR_NULL(class_priv_data)) {
> +		pr_err("%s: bad parameters!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/* setup our work params */
> +	work_data =3D get_sr1p5_work(voltdm);
> +	if (IS_ERR_OR_NULL(work_data)) {
> +		pr_err("%s: ooopps.. class not initialized for %s! bug??\n",
> +		       __func__, voltdm->name);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * we dont have SR periodic calib anymore.. so reset calibs
> +	 * we are already protected by sr debugfs lock, so no lock needed
> +	 * here.
> +	 */
> +	sr_class1p5_reset_calib(voltdm, true, false);
> +
> +	/* reset all data for this work data */
> +	memset(work_data, 0, sizeof(*work_data));
> +
> +	return 0;
> +}
> +
> +/* SR class1p5 structure */
> +static struct omap_sr_class_data class1p5_data =3D {
> +	.enable =3D sr_class1p5_enable,
> +	.disable =3D sr_class1p5_disable,
> +	.configure =3D sr_class1p5_configure,
> +	.class_type =3D SR_CLASS1P5,
> +	.start =3D sr_class1p5_start,
> +	.stop =3D sr_class1p5_stop,
> +	.notify =3D sr_class1p5_notify,
> +	/*
> +	 * trigger for bound - this tells VP that SR has a voltage
> +	 * change. we should ensure transdone is set before reading
> +	 * vp voltage.
> +	 */
> +	.notify_flags =3D SR_NOTIFY_MCUBOUND,
> +	.class_priv_data =3D (void *)&class_1p5_data,
> +};
> +
> +/**
> + * sr_class1p5_init() - register class 1p5 as default
> + *
> + * board files call this function to use class 1p5, we register with=
 the
> + * smartreflex subsystem
> + */
> +static int __init sr_class1p5_init(void)
> +{
> +	int r;
> +
> +	/* Enable this class only for OMAP3630 and OMAP4 */
> +	if (!(cpu_is_omap3630() || cpu_is_omap44xx()))
> +		return -EINVAL;
> +
> +	r =3D sr_register_class(&class1p5_data);
> +	if (r) {
> +		pr_err("SmartReflex class 1.5 driver: "
> +		       "failed to register with %d\n", r);
> +	} else {
> +#if CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY
> +		INIT_DELAYED_WORK_DEFERRABLE(&recal_work, do_recalibrate);
> +		schedule_delayed_work(&recal_work, msecs_to_jiffies(
> +				CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY));
> +#endif
> +		pr_info("SmartReflex class 1.5 driver: initialized (%dms)\n",
> +			CONFIG_OMAP_SR_CLASS1P5_RECALIBRATION_DELAY);
> +	}
> +	return r;
> +}
> +late_initcall(sr_class1p5_init);
> diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach=
-omap2/smartreflex-class3.c
> index 1d3eb11..0136afb 100644
> --- a/arch/arm/mach-omap2/smartreflex-class3.c
> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
> @@ -21,7 +21,9 @@ static int sr_class3_enable(struct voltagedomain *v=
oltdm,
>  	return sr_enable(voltdm, volt_data);
>  }
> =20
> -static int sr_class3_disable(struct voltagedomain *voltdm, int is_vo=
lt_reset)
> +static int sr_class3_disable(struct voltagedomain *voltdm,
> +				struct omap_volt_data *vdata,
> +				int is_volt_reset)

I think this change belonged in the previous patch.

>  {
>  	omap_vp_disable(voltdm);
>  	sr_disable(voltdm);
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/=
smartreflex.c
> index 5c549b9..5738298 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -324,7 +324,9 @@ static void sr_stop_vddautocomp(struct omap_sr *s=
r, bool class_stop,
>  		return;
>  	}
> =20
> -	sr_class->disable(sr->voltdm, is_volt_reset);
> +	sr_class->disable(sr->voltdm,
> +			omap_voltage_get_nom_volt(sr->voltdm),
> +			is_volt_reset);

this one too.

>  	if (class_stop) {
>  		if (sr_class->stop &&
>  		    sr_class->stop(sr->voltdm, sr_class->class_priv_data))
> @@ -478,6 +480,28 @@ static u32 sr_retrieve_nvalue(struct omap_sr *sr=
, u32 efuse_offs)
>  /* Public Functions */
> =20
>  /**
> + * is_sr_enabled() - is Smart reflex enabled for this domain?
> + * @voltdm: voltage domain to check
> + *
> + * Returns 0 if SR is enabled for this domain, else returns err
> + */
> +bool is_sr_enabled(struct voltagedomain *voltdm)

Please follow naming conventions of the rest of the SR layer.

> +{
> +	struct omap_sr *sr;

insert blank line

> +	if (IS_ERR_OR_NULL(voltdm)) {
> +		pr_warning("%s: invalid param voltdm\n", __func__);
> +		return false;
> +	}
> +	sr =3D _sr_lookup(voltdm);
> +	if (IS_ERR(sr)) {
> +		pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +			__func__, voltdm->name);
> +		return false;
> +	}
> +	return sr->autocomp_active;
> +}
> +
> +/**
>   * sr_configure_errgen() - Configures the smrtreflex to perform AVS =
using the
>   *			 error generator module.
>   * @voltdm:	VDD pointer to which the SR module to be configured belo=
ngs to.
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/=
smartreflex.h
> index 812e86d..d1ed829 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -168,6 +168,7 @@ struct omap_sr_pmic_data {
>  #define SR_CLASS1	0x1
>  #define SR_CLASS2	0x2
>  #define SR_CLASS3	0x3
> +#define SR_CLASS1P5	0x4
> =20
>  /**
>   * struct omap_sr_class_data - Smartreflex class driver info
> @@ -188,7 +189,9 @@ struct omap_sr_pmic_data {
>  struct omap_sr_class_data {
>  	int (*enable)(struct voltagedomain *voltdm,
>  			struct omap_volt_data *volt_data);
> -	int (*disable)(struct voltagedomain *voltdm, int is_volt_reset);
> +	int (*disable)(struct voltagedomain *voltdm,
> +			struct omap_volt_data *volt_data,
> +			int is_volt_reset);

This change should've been part of previous patch.

>  	int (*start)(struct voltagedomain *voltdm, void *class_priv_data);
>  	int (*stop)(struct voltagedomain *voltdm, void *class_priv_data);
>  	int (*configure)(struct voltagedomain *voltdm);
> @@ -250,6 +253,7 @@ int sr_configure_minmax(struct voltagedomain *vol=
tdm);
> =20
>  /* API to register the smartreflex class driver with the smartreflex=
 driver */
>  int sr_register_class(struct omap_sr_class_data *class_data);
> +bool is_sr_enabled(struct voltagedomain *voltdm);
>  #else
>  static inline void omap_sr_enable(struct voltagedomain *voltdm) {}
>  static inline void omap_sr_disable(struct voltagedomain *voltdm) {}
> @@ -264,5 +268,9 @@ static inline void omap_sr_disable_reset_volt(
>  		struct voltagedomain *voltdm) {}
>  static inline void omap_sr_register_pmic(
>  		struct omap_sr_pmic_data *pmic_data) {}
> +static inline bool is_sr_enabled(struct voltagedomain *voltdm)
> +{
> +	return false;
> +}
>  #endif
>  #endif
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index 2d70d13..80db727 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -182,9 +182,55 @@ static int nom_volt_debug_get(void *data, u64 *v=
al)
>  	return 0;
>  }
> =20
> +static int dyn_volt_debug_get(void *data, u64 *val)
> +{
> +	struct omap_vdd_info *vdd =3D (struct omap_vdd_info *) data;
> +	struct omap_volt_data *volt_data;
> +
> +	if (!vdd) {
> +		pr_warning("Wrong paramater passed\n");
> +		return -EINVAL;
> +	}
> +
> +	volt_data =3D omap_voltage_get_nom_volt(&vdd->voltdm);
> +	if (IS_ERR_OR_NULL(volt_data)) {
> +		pr_warning("%s: No voltage/domain?\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	*val =3D volt_data->volt_dynamic_nominal;
> +
> +	return 0;
> +}
> +
> +static int calib_volt_debug_get(void *data, u64 *val)
> +{
> +	struct omap_vdd_info *vdd =3D (struct omap_vdd_info *) data;
> +	struct omap_volt_data *volt_data;
> +
> +	if (!vdd) {
> +		pr_warning("Wrong paramater passed\n");

to be a useful debug message, should at least have a __func__ involved
to know where it came from.

> +		return -EINVAL;
> +	}
> +
> +	volt_data =3D omap_voltage_get_nom_volt(&vdd->voltdm);
> +	if (IS_ERR_OR_NULL(volt_data)) {
> +		pr_warning("%s: No voltage/domain?\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	*val =3D volt_data->volt_calibrated;
> +
> +	return 0;
> +}
> +
>  DEFINE_SIMPLE_ATTRIBUTE(vp_volt_debug_fops, vp_volt_debug_get, NULL,=
 "%llu\n");
>  DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops, nom_volt_debug_get, NUL=
L,
>  								"%llu\n");
> +DEFINE_SIMPLE_ATTRIBUTE(dyn_volt_debug_fops, dyn_volt_debug_get, NUL=
L,
> +								"%llu\n");
> +DEFINE_SIMPLE_ATTRIBUTE(calib_volt_debug_fops, calib_volt_debug_get,=
 NULL,
> +								"%llu\n");
>  static void vp_latch_vsel(struct omap_vdd_info *vdd)
>  {
>  	u32 vpconfig;
> @@ -306,6 +352,12 @@ static void __init vdd_debugfs_init(struct omap_=
vdd_info *vdd)
>  	(void) debugfs_create_file("curr_nominal_volt", S_IRUGO,
>  				vdd->debug_dir, (void *) vdd,
>  				&nom_volt_debug_fops);
> +	(void) debugfs_create_file("curr_dyn_nominal_volt", S_IRUGO,
> +				vdd->debug_dir, (void *) vdd,
> +				&dyn_volt_debug_fops);
> +	(void) debugfs_create_file("curr_calibrated_volt", S_IRUGO,
> +				vdd->debug_dir, (void *) vdd,
> +				&calib_volt_debug_fops);
>  }
> =20
>  /* Voltage scale and accessory APIs */
> @@ -697,6 +749,33 @@ struct omap_volt_data *omap_voltage_get_nom_volt=
(struct voltagedomain *voltdm)
>  }
> =20
>  /**
> + * omap_voltage_calib_reset() - reset the calibrated voltage entries
> + * @voltdm: voltage domain to reset the entries for
> + *
> + * when the calibrated entries are no longer valid, this api allows
> + * the calibrated voltages to be reset.
> + */
> +int omap_voltage_calib_reset(struct voltagedomain *voltdm)
> +{
> +	struct omap_vdd_info *vdd;
> +	struct omap_volt_data *volt_data;
> +
> +	if (IS_ERR_OR_NULL(voltdm)) {
> +		pr_warning("%s: VDD specified does not exist!\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	vdd =3D container_of(voltdm, struct omap_vdd_info, voltdm);
> +	volt_data =3D vdd->volt_data;
> +	/* reset the calibrated voltages as 0 */
> +	while (volt_data->volt_nominal) {
> +		volt_data->volt_calibrated =3D 0;
> +		volt_data++;
> +	}
> +	return 0;
> +}
> +
> +/**
>   * omap_vp_get_curr_volt() - API to get the current vp voltage.
>   * @voltdm:	pointer to the VDD.
>   *
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/volt=
age.h
> index 5b4e363..5e84881 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -57,6 +57,8 @@ struct voltagedomain {
>  	char *name;
>  };
> =20
> +#define OMAP3PLUS_DYNAMIC_NOMINAL_MARGIN_UV	50000
> +

A comment describing this value (and where it came from) would be most
useful.

>  /**
>   * struct omap_volt_data - Omap voltage specific data.
>   * @voltage_nominal:	The possible voltage value in uV
> @@ -71,6 +73,8 @@ struct voltagedomain {
>   */
>  struct omap_volt_data {
>  	u32	volt_nominal;
> +	u32	volt_calibrated;
> +	u32	volt_dynamic_nominal;
>  	u32	sr_efuse_offs;
>  	u8	sr_errminlimit;
>  	u8	vp_errgain;
> @@ -156,6 +160,7 @@ struct dentry *omap_voltage_get_dbgdir(struct vol=
tagedomain *voltdm);
>  int __init omap_voltage_early_init(s16 prm_mod, s16 prm_irqst_mod,
>  				   struct omap_vdd_info *omap_vdd_array[],
>  				   u8 omap_vdd_count);
> +int omap_voltage_calib_reset(struct voltagedomain *voltdm);
>  #ifdef CONFIG_PM
>  int omap_voltage_register_pmic(struct voltagedomain *voltdm,
>  		struct omap_volt_pmic_info *pmic_info);
> @@ -189,7 +194,23 @@ static inline unsigned long omap_get_operation_v=
oltage(
>  {
>  	if (IS_ERR_OR_NULL(vdata))
>  		return 0;
> -	return vdata->volt_nominal;
> +	return (vdata->volt_calibrated) ? vdata->volt_calibrated :
> +		(vdata->volt_dynamic_nominal) ? vdata->volt_dynamic_nominal :
> +			vdata->volt_nominal;
>  }
> =20
> +/* what is my dynamic nominal? */

comment doesn't add anything to code

> +static inline unsigned long omap_get_dyn_nominal(struct omap_volt_da=
ta *vdata)
> +{
> +	if (IS_ERR_OR_NULL(vdata))
> +		return 0;
> +	if (vdata->volt_calibrated) {
> +		unsigned long v =3D vdata->volt_calibrated +
> +			OMAP3PLUS_DYNAMIC_NOMINAL_MARGIN_UV;
> +		if (v > vdata->volt_nominal)
> +			return vdata->volt_nominal;
> +		return v;
> +	}
> +	return vdata->volt_nominal;
> +}
>  #endif
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index b6333ae..dba7939 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -67,6 +67,23 @@ config OMAP_SMARTREFLEX_CLASS3
>  	  Class 3 implementation of Smartreflex employs continuous hardware
>  	  voltage calibration.
> =20
> +config OMAP_SMARTREFLEX_CLASS1P5
> +	bool "Class 1.5 mode of Smartreflex Implementation"
> +	depends on OMAP_SMARTREFLEX && TWL4030_CORE
> +	help
> +	  Say Y to enable Class 1.5 implementation of Smartreflex
> +	  Class 1.5 implementation of Smartreflex employs software controll=
ed
> +	  hardware voltage calibration.
> +
> +config OMAP_SR_CLASS1P5_RECALIBRATION_DELAY
> +	int "Class 1.5 mode recalibration recalibration delay(ms)"
> +	depends on OMAP_SMARTREFLEX_CLASS1P5
> +	default 86400000
> +	help
> +	  Setup the recalibration delay in milliseconds. Use 0 for never do=
ing
> +	  a recalibration. Defaults to recommended recalibration every 24hr=
s.
> +	  If you do not understand this, use the default.
> +
>  config OMAP_RESET_CLOCKS
>  	bool "Reset unused clocks during boot"
>  	depends on ARCH_OMAP

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
