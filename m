From: Vishwanath Sripathy <vishwanath.bs-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] OMAP PM: Optimize cpufreq transition latency
Date: Wed, 1 Dec 2010 09:56:48 +0530
Message-ID: <ec3610408bb3eb61cc3415f0f2f3ace1@mail.gmail.com>
References: <1290692291-25073-1-git-send-email-vishwanath.bs@ti.com>
	<AANLkTin7QLrwjpwkbrq-5qo+5WH9KmqVmcJh61kbwXYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <AANLkTin7QLrwjpwkbrq-5qo+5WH9KmqVmcJh61kbwXYw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Mike,

> -----Original Message-----
> From: Turquette, Mike [mailto:mturquette-l0cyMroinI0@public.gmane.org]
> Sent: Wednesday, December 01, 2010 1:20 AM
> To: Vishwanath BS
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> Subject: Re: [PATCH] OMAP PM: Optimize cpufreq transition latency
>
> On Thu, Nov 25, 2010 at 7:38 AM, Vishwanath BS
> <vishwanath.bs-l0cyMroinI0@public.gmane.org> wrote:
> > Currently cpufreq transition latency value does not really reflect the
> actual
> > OMAP OPP transition delay. This patch has the actual latency value.
> > I did profile the DVFS latency on OMAP3430, OMAP3630 and OMAP4
> for worstcase(MPU and Core together) and found that in none of these
> platforms, transiton value
> > goes beyong 10ms. Added a buffer of 20ms to avoid too frequent
> ondemand timer
> > expiry.
> > With this change, performance of ondemand governor is improved
> when tested
> > using cpufreqbench tool. Without this patch, cpufreq-bench reported
> ondemand
> > performance as 40% of performance governor, and with this patch it's
> around 70%
> > (using below procedure).
> >
> > cpufreq-bench:
> > http://lwn.net/Articles/339862/
> > http://ftp.riken.go.jp/archives/Linux/suse/people/ckornacker/cpufreq-
> bench/
> >
> > Command used for performance testing:
> > cpufreq-bench -l 50000 -s 100000 -x 50000 -y 100000 -g ondemand -
> r 5 -n 5 -v
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs-l0cyMroinI0@public.gmane.org>
> > ---
> > =A0arch/arm/plat-omap/cpu-omap.c | =A0 =A04 ++--
> > =A01 files changed, 2 insertions(+), 2 deletions(-)
> > =A0mode change 100644 =3D> 100755 arch/arm/plat-omap/cpu-omap.c
> >
> > diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-
> omap/cpu-omap.c
> > old mode 100644
> > new mode 100755
> > index c47faf8..d3fc423
> > --- a/arch/arm/plat-omap/cpu-omap.c
> > +++ b/arch/arm/plat-omap/cpu-omap.c
> > @@ -158,8 +158,8 @@ static int __init omap_cpu_init(struct
> cpufreq_policy *policy)
> > =A0 =A0 =A0 =A0policy->max =3D policy->cpuinfo.max_freq;
> > =A0 =A0 =A0 =A0policy->cur =3D omap_getspeed(0);
> >
> > - =A0 =A0 =A0 /* FIXME: what's the actual transition time? */
> > - =A0 =A0 =A0 policy->cpuinfo.transition_latency =3D 300 * 1000;
> > + =A0 =A0 =A0 /* Program the actual transition time for worstcase */
> > + =A0 =A0 =A0 policy->cpuinfo.transition_latency =3D 30 * 1000;
>
> Vishwa,
>
> This is a frequent periodic timer.  Does a smaller value have any
> affect on CPUidle wakeups?
I do not think so since this is a deferrable timer which should not
interrupt CPUIdle.

Vishwa
>
> Thanks,
> Mike
>
> > =A0 =A0 =A0 =A0return 0;
> > =A0}
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap"
in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >
