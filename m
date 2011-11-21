From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] ARM: OMAP: dmtimer: fix missing content/correction in
 low-power mode support
Date: Mon, 21 Nov 2011 10:42:52 -0600
Message-ID: <CAB-zwWiNc=aFMd2ccyL=s1c5qa8dnu6c-M29K1CrezJ01YXZWg@mail.gmail.com>
References: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Nov 8, 2011 at 12:00 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> Since omap_dm_timer_write_reg/__omap_dm_timer_write is now modified
> to use timer->func_base OCP_CFG should not use this wrapper anymore.
> Instead use __raw_writel() directly and use timer->io_base instead
> to write to OCP_CFG.
>
> The timer->sys_stat is valid only if timer->revision is 1. In the
> context restore function make this correction.
>
> Save the contexts and loss count when timer is stopped.
> Also, disable the clock. Else, clock usecount would become imbalanced.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
...
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index af3b92b..f042c82 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
...
> @@ -357,6 +357,21 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
>
> =A0 =A0 =A0 =A0__omap_dm_timer_stop(timer, timer->posted, rate);
>
> + =A0 =A0 =A0 if (timer->loses_context) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timer->get_context_loss_count)

Maybe: if (timer->loses_context && timer->get_context_loss_count)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->ctx_loss_count =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->get_context_loss_cou=
nt(&timer->pdev->dev);

could get rid  of this weird one-line formatting

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Since the register values are computed and written wit=
hin
> + =A0 =A0 =A0 =A0* __omap_dm_timer_stop, we need to use read to retrieve =
the
> + =A0 =A0 =A0 =A0* context.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 timer->context.tclr =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_read_reg(time=
r, OMAP_TIMER_CTRL_REG);
> + =A0 =A0 =A0 timer->context.tisr =3D __raw_readl(timer->irq_stat);
> + =A0 =A0 =A0 omap_dm_timer_disable(timer);

FWIW, functionally it looks good to me, besides it fixes the broken
dmtimer start/stop sequence from 3.2-rc1. Tested with tidspbridge on
omap3.

If needed:

Tested-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Regards,

Omar
