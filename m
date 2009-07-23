From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 1/32] mmc: add 'enable' and 'disable' methods to mmc host
Date: Thu, 23 Jul 2009 22:37:14 +0200
Message-ID: <63386a3d0907231337s28050ad6o119f3f33df5ee642@mail.gmail.com>
References: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
	 <20090710124011.1262.73298.sendpatchset@ahunter-tower>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33333 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbZGWUhQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jul 2009 16:37:16 -0400
In-Reply-To: <20090710124011.1262.73298.sendpatchset@ahunter-tower>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Denis Karpov <ext-denis.2.karpov@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

And please drop my other patch in favor of this one then.

Linus Walleij

2009/7/10 Adrian Hunter <adrian.hunter@nokia.com>:
> From a0164897276e4d1f972fd90b1e9499e1ab8d221e Mon Sep 17 00:00:00 200=
1
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Wed, 22 Apr 2009 12:50:45 +0300
> Subject: [PATCH] mmc: add 'enable' and 'disable' methods to mmc host
>
> MMC hosts that support power saving can use the 'enable' and
> 'disable' methods to exit and enter power saving states.
> An explanation of their use is provided in the comments
> added to include/linux/mmc/host.h.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> =A0drivers/mmc/core/core.c =A0| =A0174 ++++++++++++++++++++++++++++++=
++++++++++++++--
> =A0drivers/mmc/core/host.c =A0| =A0 =A01 +
> =A0drivers/mmc/core/host.h =A0| =A0 =A02 +
> =A0include/linux/mmc/host.h | =A0 47 ++++++++++++
> =A04 files changed, 218 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d84c880..41fd127 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -344,6 +344,98 @@ unsigned int mmc_align_data_size(struct mmc_card=
 *card, unsigned int sz)
> =A0EXPORT_SYMBOL(mmc_align_data_size);
>
> =A0/**
> + * =A0 =A0 mmc_host_enable - enable a host.
> + * =A0 =A0 @host: mmc host to enable
> + *
> + * =A0 =A0 Hosts that support power saving can use the 'enable' and =
'disable'
> + * =A0 =A0 methods to exit and enter power saving states. For more i=
nformation
> + * =A0 =A0 see comments for struct mmc_host_ops.
> + */
> +int mmc_host_enable(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 if (!(host->caps & MMC_CAP_DISABLE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (host->en_dis_recurs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (host->nesting_cnt++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 cancel_delayed_work_sync(&host->disable);
> +
> + =A0 =A0 =A0 if (host->enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (host->ops->enable) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->en_dis_recurs =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->ops->enable(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->en_dis_recurs =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: enable er=
ror %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_=
hostname(host), err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 host->enabled =3D 1;
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(mmc_host_enable);
> +
> +static int mmc_host_do_disable(struct mmc_host *host, int lazy)
> +{
> + =A0 =A0 =A0 if (host->ops->disable) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->en_dis_recurs =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->ops->disable(host, lazy);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->en_dis_recurs =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: disable e=
rror %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_=
hostname(host), err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_schedule_delayed_wo=
rk(&host->disable, err);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 host->enabled =3D 0;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * =A0 =A0 mmc_host_disable - disable a host.
> + * =A0 =A0 @host: mmc host to disable
> + *
> + * =A0 =A0 Hosts that support power saving can use the 'enable' and =
'disable'
> + * =A0 =A0 methods to exit and enter power saving states. For more i=
nformation
> + * =A0 =A0 see comments for struct mmc_host_ops.
> + */
> +int mmc_host_disable(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 if (!(host->caps & MMC_CAP_DISABLE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (host->en_dis_recurs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (--host->nesting_cnt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (!host->enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 err =3D mmc_host_do_disable(host, 0);
> + =A0 =A0 =A0 return err;
> +}
> +EXPORT_SYMBOL(mmc_host_disable);
> +
> +/**
> =A0* =A0 =A0 __mmc_claim_host - exclusively claim a host
> =A0* =A0 =A0 @host: mmc host to claim
> =A0* =A0 =A0 @abort: whether or not the operation should be aborted
> @@ -379,11 +471,81 @@ int __mmc_claim_host(struct mmc_host *host, ato=
mic_t *abort)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wake_up(&host->wq);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
> =A0 =A0 =A0 =A0remove_wait_queue(&host->wq, &wait);
> + =A0 =A0 =A0 if (!stop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_enable(host);
> =A0 =A0 =A0 =A0return stop;
> =A0}
>
> =A0EXPORT_SYMBOL(__mmc_claim_host);
>
> +static int mmc_try_claim_host(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 int claimed_host =3D 0;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
> + =A0 =A0 =A0 if (!host->claimed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->claimed =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 claimed_host =3D 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
> + =A0 =A0 =A0 return claimed_host;
> +}
> +
> +static void mmc_do_release_host(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
> + =A0 =A0 =A0 host->claimed =3D 0;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
> +
> + =A0 =A0 =A0 wake_up(&host->wq);
> +}
> +
> +void mmc_host_deeper_disable(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct mmc_host *host =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struct mmc_host, dis=
able.work);
> +
> + =A0 =A0 =A0 /* If the host is claimed then we do not want to disabl=
e it anymore */
> + =A0 =A0 =A0 if (!mmc_try_claim_host(host))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 mmc_host_do_disable(host, 1);
> + =A0 =A0 =A0 mmc_do_release_host(host);
> +}
> +
> +/**
> + * =A0 =A0 mmc_host_lazy_disable - lazily disable a host.
> + * =A0 =A0 @host: mmc host to disable
> + *
> + * =A0 =A0 Hosts that support power saving can use the 'enable' and =
'disable'
> + * =A0 =A0 methods to exit and enter power saving states. For more i=
nformation
> + * =A0 =A0 see comments for struct mmc_host_ops.
> + */
> +int mmc_host_lazy_disable(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 if (!(host->caps & MMC_CAP_DISABLE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (host->en_dis_recurs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (--host->nesting_cnt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (!host->enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (host->disable_delay) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_schedule_delayed_work(&host->disabl=
e,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_t=
o_jiffies(host->disable_delay));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_host_do_disable(host, 1);
> +}
> +EXPORT_SYMBOL(mmc_host_lazy_disable);
> +
> =A0/**
> =A0* =A0 =A0 mmc_release_host - release a host
> =A0* =A0 =A0 @host: mmc host to release
> @@ -393,15 +555,11 @@ EXPORT_SYMBOL(__mmc_claim_host);
> =A0*/
> =A0void mmc_release_host(struct mmc_host *host)
> =A0{
> - =A0 =A0 =A0 unsigned long flags;
> -
> =A0 =A0 =A0 =A0WARN_ON(!host->claimed);
>
> - =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
> - =A0 =A0 =A0 host->claimed =3D 0;
> - =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
> + =A0 =A0 =A0 mmc_host_lazy_disable(host);
>
> - =A0 =A0 =A0 wake_up(&host->wq);
> + =A0 =A0 =A0 mmc_do_release_host(host);
> =A0}
>
> =A0EXPORT_SYMBOL(mmc_release_host);
> @@ -947,6 +1105,8 @@ void mmc_stop_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
> =A0#endif
>
> + =A0 =A0 =A0 if (host->caps & MMC_CAP_DISABLE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&host->disable);
> =A0 =A0 =A0 =A0cancel_delayed_work(&host->detect);
> =A0 =A0 =A0 =A0mmc_flush_scheduled_work();
>
> @@ -975,6 +1135,8 @@ void mmc_stop_host(struct mmc_host *host)
> =A0*/
> =A0int mmc_suspend_host(struct mmc_host *host, pm_message_t state)
> =A0{
> + =A0 =A0 =A0 if (host->caps & MMC_CAP_DISABLE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&host->disable);
> =A0 =A0 =A0 =A0cancel_delayed_work(&host->detect);
> =A0 =A0 =A0 =A0mmc_flush_scheduled_work();
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 5e945e6..a268d12 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -83,6 +83,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct d=
evice *dev)
> =A0 =A0 =A0 =A0spin_lock_init(&host->lock);
> =A0 =A0 =A0 =A0init_waitqueue_head(&host->wq);
> =A0 =A0 =A0 =A0INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> + =A0 =A0 =A0 INIT_DELAYED_WORK_DEFERRABLE(&host->disable, mmc_host_d=
eeper_disable);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * By default, hosts do not support SGIO or large requ=
ests.
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index c2dc3d2..8c87e11 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -14,5 +14,7 @@
> =A0int mmc_register_host_class(void);
> =A0void mmc_unregister_host_class(void);
>
> +void mmc_host_deeper_disable(struct work_struct *work);
> +
> =A0#endif
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 3e7615e..583c068 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -51,6 +51,35 @@ struct mmc_ios {
> =A0};
>
> =A0struct mmc_host_ops {
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Hosts that support power saving can use the 'enabl=
e' and 'disable'
> + =A0 =A0 =A0 =A0* methods to exit and enter power saving states. 'en=
able' is called
> + =A0 =A0 =A0 =A0* when the host is claimed and 'disable' is called (=
or scheduled with
> + =A0 =A0 =A0 =A0* a delay) when the host is released. The 'disable' =
is scheduled if
> + =A0 =A0 =A0 =A0* the disable delay set by 'mmc_set_disable_delay()'=
 is non-zero,
> + =A0 =A0 =A0 =A0* otherwise 'disable' is called immediately. 'disabl=
e' may be
> + =A0 =A0 =A0 =A0* scheduled repeatedly, to permit ever greater power=
 saving at the
> + =A0 =A0 =A0 =A0* expense of ever greater latency to re-enable. Resc=
heduling is
> + =A0 =A0 =A0 =A0* determined by the return value of the 'disable' me=
thod. A positive
> + =A0 =A0 =A0 =A0* value gives the delay in jiffies.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* In the case where a host function (like set_ios) m=
ay be called
> + =A0 =A0 =A0 =A0* with or without the host claimed, enabling and dis=
abling can be
> + =A0 =A0 =A0 =A0* done directly and will nest correctly. Call 'mmc_h=
ost_enable()' and
> + =A0 =A0 =A0 =A0* 'mmc_host_lazy_disable()' for this purpose, but no=
te that these
> + =A0 =A0 =A0 =A0* functions must be paired.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Alternatively, 'mmc_host_enable()' may be paired w=
ith
> + =A0 =A0 =A0 =A0* 'mmc_host_disable()' which calls 'disable' immedia=
tely. =A0In this
> + =A0 =A0 =A0 =A0* case the 'disable' method will be called with 'laz=
y' set to 0.
> + =A0 =A0 =A0 =A0* This is mainly useful for error paths.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* Because lazy disble may be called from a work queu=
e, the 'disable'
> + =A0 =A0 =A0 =A0* method must claim the host when 'lazy' !=3D 0, whi=
ch will work
> + =A0 =A0 =A0 =A0* correctly because recursion is detected and handle=
d.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 int (*enable)(struct mmc_host *host);
> + =A0 =A0 =A0 int (*disable)(struct mmc_host *host, int lazy);
> =A0 =A0 =A0 =A0void =A0 =A0(*request)(struct mmc_host *host, struct m=
mc_request *req);
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Avoid calling these three functions too often or in=
 a "fast path",
> @@ -118,6 +147,7 @@ struct mmc_host {
> =A0#define MMC_CAP_SPI =A0 =A0 =A0 =A0 =A0 =A0(1 << 4) =A0 =A0 =A0 =A0=
/* Talks only SPI protocols */
> =A0#define MMC_CAP_NEEDS_POLL =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0/* Need=
s polling for card-detection */
> =A0#define MMC_CAP_8_BIT_DATA =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* Can =
the host do 8 bit transfers */
> +#define MMC_CAP_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0 =
=A0 =A0 =A0/* Can the host be disabled */
>
> =A0 =A0 =A0 =A0/* host specific block data */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0max_seg_size; =A0 =
/* see blk_queue_max_segment_size */
> @@ -142,6 +172,13 @@ struct mmc_host {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0removed:1; =A0 =A0=
 =A0/* host is being removed */
> =A0#endif
>
> + =A0 =A0 =A0 /* Only used with MMC_CAP_DISABLE */
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enabled; =A0=
 =A0 =A0 =A0/* host is enabled */
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nesting_cnt=
; =A0 =A0/* "enable" nesting count */
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 en_dis_recu=
rs; =A0/* detect recursion */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0disable_delay; =A0/=
* disable delay in msecs */
> + =A0 =A0 =A0 struct delayed_work =A0 =A0 disable; =A0 =A0 =A0 =A0/* =
disabling work */
> +
> =A0 =A0 =A0 =A0struct mmc_card =A0 =A0 =A0 =A0 *card; =A0 =A0 =A0 =A0=
 =A0/* device attached to this host */
>
> =A0 =A0 =A0 =A0wait_queue_head_t =A0 =A0 =A0 wq;
> @@ -197,5 +234,15 @@ struct regulator;
> =A0int mmc_regulator_get_ocrmask(struct regulator *supply);
> =A0int mmc_regulator_set_ocr(struct regulator *supply, unsigned short=
 vdd_bit);
>
> +int mmc_host_enable(struct mmc_host *host);
> +int mmc_host_disable(struct mmc_host *host);
> +int mmc_host_lazy_disable(struct mmc_host *host);
> +
> +static inline void mmc_set_disable_delay(struct mmc_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0unsigned int disable_delay)
> +{
> + =A0 =A0 =A0 host->disable_delay =3D disable_delay;
> +}
> +
> =A0#endif
>
> --
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
