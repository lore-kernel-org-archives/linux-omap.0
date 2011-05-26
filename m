From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 6/8] OMAP2+: cpufreq: fix freq_table leak
Date: Wed, 25 May 2011 17:47:32 -0700
Message-ID: <BANLkTimp35KXz6WFbMWgAMdy=szYYES4mg@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <1306366733-8439-7-git-send-email-nm@ti.com>
 <877h9ejoy1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34705 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757231Ab1EZArx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 20:47:53 -0400
Received: by mail-ww0-f53.google.com with SMTP id 40so169466wwj.22
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 17:47:52 -0700 (PDT)
In-Reply-To: <877h9ejoy1.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, May 25, 2011 at 17:16, Kevin Hilman <khilman@ti.com> wrote:
>
> Nishanth Menon <nm@ti.com> writes:
>
> > Since we have multiple CPUs, the cpuinit call for CPU1 causes
> > freq_table of CPU0 to be overwritten. Instead, we maintain
> > a counter to keep track of cpus who use the cpufreq table
> > allocate it once(one freq table for all CPUs) and free them
> > once the last user is done with it. We also need to protect
> > freq_table and this new counter from updates from multiple
> > contexts to be on a safe side.
>
> Not sure I understand the need for all the locking here. =A0Once allo=
cated
> and filled, the freq_table isn't changing. =A0Also, all the functions=
 are
> only reading the freq_table, not changing it. =A0 =A0So what is it yo=
u're
> trying to protect against?

We just have one freq_table for both cpu0 and cpu1. We have common
data structure(freq_table and users) which is modifiable in two
APIs(init/exit) and a set of reads. What if there is a read path while
free occurs - I may be mistaken, but my understanding is that the
datastructure used in my code should be secured in my code and I
cannot depend on higher layer(cpufreq/governors) to ensure that.

>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/omap2plus-cpufreq.c | =A0 62 +++++++++++++++=
++++++++++++----
> > =A01 files changed, 54 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mac=
h-omap2/omap2plus-cpufreq.c
> > index 3ff3302..f026ac4 100644
> > --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> > +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c

[..]
> > @@ -156,22 +173,48 @@ skip_lpj:
> >
> > =A0static int freq_table_alloc(void)
> > =A0{
> > - =A0 =A0 if (use_opp)
> > - =A0 =A0 =A0 =A0 =A0 =A0 return opp_init_cpufreq_table(mpu_dev, &f=
req_table);
> > + =A0 =A0 int ret =3D 0;
> >
> > - =A0 =A0 clk_init_cpufreq_table(&freq_table);
> > - =A0 =A0 if (!freq_table)
> > - =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > + =A0 =A0 mutex_lock(&freq_table_lock);
> >
> > - =A0 =A0 return 0;
> > + =A0 =A0 freq_table_users++;
> > + =A0 =A0 /* Did we allocate previously? */
> > + =A0 =A0 if (freq_table_users - 1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> Rather than the ' - 1', this can just be
>
> =A0 =A0 if (freq_table_users++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
ok

>
> or better, you probably don't need this check protected by the mutex,
> so this could just return directly, and then take the mutex_lock() af=
ter
> this point.
The mutex lock was to protect both the freq_table and the count as
they protect the same resource - freq_table

>
> However, if you get rid of the mutex (and I think you should), you co=
uld
> use an atomic variable here
yes, we can use just atomic to protect alloc Vs free - but we cannot
protect read Vs free


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
