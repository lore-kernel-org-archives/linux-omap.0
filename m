From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
Date: Tue, 5 Feb 2019 14:24:33 +0100
Message-ID: <CAMuHMdWdbRpA_M4V1kigab6U8rSDgGYXtidiSU4MVdj5xarK8g@mail.gmail.com>
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org> <CAPDyKFpyg7oGoDZA+=SG7R3yL874Geeqs5LWrsAf50csxsE05A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpyg7oGoDZA+=SG7R3yL874Geeqs5LWrsAf50csxsE05A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Ulf,

On Wed, Jan 30, 2019 at 1:15 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 30 Jan 2019 at 12:16, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
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
>
> Hmm, isn't this already a problem in genpd then?
>
> In genpd's ->runtime_resume() callback (genpd_runtime_resume()) we
> call ktime_get() to measure the latency of running the callback.
>
> Or, perhaps irq_safe_dev_in_no_sleep_domain() returns true for the
> genpd + device in question, which means the ktime thingy is skipped.
>
> Geert?

Correct. After adding

    dev_info(dev, "%s: pm_runtime_is_irq_safe = %d,
genpd_is_irq_safe(%s) = %d => %s\n", __func__,
pm_runtime_is_irq_safe(dev), genpd->name, genpd_is_irq_safe(genpd),
ret ? "true" : "false");

I see on R-Car M2-W:

    sh_cmt ffca0000.timer: irq_safe_dev_in_no_sleep_domain:
pm_runtime_is_irq_safe = 1, genpd_is_irq_safe(always-on) = 0 => true

For all other devices, the result is false.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
