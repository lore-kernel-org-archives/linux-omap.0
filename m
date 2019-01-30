From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] PM-runtime: fix deadlock with ktime
Date: Wed, 30 Jan 2019 10:14:10 +0100
Message-ID: <CAKfTPtBiWunvVHv=tpq7CPqAX+54d_dyPt6BME_m1_Wz+qPaTA@mail.gmail.com>
References: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org> <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Geert,

On Wed, 30 Jan 2019 at 09:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Vincent,
>
> On Wed, Jan 30, 2019 at 9:16 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > The call path is:
> > change_clocksource
> >     ...
> >     write_seqcount_begin
> >     ...
> >     timekeeping_update
> >         ...
> >         sh_cmt_clocksource_enable
> >             ...
> >             rpm_resume
> >                 pm_runtime_mark_last_busy
> >                     ktime_get
> >                         do
> >                             read_seqcount_begin
> >                         while read_seqcount_retry
> >     ....
> >     write_seqcount_end
> >
> > Although we should be safe because we haven't yet changed the clocksource
> > at that time, we can't because of seqcount protection.
> >
> > Use ktime_get_mono_fast_ns instead which is lock safe for such case
> >
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Thanks for your patch!
>
> /**
>  * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
>  *
>  * This timestamp is not guaranteed to be monotonic across an update.
>  * The timestamp is calculated by:
>  *
>  *      now = base_mono + clock_delta * slope
>  *
>  * So if the update lowers the slope, readers who are forced to the
>  * not yet updated second array are still using the old steeper slope.
>  *
>  * tmono
>  * ^
>  * |    o  n
>  * |   o n
>  * |  u
>  * | o
>  * |o
>  * |12345678---> reader order
>  *
>  * o = old slope
>  * u = update
>  * n = new slope
>  *
>  * So reader 6 will observe time going backwards versus reader 5.
>  *
>  * While other CPUs are likely to be able observe that, the only way
>  * for a CPU local observation is when an NMI hits in the middle of
>  * the update. Timestamps taken from that NMI context might be ahead
>  * of the following timestamps. Callers need to be aware of that and
>  * deal with it.
>  */
>
> As this function is not guaranteed to be monotonic, have you checked how
> the Runtime PM code behaves if time goes backwards? Does it just make
> a suboptimal decision or does it crash?

As a worst case this will generate a suboptimal decision around the update

Regards,
Vincent

>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
