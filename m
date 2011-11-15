From: Omar Ramirez Luna <or.rmz1@gmail.com>
Subject: Re: [PATCH v16 09/12] OMAP: dmtimer: low-power mode support
Date: Tue, 15 Nov 2011 11:57:59 -0600
Message-ID: <CAPTm=KGDEKGxLpJt0t6k_NL5Wz81NkMmRJ+OkmyvHedd6_exgQ@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53252 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757024Ab1KOR6A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Nov 2011 12:58:00 -0500
Received: by yenq3 with SMTP id q3so905072yen.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Nov 2011 09:58:00 -0800 (PST)
In-Reply-To: <1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Tarun,

On Tue, Sep 20, 2011 at 6:30 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> Clock is enabled only when timer is started and disabled when the the=
 timer
> is stopped. Therefore before accessing registers in functions clock i=
s enabled
> and then disabled back at the end of access. Context save is done dyn=
amically
> whenever the registers are modified. Context restore is called when c=
ontext is
> lost.

Now that handling of the clock has been decoupled from
omap_dm_timer_request_specific/free and placed in start/stop
functions, there is a "possible irq lock inversion dependency
detected" for any attempt to enable the clock from soft|hard irq.

My use case is as follows:

DSP sends a mailbox message to ARM, this triggers a tasklet in mailbox
for processing the message, when it reaches tidspbridge it turns out
that the DSP wants to enable a gpt timer; however, locks involved
"clocks_mutex" and "dm_timer_lock" now could cause a deadlock as they
have been called from unsafe contexts in the past
(http://pastebin.com/7Dtz8t0f).

Is the intention to restrict enabling the dmtimer clocks from hard|soft=
 irqs?

=2E..
> @@ -303,6 +342,22 @@ void omap_dm_timer_stop(struct omap_dm_timer *ti=
mer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rate =3D clk_get_rate(timer->fclk);
>
> =A0 =A0 =A0 =A0__omap_dm_timer_stop(timer, timer->posted, rate, is_om=
ap2);
> +
> + =A0 =A0 =A0 if (timer->loses_context) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timer->get_context_loss_count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->ctx_loss_count =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->get_context_loss=
_count(&timer->pdev->dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Since the register values are computed and written=
 within
> + =A0 =A0 =A0 =A0* __omap_dm_timer_stop, we need to use read to retri=
eve the
> + =A0 =A0 =A0 =A0* context.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 timer->context.tclr =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dm_timer_read_reg(=
timer, OMAP_TIMER_CTRL_REG);
> + =A0 =A0 =A0 timer->context.tisr =3D __raw_readl(timer->irq_stat);
> + =A0 =A0 =A0 omap_dm_timer_disable(timer);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
>

I didn't review the whole patch, but at least this part is not in
mainline, it seems like the patch modified by Tony and the v16 were
not the same.

I could diff and include the missing parts, if someone can confirm
that we need v16, which I believe so, since current stop function
doesn't call omap_dm_timer_disable.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
