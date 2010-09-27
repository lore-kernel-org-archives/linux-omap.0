From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] mfd: speedup twl4030 irq response time and decrease irq
 disable time
Date: Mon, 27 Sep 2010 22:31:56 +0800
Message-ID: <AANLkTikrhE=3FYtv9d+jzy5sohwpvhWsZPhm9+PCPZVn@mail.gmail.com>
References: <1285120171-3030-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1285120171-3030-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

2010/9/22  <tom.leiming@gmail.com>:
> From: Ming Lei <tom.leiming@gmail.com>
>
> This patch sets scheduler policy of twl4030 irq thread
> (twl4030_irq_thread) as SCHED_FIFO to speedup irq response
> time, just like taken by kernel threaded irq in irq_thread
> (kernel/irq/manage.c). Also higher priority than that of
> threaded irq is taken to avoid preemption from twl4030
> subchips's threaded irq handler, so pih irq disable time may
> be decreased.
>
> The pih irq is disabled in handle_twl4030_pih which may
> wakeup twl4030 irq thread, and the pih irq will be enabled
> again until complete of all sih irqs' handling in twl4030
> irq thread.
>
> Also for each one interrupt line of twl4030 subchip, only
> two irq events can be buffered by twl4030(4.4.2.3 of TPS65950 TRM).

Ping...

> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Balaji T K <balajitk@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: linux-kernel@vger.kernel.org
> ---
> =A0drivers/mfd/twl4030-irq.c | =A0 10 +++++++++-
> =A01 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index 097f24d..d1e0d80 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -286,8 +286,16 @@ static int twl4030_irq_thread(void *data)
> =A0 =A0 =A0 =A0long irq =3D (long)data;
> =A0 =A0 =A0 =A0static unsigned i2c_errors;
> =A0 =A0 =A0 =A0static const unsigned max_i2c_errors =3D 100;
> -
> -
> + =A0 =A0 =A0 struct sched_param param =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sched_priority =3D MAX_USER_RT_PRIO/2 =
+ 10,
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 /* Take higher priority than threaded irq to make us im=
mune of
> + =A0 =A0 =A0 =A0* preemption from twl4030 subchips's threaded irq ha=
ndler, then
> + =A0 =A0 =A0 =A0* we can complete all SIH irqs' handling and enable =
PIH irq
> + =A0 =A0 =A0 =A0* again asap.
> + =A0 =A0 =A0 =A0* */
> + =A0 =A0 =A0 sched_setscheduler(current, SCHED_FIFO, &param);
> =A0 =A0 =A0 =A0current->flags |=3D PF_NOFREEZE;
>
> =A0 =A0 =A0 =A0while (!kthread_should_stop()) {
> --
> 1.6.2.5
>
>


thanks,

--=20
Lei Ming
