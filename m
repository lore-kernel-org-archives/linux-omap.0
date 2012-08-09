From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] cpufreq: OMAP: Handle missing frequency table on SMP systems
Date: Thu, 9 Aug 2012 10:57:37 +0530
Message-ID: <CAMQu2gxo8gdvk1jYx_asw+R7iyE1OAqxaVFbDgJSc0ED_-y9xQ@mail.gmail.com>
References: <1344423254-3475-1-git-send-email-rnayak@ti.com>
 <1344423254-3475-2-git-send-email-rnayak@ti.com> <CAMQu2gyooQ4x=ZGDZFg5BuBaEkgQx2kTAvtiGLEjXwOYvF_wMQ@mail.gmail.com>
 <87wr19uwbx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:38205 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864Ab2HIF2A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 01:28:00 -0400
Received: by weyx10 with SMTP id x10so116233wey.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 22:27:57 -0700 (PDT)
In-Reply-To: <87wr19uwbx.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Wed, Aug 8, 2012 at 10:58 PM, Kevin Hilman <khilman@ti.com> wrote:
>
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
>
> > On Wed, Aug 8, 2012 at 4:24 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> >>
> >> On OMAP4, if the first CPU fails to get a valid frequency table (this
> >> could happen if the platform does not register any OPP table), the
> >> subsequent CPU instances end up dealing with a NULL freq_table and
> >> crash. Add a check for a NULL freq_table to help error the rest
> >> of the CPU instances out.
> >>
> >> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >> Cc: <linux-pm@vger.kernel.org>
> >> ---
> >>  drivers/cpufreq/omap-cpufreq.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cpufreq/omap-cpufreq.c
> >> b/drivers/cpufreq/omap-cpufreq.c
> >> index 17fa04d..0ee824c 100644
> >> --- a/drivers/cpufreq/omap-cpufreq.c
> >> +++ b/drivers/cpufreq/omap-cpufreq.c
> >> @@ -221,7 +221,7 @@ static int __cpuinit omap_cpu_init(struct
> >> cpufreq_policy *policy)
> >>         if (atomic_inc_return(&freq_table_users) == 1)
> >>                 result = opp_init_cpufreq_table(mpu_dev, &freq_table);
> >>
> >> -       if (result) {
> >> +       if (result || !freq_table) {
> >>                 dev_err(mpu_dev, "%s: cpu%d: failed creating freq
> >> table[%d]\n",
> >>                                 __func__, policy->cpu, result);
> >>                 goto fail_ck;
> >
> > The freq_table use count seems to be buggy in that case.
> > Something like below should fix the issue.
> > Feel free to update your patch with below if you agree.
> >
> > diff --git a/drivers/cpufreq/omap-cpufreq.c
> > b/drivers/cpufreq/omap-cpufreq.c
> > index 17fa04d..fd97c3d 100644
> > --- a/drivers/cpufreq/omap-cpufreq.c
> > +++ b/drivers/cpufreq/omap-cpufreq.c
> > @@ -218,7 +218,7 @@ static int __cpuinit omap_cpu_init(struct
> > cpufreq_policy *po
> >
> >         policy->cur = policy->min = policy->max =
> > omap_getspeed(policy->cpu);
> >
> > -       if (atomic_inc_return(&freq_table_users) == 1)
> > +       if (freq_table)
>
> I think you meant 'if (!freq_table)' ?
>
Right.

regards
Santosh
