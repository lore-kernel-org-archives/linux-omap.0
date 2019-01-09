From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Date: Wed, 9 Jan 2019 15:12:25 +0100
Message-ID: <CAKfTPtAsENRKh_wTFXCLW2_MdMBug+tV2KtjC7x6RigN7hgPmw@mail.gmail.com>
References: <20190107233833.GI5544@atomide.com> <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com> <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109111703.GA28605@lenoch> <CAKfTPtBvzZvJNxBRMbGbNFBYG0-pAR-P7X2=KrBWH01OMWvJYA@mail.gmail.com>
 <20190109115824.GA1353@lenoch> <CAKfTPtAAgYYW8A1LDg18bM=5vCAMDbQ05APp9QWSaifW=F0SgQ@mail.gmail.com>
 <20190109133337.GA13579@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109133337.GA13579@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Please keep all thread list when replying :-)

On Wed, 9 Jan 2019 at 14:33, Ladislav Michl <ladis@linux-mips.org> wrote:
>
> On Wed, Jan 09, 2019 at 02:24:37PM +0100, Vincent Guittot wrote:
> > On Wed, 9 Jan 2019 at 12:58, Ladislav Michl <ladis@linux-mips.org> wrot=
e:
> > >
> > > On Wed, Jan 09, 2019 at 12:27:57PM +0100, Vincent Guittot wrote:
> > > > On Wed, 9 Jan 2019 at 12:17, Ladislav Michl <ladis@linux-mips.org> =
wrote:
> > > > >
> > > > > On Wed, Jan 09, 2019 at 02:42:18AM +0100, Vincent Guittot wrote:
> > > > > > Le Tuesday 08 Jan 2019 =C3=A0 13:37:43 (-0800), Tony Lindgren a=
 =C3=A9crit :
> > > > > > > * Vincent Guittot <vincent.guittot@linaro.org> [190108 16:42]=
:
> > > > > > > > On Tue, 8 Jan 2019 at 16:53, Tony Lindgren <tony@atomide.co=
m> wrote:
> > > > > > > > > Hmm so could it be that we now rely on timers that that m=
ay
> > > > > > > > > not be capable of waking up the system from idle states w=
ith
> > > > > > > > > hrtimer?
> > > > > > > >
> > > > > > > > With nohz and hrtimer enabled,  timer relies on hrtimer to =
generate
> > > > > > > > the tick so you should use the same interrupt.
> > > > > > >
> > > > > > > OK yeah looks like that part is working just fine.
> > > > > > >
> > > > > > > Adding some printks and debugging over ssh, looks like
> > > > > > > omap8250_runtime_resume() gets called just fine based on a wa=
keirq,
> > > > > > > but then omap8250_runtime_suspend() runs immediately instead =
of
> > > > > > > waiting for the three second timeout.
> > > > > > >
> > > > > > > Lowering the autosuspend_delay_ms to 2100 ms makes things wor=
k again.
> > > > > > > Anything higher than 2200 ms seems to somehow time out immedi=
ately
> > > > > > > now :)
> > > > > >
> > > > > > This is quite close to the max ns of an int on arm 32bits
> > > > > >
> > > > > > Could you try the patch below ?
> > > > > >
> > > > > > ---
> > > > > >  drivers/base/power/runtime.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/=
runtime.c
> > > > > > index 7062469..44c5c76 100644
> > > > > > --- a/drivers/base/power/runtime.c
> > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > @@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struc=
t device *dev)
> > > > > >
> > > > > >       last_busy =3D READ_ONCE(dev->power.last_busy);
> > > > > >
> > > > > > -     expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC=
;
> > > > > > +     expires =3D last_busy + (u64)(autosuspend_delay) * NSEC_P=
ER_MSEC;
> > > > > >       if (expires <=3D now)
> > > > > >               expires =3D 0;    /* Already expired. */
> > > > >
> > > > > Hmm, comment above function states it returns "the expiration tim=
e in jiffies
> > > > > (adjusted to be nonzero)", so there's probably more to fix...
> > > >
> > > > The comment is wrong and should be updated as commit 8234f6734c5d h=
as
> > > > moved on hrtimer and expires is now in raw ns unit
> > >
> > > Yup. Who'll send a patch? Is it worth optimizing as bellow? I'm fine =
with doing
> >
> > You can send a patch for updating the comment.
> >
> > > both.
> >
> > Regarding proposal below:
> > - pm_runtime_autosuspend_expiration() returns u64 and not ktime_t
>
> Well, that's matter of adding ktime_to_ns (which is noop).
>
> > - use helper ktime_before/after to compare ktime_t value
> >
> > Using ktime helper function makes the code less readable and the
>
> That why I avoided it.

But you must use helper function if you use ktime_t
That's one main reason for using u64 instead of ktime_t

>
> > proposal make the function more difficult to read IMHO when you
> > compare
> >   expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC;
> > with
> >   expires =3D ktime_add_ns(ms_to_ktime(autosuspend_delay),
> >                               READ_ONCE(dev->power.last_busy));
>
> I agree, but it doea all the magic correctly, so you won't need
> to touch that code is ktime_t changes (I know, unlikely..)

But the current implementation doesn't care of any changes in ktime_t
as it uses raw ns

>
> > or when you compare
> >  if (expires <=3D now)
> > with
> >  if (ktime_after(now, expires))
> >
> > And  I'm not sure that this will optimize the code at the end
>
> Checked generated code on ARM and x86 and gcc does pretty good job here.
>
> > Only the replacement of the "goto out" by return 0 would make sense IMO
>
> Well, main concern was not to call ktime_get at the beginning of function
> as it is not too cheap.

Doesn't the compiler optimize that to just before the test ?

>
> > Regards,
> > Vincent
> >
> > >
> > > > > You can also consider change like this (still does not return jif=
fies):
> > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/ru=
ntime.c
> > > > > index 70624695b6d5..c72eaf21a61c 100644
> > > > > --- a/drivers/base/power/runtime.c
> > > > > +++ b/drivers/base/power/runtime.c
> > > > > @@ -129,23 +129,20 @@ static void pm_runtime_cancel_pending(struc=
t device *dev)
> > > > >  u64 pm_runtime_autosuspend_expiration(struct device *dev)
> > > > >  {
> > > > >         int autosuspend_delay;
> > > > > -       u64 last_busy, expires =3D 0;
> > > > > -       u64 now =3D ktime_to_ns(ktime_get());
> > > > > +       ktime_t expires;
> > > > >
> > > > >         if (!dev->power.use_autosuspend)
> > > > > -               goto out;
> > > > > +               return 0;
> > > > >
> > > > >         autosuspend_delay =3D READ_ONCE(dev->power.autosuspend_de=
lay);
> > > > >         if (autosuspend_delay < 0)
> > > > > -               goto out;
> > > > > -
> > > > > -       last_busy =3D READ_ONCE(dev->power.last_busy);
> > > > > +               return 0;
> > > > >
> > > > > -       expires =3D last_busy + autosuspend_delay * NSEC_PER_MSEC=
;
> > > > > -       if (expires <=3D now)
> > > > > -               expires =3D 0;    /* Already expired. */
> > > > > +       expires =3D ktime_add_ns(ms_to_ktime(autosuspend_delay),
> > > > > +                              READ_ONCE(dev->power.last_busy));
> > > > > +       if (expires <=3D ktime_get())
> > > > > +               return 0;       /* Already expired. */
> > > > >
> > > > > - out:
> > > > >         return expires;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
> > > > >
> > > > > Regards,
> > > > >         ladis
