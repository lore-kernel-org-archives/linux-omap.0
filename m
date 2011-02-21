From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 14/17] omap4: cpuidle: Add MPUSS RET OFF states
Date: Mon, 21 Feb 2011 15:56:57 +0530
Message-ID: <6176616fe77333f80f0cfaae4fc8aff3@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-15-git-send-email-santosh.shilimkar@ti.com>
 <AANLkTik-hj+-ZPnfVKLCH0h-QeyziH4H-j6EE+_QHHCU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:41635 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755343Ab1BUK1B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 05:27:01 -0500
Received: by qyk29 with SMTP id 29so1011549qyk.10
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 02:27:00 -0800 (PST)
In-Reply-To: <AANLkTik-hj+-ZPnfVKLCH0h-QeyziH4H-j6EE+_QHHCU@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Monday, February 21, 2011 3:49 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; linux-arm-
> kernel@lists.infradead.org; Rajendra Nayak
> Subject: Re: [PATCH 14/17] omap4: cpuidle: Add MPUSS RET OFF states
>
> Hi Santosh,
>
[...]

>
> > + * cpuidle CORE retention support.
> > + * Currently only MPUSS latency numbers are added based on
> > + * measurements done internally. The numbers for MPUSS are
> > + * not board dependent and hence set directly here instead of
> > + * passing it from board files.
> > + */
> > =A0static struct cpuidle_params cpuidle_params_table[] =3D {
> > - =A0 =A0 =A0 /* C1 */
> > - =A0 =A0 =A0 {1, 2, 2, 5},
> > + =A0 =A0 =A0 /* C1 - CPU0 WFI + CPU1 ON/OFF + MPU ON =A0 + CORE ON=
 */
> > + =A0 =A0 =A0 {1, =A0 =A0 2, =A0 =A0 =A02, =A0 =A0 =A05},
> > + =A0 =A0 =A0 /* C2 - CPU0 ON + CPU1 OFF + MPU ON =A0+ CORE ON */
> > + =A0 =A0 =A0 {1, =A0 =A0 140, =A0 =A0160, =A0 =A0300},
> > + =A0 =A0 =A0 /* C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON */
> > + =A0 =A0 =A0 {1, =A0 =A0 200, =A0 =A0300, =A0 =A0700},
> > + =A0 =A0 =A0 /* C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON */
> > + =A0 =A0 =A0 {1, =A0 =A0 1400, =A0 600, =A0 =A05000},
> > =A0};
> >
> > +DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
> > +
> > +static int omap4_idle_bm_check(void)
> > +{
> > + =A0 =A0 =A0 /* FIXME: Populate this with CORE retention support *=
/
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > =A0/**
> > =A0* omap4_enter_idle - Programs OMAP4 to enter the specified state
> > =A0* @dev: cpuidle device
> > @@ -57,7 +92,9 @@ static struct cpuidle_params
> cpuidle_params_table[] =3D {
> > =A0static int omap4_enter_idle(struct cpuidle_device *dev,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpuidle_state=
 *state)
> > =A0{
> > + =A0 =A0 =A0 struct omap4_processor_cx *cx =3D
> cpuidle_get_statedata(state);
> > =A0 =A0 =A0 =A0struct timespec ts_preidle, ts_postidle, ts_idle;
> > + =A0 =A0 =A0 u32 cpu1_state;
> >
> > =A0 =A0 =A0 =A0/* Used to keep track of the total time in idle */
> > =A0 =A0 =A0 =A0getnstimeofday(&ts_preidle);
> > @@ -65,28 +102,74 @@ static int omap4_enter_idle(struct
> cpuidle_device *dev,
> > =A0 =A0 =A0 =A0local_irq_disable();
> > =A0 =A0 =A0 =A0local_fiq_disable();
> >
> > - =A0 =A0 =A0 cpu_do_idle();
>
> I think the piece of code below is rather difficult to read and
> understand. Based on the patch description and the comment here
> below
> I do not see the relation with the code.
>
There is relation. The comments are as per the conditions. And
The hardware constraint is back-ground behind the conditions.

> " On OMAP4 because of hardware constraints, no low power states are
>  targeted when both CPUs are online and in SMP mode. The low power
>  states are attempted only when secondary CPU gets offline to OFF
>  through hotplug infrastructure. "
> The test below does not seem to match this comment.
>
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Special hardware/software considerations:
> > + =A0 =A0 =A0 =A0* 1. Do only WFI for secondary CPU(non-boot - CPU1=
).
> > + =A0 =A0 =A0 =A0* =A0 =A0Secondary cores are taken down only via h=
otplug
> path.
> The comment looks contradictory. Which one is taken OFF using this
> code, which one from hotplug?
> Does this correspond to the condition '(dev->cpu)' in the test
> below?

Yes.
>
> > + =A0 =A0 =A0 =A0* 2. Do only a WFI as long as in SMP mode.
> Does this correspond to the condition '(num_online_cpus() > 1)' in
> the
> test below? If so it this one triggering the low power mode for
> cpu0?
yes
>
> > + =A0 =A0 =A0 =A0* 3. Continue to do only WFI till CPU1 hits OFF st=
ate.
> > + =A0 =A0 =A0 =A0* =A0 =A0This is necessary to honour hardware reco=
mmondation
> > + =A0 =A0 =A0 =A0* =A0 =A0of triggeing all the possible low power m=
odes once
> CPU1 is
> > + =A0 =A0 =A0 =A0* =A0 =A0out of coherency and in OFF mode.
> Does this correspond to the condition '(cpu1_state !=3D
> PWRDM_POWER_OFF)' in the test below?
>
Yes

> > + =A0 =A0 =A0 =A0* Update dev->last_state so that governor stats re=
flects
> right
> > + =A0 =A0 =A0 =A0* data.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 cpu1_state =3D pwrdm_read_pwrst(cpu1_pd);
> > + =A0 =A0 =A0 if ((dev->cpu) || (num_online_cpus() > 1) ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cpu1_state !=3D PWRD=
M_POWER_OFF)) {
> Are '||' correct here?
Yes.

> Sorry if the code behaves correctly, the remarks are about
> readability especially in the comments.
>
You got all three correct. Instead of having three If's doing
same thing I have merged them and added comments above.

And you got all of them correctly.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
