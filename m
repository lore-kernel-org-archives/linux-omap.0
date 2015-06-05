From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Fri, 5 Jun 2015 10:42:58 -0500
Message-ID: <20150605154257.GB32720@saruman.tx.rr.com>
References: <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com>
 <55701E93.60303@free.fr>
 <20150604200850.GF5710@saruman.tx.rr.com>
 <20150604201825.GG5710@saruman.tx.rr.com>
 <20150604202943.GH5710@saruman.tx.rr.com>
 <20150604222057.GA8099@codeaurora.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49957 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754840AbbFEPpx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Jun 2015 11:45:53 -0400
Content-Disposition: inline
In-Reply-To: <20150604222057.GA8099@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Felipe Balbi <balbi@ti.com>, Mason <slash.tmp@free.fr>, Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2015 at 03:20:57PM -0700, Stephen Boyd wrote:
> On 06/04, Felipe Balbi wrote:
> > On Thu, Jun 04, 2015 at 03:18:25PM -0500, Felipe Balbi wrote:
> > > On Thu, Jun 04, 2015 at 03:08:50PM -0500, Felipe Balbi wrote:
> > > > Hi,
> > > >=20
> > > > On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
> > > > > Also, check /proc/timer_list for a "Broadcast device". If you don=
't
> > > > > define one, the TWD timers are set to periodic mode, with hrtimers
> > > > > disabled.
> > > >=20
> > > > Did you manage to turn global timer into Broadcast device ?
> > >=20
> > > arm_global_timer is marked PERCPU, so it will never be chosen as
> > > broadcast.
> >=20
> > Perhaps this is acceptable ?
> >=20
> > diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksour=
ce/arm_global_timer.c
> > index e6833771a716..8c0170ac367d 100644
> > --- a/drivers/clocksource/arm_global_timer.c
> > +++ b/drivers/clocksource/arm_global_timer.c
> > @@ -169,8 +169,9 @@ static int gt_clockevents_init(struct clock_event_d=
evice *clk)
> >  	int cpu =3D smp_processor_id();
> > =20
> >  	clk->name =3D "arm_global_timer";
> > -	clk->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
> > -		CLOCK_EVT_FEAT_PERCPU;
> > +	clk->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> > +	if (is_smp() || setup_max_cpus)
> > +		clk->features |=3D CLOCK_EVT_FEAT_PERCPU;
> >  	clk->set_mode =3D gt_clockevent_set_mode;
> >  	clk->set_next_event =3D gt_clockevent_set_next_event;
> >  	clk->cpumask =3D cpumask_of(cpu);
> >=20
>=20
> What is this doing? Allowing the global timer to become the
> broadcast timer? Can you share all the clockevents that are being

yeah, as long as have single CPU.

> registered in the system and what ratings and features they have?

Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 4
now at 126645624877 nsecs

cpu: 0
 clock 0:
  .base:       eeec36b8
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <eeec3970>, tick_sched_timer, S:01
 # expires at 126646000000-126646000000 nsecs [in 375123 to 375123 nsecs]
 #1: def_rt_bandwidth, sched_rt_period_timer, S:01
 # expires at 127000000000-127000000000 nsecs [in 354375123 to 354375123 ns=
ecs]
 #2: <ed07ff28>, hrtimer_wakeup, S:01
 # expires at 135190356958-135190406958 nsecs [in 8544732081 to 8544782081 =
nsecs]
 #3: <ed17bb40>, timerfd_tmrproc, S:01
 # expires at 136961414000-136961414000 nsecs [in 10315789123 to 1031578912=
3 nsecs]
 #4: <ed17bcc0>, timerfd_tmrproc, S:01
 # expires at 156961414000-156961414000 nsecs [in 30315789123 to 3031578912=
3 nsecs]
 #5: <ed1fde40>, timerfd_tmrproc, S:01
 # expires at 157211414000-157211414000 nsecs [in 30565789123 to 3056578912=
3 nsecs]
 #6: <ed143c00>, timerfd_tmrproc, S:01
 # expires at 180211414000-180211414000 nsecs [in 53565789123 to 5356578912=
3 nsecs]
 #7: <ee43d0c0>, timerfd_tmrproc, S:01
 # expires at 305461414000-305461414000 nsecs [in 178815789123 to 178815789=
123 nsecs]
 #8: <ed11fae0>, hrtimer_wakeup, S:01
 # expires at 606265898975-606365898975 nsecs [in 479620274098 to 479720274=
098 nsecs]
 #9: sched_clock_timer, sched_clock_poll, S:01
 # expires at 1924145348608-1924145348608 nsecs [in 1797499723731 to 179749=
9723731 nsecs]
 clock 1:
  .base:       eeec36f8
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1433450686592811401 nsecs
active timers:
 #0: <ee43cc00>, timerfd_tmrproc, S:01
 # expires at 2147483647000000000-2147483647000000000 nsecs [in 21474835203=
54375123 to 2147483520354375123 nsecs]
 clock 2:
  .base:       eeec3738
  .index:      2
  .resolution: 1 nsecs
  .get_time:   ktime_get_boottime
  .offset:     0 nsecs
active timers:
 clock 3:
  .base:       eeec3778
  .index:      3
  .resolution: 1 nsecs
  .get_time:   ktime_get_clocktai
  .offset:     1433450686592811401 nsecs
active timers:
  .expires_next   : 126646000000 nsecs
  .hres_active    : 1
  .nr_events      : 6888
  .nr_retries     : 0
  .nr_hangs       : 0
  .max_hang_time  : 0 nsecs
  .nohz_mode      : 2
  .last_tick      : 126639000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294793935
  .idle_calls     : 3733
  .idle_sleeps    : 1759
  .idle_entrytime : 126644701595 nsecs
  .idle_waketime  : 126640000808 nsecs
  .idle_exittime  : 126640012942 nsecs
  .idle_sleeptime : 121454496379 nsecs
  .iowait_sleeptime: 23896349 nsecs
  .last_jiffies   : 4294793940
  .next_jiffies   : 4294793941
  .idle_expires   : 126640000000 nsecs
jiffies: 4294793941

Tick Device: mode:     1
Broadcast device
Clock Event Device: arm_global_timer
 max_delta_ns:   4294967295
 min_delta_ns:   1000
 mult:           2147483648
 shift:          31
 mode:           1
 next_event:     9223372036854775807 nsecs
 set_next_event: gt_clockevent_set_next_event
 set_mode:       gt_clockevent_set_mode
 event_handler:  tick_handle_oneshot_broadcast
 retries:        0

tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000

Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: local_timer
 max_delta_ns:   4294967295
 min_delta_ns:   1000
 mult:           2147483648
 shift:          31
 mode:           3
 next_event:     126646000000 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0

--=20
balbi

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVccOBAAoJEIaOsuA1yqREZVAP/jdTwMy+iW8vQVJvbP+t96iX
LW8yUh8392gYCnsD3PT4liDagQ550rIDwicaYObsEG9PvprWThQdEyvGqHKN7bBI
OnxD58AQp4vuULcwMPGZvbFuBh8YdlxqodNriq5M6jG/lrmvndwMc0HFMZigYeqh
CIGs4LZp+ZncLx7iEnujnAuggI5jTfLmnSj7Xucm2rmDR37382tY/cA0XUlCrKq6
rQEVIYxF+dPbADwUrLXSTxNOdEITEceoQttWfMEySr88PLXOOt7GOMQ+UN0Dd1Wv
z26gDuvhBZXXIIMF1qL8JaTlhfNdk+y28mjB1+N6yQDX1ZhxuBhQBYki9Qc0ySsg
M45xmn7rSLR/lGzW+TlEJWkg0/+Gus+v+lntfQDf3XS8iItI5a81+z3ShEA+c9vW
8VHZcc2ah1wdaJbh7La911d3CpKwEqzFmgtmolDvjTyjiTdRCotFTiFSYCKuwKHi
YMHpUqyPGSEbHsmZLyj9CIEu2ncCJWz+/36E1Oe0P+84RKwPnWh5akDs9djMFmVC
4btv/ie45OyHKYXYpuJyslOvtAlojYpfFlWUy09Pk4NiVccbosSr+Cqi5reyjPzD
eklpiAZ8HE5xGUA71YvbZRJvQzytaG8if4Rnn8Kgb4TjpEV1orNWTyScXqWwmhCY
tx33wQwdQNvJkuc8lGpc
=OSTW
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
