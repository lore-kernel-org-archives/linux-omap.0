From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP3: CPUIDLE & PM: check_bm fix.
Date: Thu, 10 Jul 2008 09:12:05 +0300
Message-ID: <87iqves1xm.fsf@trdhcp146196.ntc.nokia.com>
References: <1215519440-10234-1-git-send-email-jouni.hogander@nokia.com>
	<1215584973-14982-1-git-send-email-jouni.hogander@nokia.com>
	<000b01c8e18f$31708610$68bf18ac@ent.ti.com>
	<87tzezwnl1.fsf@trdhcp146196.ntc.nokia.com>
	<000c01c8e193$9f1f4d50$68bf18ac@ent.ti.com>
	<87tzeztpz3.fsf@trdhcp146196.ntc.nokia.com>
	<001901c8e19f$32f66f80$68bf18ac@ent.ti.com>
	<13B9B4C6EF24D648824FF11BE8967162035BD675D5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20492 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYGJGMY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jul 2008 02:12:24 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BD675D5@dlee02.ent.ti.com>
	(ext Woodruff's message of "Wed, 9 Jul 2008 08:05:48 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

"ext Woodruff, Richard" <r-woodruff2@ti.com> writes:

> Hi,
>
>> > I think we have now all the pieces here to get stable cpuidle +
>> > pm_idle + suspend + off mode with minimal configuration on SDP
>> > board. Could you Rajendra now gather these together and prepare ne=
w
>> > patch set in sensible format?
>>
>> Yes, I will do that. Will re-send the complete patch set with all th=
e
>> fixes in place.
>
> I'll add a couple notes based on recent changes in internal code.
>
> Code has moved to using the safe_idle method like reference Intel dri=
ver code uses.
>         - This removes for loop backing up to 1st non-BM state and ma=
kes idle path faster.
>         - The biggest power-performance gain comes by making sure a
> INACTIVE state is hit.  If there is BM activity chances are MPU will
> be needed anyway and going to OFF probably isn't a win.  Getting 98%
> savings is ok.

Impact of this change depends a lot on what is happening on the
system. HW triggered dma transfer comes to my mind first. In that case
mpu could be kept in OFF state while core is active. Changing bm
check this way would cause mpu to be kept in INACTIVE state. Any
analysis of the impact?

>
> Slowness on serial is there anytime you hit INACTIVE if you don't
> have the UART-NO-IDLE-ON-TX workaround in tree.  This is not in
> Tony's tree yet and probably should be if the UART is bothering you.
> Choosing a non-WFI state penalty like your patch did is too
> expensive from a power standpoint for the effect.

Well I think there is very similiar workaround in workaround patch set
(see omap_serial_can_sleep). Now non-WFI state is selected if there
was activity in last 5 seconds. So get just hands off from the
keyboard for 5 seconds and C state selection continues normally after
that. I think 5 seconds without powersave from last character entered
to serial-console is not too expensive. Benefit of working
serial-console is bigger I think.

>
> Below patches for comment.
>
> Regards,
> Richard W.
>
> --- arch/arm/mach-omap2/pm_idle_34xx.c@@/LINUX-GIT-2.6K_INT_FLOAT_4.0=
   2008-07-02 11:39:50.000000000 -0500
> +++ arch/arm/mach-omap2/pm_idle_34xx.c  2008-07-04 11:54:15.000000000=
 -0500
> @@ -706,32 +706,15 @@ return_sleep_time:
>  static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>                                 struct cpuidle_state *state)
>  {
> -       struct cpuidle_state *new_state =3D NULL;
> -       int i, j;
> -
>         if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_c=
heck()) {
> -
> -               /* Find current state in list */
> -               for (i =3D 0; i < OMAP3_MAX_STATES; i++)
> -                       if (state =3D=3D &dev->states[i])
> -                               break;
> -               BUG_ON(i =3D=3D OMAP3_MAX_STATES);
> -
> -               /* Back up to non 'CHECK_BM' state */
> -               for (j =3D i - 1;  j > 0; j--) {
> -                       struct cpuidle_state *s =3D &dev->states[j];
> -
> -                       if (!(s->flags & CPUIDLE_FLAG_CHECK_BM)) {
> -                               new_state =3D s;
> -                               break;
> -                       }
> +               if (dev->safe_state)
> +                       return dev->safe_state->enter(dev, dev->safe_=
state);
> +               else {
> +                       omap_sram_idle();
> +                       return 0;
>                 }

How about adding that old loop into this else statement? Calling
omap_sram_idle strictly here has an effect that last selected state is
used (next states are not written). Also switching between safe_state
mechanism and loop would be very easy.

> -
> -               pr_debug("%s: Bus activity: Entering %s (instead of %=
s)\n",
> -                       __FUNCTION__, new_state->name, state->name);
>         }
> -
> -       return omap3_enter_idle(dev, new_state ? : state);

And then if previous comment having old loop in else statement is done
then this should be left in it's old format.
=20
> +       return omap3_enter_idle(dev, state);
>  }
>
>  DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> @@ -766,8 +749,8 @@ void omap_init_power_states(void)
>         omap3_power_states[OMAP3_STATE_C2].core_state =3D PRCM_CORE_A=
CTIVE;
>         omap3_power_states[OMAP3_STATE_C2].flags =3D CPUIDLE_FLAG_TIM=
E_VALID |
>                         CPUIDLE_FLAG_BALANCED;
> -       omap3_power_states[OMAP3_STATE_C3].valid =3D 1;
>
> +       omap3_power_states[OMAP3_STATE_C3].valid =3D 1;
>         omap3_power_states[OMAP3_STATE_C3].type =3D OMAP3_STATE_C3;
>         omap3_power_states[OMAP3_STATE_C3].sleep_latency =3D 1500;
>         omap3_power_states[OMAP3_STATE_C3].wakeup_latency =3D 1800;
> @@ -849,6 +832,8 @@ int omap3_idle_init(void)
>                 state->flags =3D cx->flags;
>                 state->enter =3D (state->flags & CPUIDLE_FLAG_CHECK_B=
M) ?
>                         omap3_enter_idle_bm : omap3_enter_idle;
> +               if (cx->type =3D=3D OMAP3_STATE_C1)
> +                       dev->safe_state =3D state;
>                 sprintf(state->name, "C%d", count+1);
>                 count++;
>         }
>
>
> diff -purN img/2.6_kernel/drivers/serial/8250.c 2.6_kernel/drivers/se=
rial/8250.c
> --- img/2.6_kernel/drivers/serial/8250.c        2008-05-09 18:50:53.0=
00000000 -0500
> +++ 2.6_kernel/drivers/serial/8250.c    2008-06-03 19:44:24.000000000=
 -0500
> @@ -1221,6 +1221,14 @@ static inline void __stop_tx(struct uart
>                 p->ier &=3D ~UART_IER_THRI;
>                 serial_out(p, UART_IER, p->ier);
>         }
> +#ifdef CONFIG_OMAP3_PM
> +       {
> +               /* Advertise partial idle to save power. RX side can =
do async wake */
> +               unsigned int tmp;
> +               tmp =3D (serial_in(p, UART_OMAP_SYSC) & 0x7) | (2 << =
3);
> +               serial_out(p, UART_OMAP_SYSC, tmp); /* smart-idle */
> +       }
> +#endif
>  }
>
>  static void serial8250_stop_tx(struct uart_port *port)
> @@ -1268,6 +1276,15 @@ static void serial8250_start_tx(struct u
>                 up->acr &=3D ~UART_ACR_TXDIS;
>                 serial_icr_write(up, UART_ACR, up->acr);
>         }
> +#ifdef CONFIG_OMAP3_PM
> +       {
> +               /* Don't advertise partial idle else TX irqs will not=
 be seen */
> +               /* Alternative is to set kernel timer at fifo drain r=
ate */
> +               unsigned int tmp;
> +               tmp =3D (serial_in(up, UART_OMAP_SYSC) & 0x7) | (1 <<=
 3);
> +               serial_out(up, UART_OMAP_SYSC, tmp); /* no-idle */
> +       }
> +#endif

I tried this quickly. This doesn't work alone. At least if we want
working serial-console. Problem with this is that when entering char
to console to wake-up omap. First character is lost and then no "echo"
happens and serial8250_start_tx is not called. I think this will need
some timeout anyway which is started when uart rx|iopad wakeup
happens.

>  }
>
>
>

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
