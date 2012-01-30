From: =?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?= <vjaquez@igalia.com>
Subject: Re: [PATCH 3/5] staging: tidspbridge: Lindent to drv_interface.c
Date: Mon, 30 Jan 2012 18:59:40 +0100
Message-ID: <20120130175940.GG27022@lit.local.igalia.com>
References: <cover.1327348286.git.vjaquez@igalia.com>
 <7103a353d393f9b8366b141a608a4370e4392c7b.1327348286.git.vjaquez@igalia.com>
 <CAB-zwWjKfakESHw4Cw8JvJ6WpELz51E_9zVtjR0bF84yhMRfMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAB-zwWjKfakESHw4Cw8JvJ6WpELz51E_9zVtjR0bF84yhMRfMQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Armando Uribe <x0095078@ti.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>, Ivan Gomez Castellanos <ivan.gomez@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 30, 2012 at 11:25:34AM -0600, Ramirez Luna, Omar wrote:
> 2012/1/23 V=EDctor Manuel J=E1quez Leal <vjaquez@igalia.com>:
> > No functional changes.
> >
> > According to Lindent, the file drv_internface.c had some lines with=
 bad
> > indentation.
> >
> > This commit is the output of Lindent.
>=20
> Usually lindent tends to do whatever it wants, unless carefully
> configured...

Thanks Omar!

I'll post a v2 of this patch set, with a couple things more and with mo=
re
attention on what lindent does in this one, if that's ok.

vmjl

>=20
> ...
> > @@ -342,9 +342,10 @@ static void bridge_recover(struct work_struct =
*work)
> > =A0 =A0 =A0 =A0if (atomic_read(&bridge_cref)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0INIT_COMPLETION(bridge_comp);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (!wait_for_completion_timeout(=
&bridge_comp,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies(REC_TIMEOUT)))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s:%d handle=
(s) still opened\n",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 __func__, atomic_read(&bridge_cref));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (REC_TIMEOUT)))
>=20
> Like here, it just split msecs_to_jiffies(REC_TIMEOUT) into 2 lines
> making it a little harder to read.
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s:%d handle=
(s) still opened\n", __func__,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomi=
c_read(&bridge_cref));
>=20
> I remember the rule was to break lines as far to the right as
> possible, no? Chapter 2 CodingStyle, same for the other similar
> changes.
>=20
> ...
> > @@ -547,10 +548,9 @@ static int __devexit omap34_xx_bridge_remove(s=
truct platform_device *pdev)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Failed to retrieve the o=
bject handle\n", __func__);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto func_cont;
> > =A0 =A0 =A0 =A0}
> > -
>=20
> Blank line removed?
>=20
> > =A0#ifdef CONFIG_TIDSPBRIDGE_DVFS
> > =A0 =A0 =A0 =A0if (cpufreq_unregister_notifier(&iva_clk_notifier,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 CPUFREQ_TRANSITION_NOTIFIER))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 CPUFREQ_TRANSITION_NOTIFIER))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: cpufreq_unregister_notif=
ier failed for iva2_ck\n",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> > =A0#endif /* #ifdef CONFIG_TIDSPBRIDGE_DVFS */
> > --
> > 1.7.8.3
> >
>=20
> Regards,
>=20
> Omar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
