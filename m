From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Date: Wed, 9 Jan 2019 12:27:57 +0100
Message-ID: <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
References: <20190107233833.GI5544@atomide.com> <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com> <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org> <20190109111703.GA28605@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109111703.GA28605@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 9 Jan 2019 at 12:17, Ladislav Michl <ladis@linux-mips.org> wrote:
>
> On Wed, Jan 09, 2019 at 02:42:18AM +0100, Vincent Guittot wrote:
> > Le Tuesday 08 Jan 2019 =C3=A0 13:37:43 (-0800), Tony Lindgren a =C3=A9c=
rit :
> > > * Vincent Guittot <vincent.guittot@linaro.org> [190108 16:42]:
> > > > On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.com> wrote=
:
> > > > > Hmm so could it be that we now rely on timers that that may
> > > > > not be capable of waking up the system from idle states with
> > > > > hrtimer?
> > > >
> > > > With nohz and hrtimer enabled,  timer relies on hrtimer to generate
> > > > the tick so you should use the same interrupt.
> > >
> > > OK yeah looks like that part is working just fine.
> > >
> > > Adding some printks and debugging over ssh, looks like
> > > omap8250_runtime_resume() gets called just fine based on a wakeirq,
> > > but then omap8250_runtime_suspend() runs immediately instead of
> > > waiting for the three second timeout.
> > >
> > > Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
> > > Anything higher than 2200 ms seems to somehow time out immediately
> > > now :)
> >
> > This is quite close to the max ns of an int on arm 32bits
> >
> > Could you try the patch below ?
> >
> > ---
> >  drivers/base/power/runtime.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.=
c
> > index 7062469..44c5c76 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device=
 *dev)
> >
> >       last_busy =3D READ_ONCE(dev->power.last_busy);
> >
> > -     expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC;
> > +     expires =3D last_busy + (u64)(autosuspend_delay) * NSEC_PER_MSEC;
> >       if (expires <=3D now)
> >               expires =3D 0;    /* Already expired. */
>
> Hmm, comment above function states it returns "the expiration time in jif=
fies
> (adjusted to be nonzero)", so there's probably more to fix...

The comment is wrong and should be updated as commit 8234f6734c5d has
moved on hrtimer and expires is now in raw ns unit

>
> You can also consider change like this (still does not return jiffies):
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 70624695b6d5..c72eaf21a61c 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -129,23 +129,20 @@ static void pm_runtime_cancel_pending(struct device=
 *dev)
>  u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  {
>         int autosuspend_delay;
> -       u64 last_busy, expires =3D 0;
> -       u64 now =3D ktime_to_ns(ktime_get());
> +       ktime_t expires;
>
>         if (!dev->power.use_autosuspend)
> -               goto out;
> +               return 0;
>
>         autosuspend_delay =3D READ_ONCE(dev->power.autosuspend_delay);
>         if (autosuspend_delay < 0)
> -               goto out;
> -
> -       last_busy =3D READ_ONCE(dev->power.last_busy);
> +               return 0;
>
> -       expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC;
> -       if (expires <=3D now)
> -               expires =3D 0;    /* Already expired. */
> +       expires =3D ktime_add_ns(ms_to_ktime(autosuspend_delay),
> +                              READ_ONCE(dev->power.last_busy));
> +       if (expires <=3D ktime_get())
> +               return 0;       /* Already expired. */
>
> - out:
>         return expires;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
>
> Regards,
>         ladis
