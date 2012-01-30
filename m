From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 3/5] staging: tidspbridge: Lindent to drv_interface.c
Date: Mon, 30 Jan 2012 11:25:34 -0600
Message-ID: <CAB-zwWjKfakESHw4Cw8JvJ6WpELz51E_9zVtjR0bF84yhMRfMQ@mail.gmail.com>
References: <cover.1327348286.git.vjaquez@igalia.com>
	<7103a353d393f9b8366b141a608a4370e4392c7b.1327348286.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7103a353d393f9b8366b141a608a4370e4392c7b.1327348286.git.vjaquez@igalia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?V=EDctor_Manuel_J=E1quez_Leal?= <vjaquez@igalia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>
List-Id: linux-omap@vger.kernel.org

2012/1/23 V=EDctor Manuel J=E1quez Leal <vjaquez@igalia.com>:
> No functional changes.
>
> According to Lindent, the file drv_internface.c had some lines with b=
ad
> indentation.
>
> This commit is the output of Lindent.

Usually lindent tends to do whatever it wants, unless carefully configu=
red...

=2E..
> @@ -342,9 +342,10 @@ static void bridge_recover(struct work_struct *w=
ork)
> =A0 =A0 =A0 =A0if (atomic_read(&bridge_cref)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0INIT_COMPLETION(bridge_comp);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (!wait_for_completion_timeout(&b=
ridge_comp,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies(REC_TIMEOUT)))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s:%d handle(s=
) still opened\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 __func__, atomic_read(&bridge_cref));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (REC_TIMEOUT)))

Like here, it just split msecs_to_jiffies(REC_TIMEOUT) into 2 lines
making it a little harder to read.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s:%d handle(s=
) still opened\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_=
read(&bridge_cref));

I remember the rule was to break lines as far to the right as
possible, no? Chapter 2 CodingStyle, same for the other similar
changes.

=2E..
> @@ -547,10 +548,9 @@ static int __devexit omap34_xx_bridge_remove(str=
uct platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Failed to retrieve the obj=
ect handle\n", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto func_cont;
> =A0 =A0 =A0 =A0}
> -

Blank line removed?

> =A0#ifdef CONFIG_TIDSPBRIDGE_DVFS
> =A0 =A0 =A0 =A0if (cpufreq_unregister_notifier(&iva_clk_notifier,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 CPUFREQ_TRANSITION_NOTIFIER))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 CPUFREQ_TRANSITION_NOTIFIER))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: cpufreq_unregister_notifie=
r failed for iva2_ck\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> =A0#endif /* #ifdef CONFIG_TIDSPBRIDGE_DVFS */
> --
> 1.7.8.3
>

Regards,

Omar
