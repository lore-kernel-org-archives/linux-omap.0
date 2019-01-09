From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Date: Wed, 9 Jan 2019 17:48:23 +0100
Message-ID: <CAKfTPtBzE9fqDgUOJ4uTj_Dtfe2KCp+R4FajAaQqpV02upQZJA@mail.gmail.com>
References: <20190107233833.GI5544@atomide.com> <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com> <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com> <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
 <20190109162846.GP5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109162846.GP5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Ladislav Michl <ladis@linux-mips.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 9 Jan 2019 at 17:28, Tony Lindgren <tony@atomide.com> wrote:
>
> * Rafael J. Wysocki <rafael@kernel.org> [190109 09:44]:
> > On Wed, Jan 9, 2019 at 2:51 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Vincent Guittot <vincent.guittot@linaro.org> [190109 01:42]:
> > > > Le Tuesday 08 Jan 2019 =C3=A0 13:37:43 (-0800), Tony Lindgren a =C3=
=A9crit :
> > > > > Lowering the autosuspend_delay_ms to 2100 ms makes things work ag=
ain.
> > > > > Anything higher than 2200 ms seems to somehow time out immediatel=
y
> > > > > now :)
> > > >
> > > > This is quite close to the max ns of an int on arm 32bits
> > > >
> > > > Could you try the patch below ?
> > >
> > > Yup great thanks, that's it:
> > >
> > > Tested-by: Tony Lindgren <tony@atomide.com>
> >
> > Cool.  Thanks for getting to the bottom of this!
>
> No problem.
>
> One more thing I noticed: The 25% slack can get noticeable
> for larger values. For things like a 3 second uart console
> timeout slack of 750 ms is quite large variation.
>
> Should we have a limit of max 100 ms for the slack?

Keep in mind that when jiffies were used, expires was rounded to a
full second when delay was greater than a second. So you could already
have difference of up 990ms on arm before this patch
And i don't take into account the rework of timer infra which add
another level of variation, something like up to 640 ms more when the
timer is greater than 2880 ms for arm IIRC
>
> Regards,
>
> Tony
