From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
Date: Fri, 30 Mar 2012 08:32:09 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831840E0C@DBDE01.ent.ti.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com> <87mx9ej8fp.fsf@ti.com>
 <CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com>
 <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
 <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
 <CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
 <CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
 <CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51937 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758579Ab2C3Icb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 04:32:31 -0400
In-Reply-To: <CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Fri, Mar 30, 2012 at 13:11:35, Shilimkar, Santosh wrote:
> On Fri, Mar 30, 2012 at 12:04 PM, Hiremath, Vaibhav <hvaibhav@ti.com>=
 wrote:
> > On Wed, Mar 28, 2012 at 20:19:07, Shilimkar, Santosh wrote:
> >> On Wed, Mar 28, 2012 at 8:07 PM, Hiremath, Vaibhav <hvaibhav@ti.co=
m> wrote:
> >> > On Wed, Mar 28, 2012 at 19:50:02, Shilimkar, Santosh wrote:
> >> >> On Wed, Mar 28, 2012 at 7:46 PM, Hiremath, Vaibhav <hvaibhav@ti=
=2Ecom> wrote:
> >> >> > On Wed, Mar 21, 2012 at 19:30:01, Shilimkar, Santosh wrote:
> >> >> >> On Wed, Mar 21, 2012 at 5:12 PM, Hiremath, Vaibhav <hvaibhav=
@ti.com> wrote:
> >> >> >> > On Mon, Mar 19, 2012 at 17:45:32, Shilimkar, Santosh wrote=
:
> >> >> >> >> On Monday 19 March 2012 05:14 PM, Ming Lei wrote:
> >> >> >> >> > On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hva=
ibhav@ti.com> wrote:
> >> >>
> [...]
>=20
> >> I thought so and now if you look at last part of my comment.
> >>
> >> Rating of 32K based synctimer and 32K based GPTIMER
> >> should be same because of the precision. That's the main
> >> point why I was saying that GPTIMER is not a better
> >> clock-source( with 32k clock src) =A0than sync timer when
> >> both are enabled together.
> >>
> >
> > Santosh,
> >
> > In case of OMAP, we are using timer 2 for clocksource
> >
> > OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, 2, OMAP2_MPU_SOURCE)
> > OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
> >
> > And timer2 as clocksource is never used, since we have CONFIG_OMAP_=
32K_TIMER
> > defined in our defconfig.
> >
> > Also, after looking at the code, I came across another problem, set=
up_sched_clock(). But this can be easily fixed, if we source both the t=
imers with same clock (here 32k_fck).
> >
> >
> > Let me propose this,
> >
> > How about, if I keep timer2 source always set to 32k_fclk for omap2=
,3,4?
> > And also, as mentioned by Santosh, I will register both the clocks =
as
> > clocksource with the same rating.
> > By default, kernel is going to use 32k_counter as a clocksource, an=
d through
> > Command prompt user can override it without any issues.
> >
> > Just to make sure that, whatever I am trying to propse here works a=
nd don't get into unknown issue; I changed my code for this, and it is =
working for me without any issues.
>=20
> Let's not make this more complicated. I guess below simple patch shou=
ld sort
> out the issue. I briefly tested it on OMAP4 and it works. let me know
> if it helps AMxxx machines.
>=20
> Regards
> Santosh
>=20
> From 0a9283e26174d76ff2753ac88521b61a26b24e8f Mon Sep 17 00:00:00 200=
1
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Fri, 30 Mar 2012 12:43:29 +0530
> Subject: [PATCH] ARM: OMAP: Make OMAP clocksource source selection ru=
ntime.
>=20
> Current OMAP code support couple of clocksource options based on comp=
ilation
> flag. The 32KHz based sync timer and a gptimer based clock source whi=
ch can
> run on 32KHz or system clock (e.g 38.4 MHz). So there can be 3 option=
s.
>=20
> 1. 32KHz synctimer
> 2. Sysclock based(e.g 38.4 MHz) gptimer
> 3. 32KHz based gptimer.
>=20
> The optional gptimer based clocksource was added so that it can give =
the
> high precision than synctimer so expected usage was 2 and not 3. Unfo=
rtunatlly
> option 2, clocksource doesn't meet the requirement of free-running cl=
ock
> as per clocksource need. It stops in low power states when  sysclock =
is cut.
> That makes gptimer based clocksource option useless for OMAP2/3/4 dev=
ices
> with sysclock as a clock input. Option 3 will still work but it is no=
 better'
> than 32K synctimer based clocksource.
>=20
> So ideally we can kill the gptimer based clocksource option but there=
 are some
> OMAP based derivative SoCs like AMXXXX which doesn't have synictimer =
hardware IP
> and need to fallback on 32KHz based gptimer clocksource.
>=20
> Considering above, make synctimer and gptimer clocksource runtime
> selectable so that both OMAP and AMXXXX continue to use the same code=
=2E
>=20
> Not-yet-signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c |   25 ++++++++-----------------
>  1 files changed, 8 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.=
c
> index c512bac..3878e59 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -234,21 +234,6 @@ static void __init omap2_gp_clockevent_init(int =
gptimer_id,
>  }
>=20
>  /* Clocksource code */
> -
> -#ifdef CONFIG_OMAP_32K_TIMER
> -/*
> - * When 32k-timer is enabled, don't use GPTimer for clocksource
> - * instead, just leave default clocksource which uses the 32k
> - * sync counter.  See clocksource setup in plat-omap/counter_32k.c
> - */
> -
> -static void __init omap2_gp_clocksource_init(int unused, const char =
*dummy)
> -{
> -	omap_init_clocksource_32k();
> -}
> -
> -#else
> -
>  static struct omap_dm_timer clksrc;
>=20
>  /*
> @@ -276,7 +261,7 @@ static u32 notrace dmtimer_read_sched_clock(void)
>  }
>=20
>  /* Setup free-running counter for clocksource */
> -static void __init omap2_gp_clocksource_init(int gptimer_id,
> +static void __init omap2_gptimer_clocksource_init(int gptimer_id,
>  						const char *fck_source)
>  {
>  	int res;
> @@ -295,7 +280,13 @@ static void __init omap2_gp_clocksource_init(int
> gptimer_id,
>  		pr_err("Could not register clocksource %s\n",
>  			clocksource_gpt.name);
>  }
> -#endif
> +
> +static void __init omap2_gp_clocksource_init(int gptimer_id,
> +                                                const char *fck_sour=
ce)
> +{
> +	if (omap_init_clocksource_32k())
> +		omap2_gptimer_clocksource_init(gptimer_id, fck_source);
> +}
>=20

With this patch, will you be able to choose gptimer as a clocksource
using bootparameter (or sysfs) for given kernel uImage?

The answer is simply NO...as the registration of gptimer is based on
failure from omap_init_clocksource_32k(). And this is nothing different=
=20
than my original patch, my patch exactly does same thing.

The requirement after 'ming Lie' response on my patch was, there will b=
e
usecases where we might need to use gptimer for clocksource and with=20
the patch it is not possible, since you will only register=20
32k_counter here.

So in order to allow user to choose between 32K and gptimer, you must=20
register both and make 32k as a default thing.


Thanks,
Vaibhav

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
