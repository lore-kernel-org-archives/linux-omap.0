From: Rabin Vincent <rabin@rab.in>
Subject: Re: !CONFIG_OMAP_32K_TIMER on OMAP4/panda
Date: Sun, 8 May 2011 14:41:31 +0530
Message-ID: <BANLkTi=ZGTcsSiDJfHT-dq-oOnfuTCaFHQ@mail.gmail.com>
References: <BANLkTi=YdcHp4mxcZ1MtG8m5st4zeSY=gg@mail.gmail.com> <2A3DCF3DA181AD40BDE86A3150B27B6B0374D103A2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42810 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab1EHJMM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 May 2011 05:12:12 -0400
Received: by bwz15 with SMTP id 15so3357675bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 08 May 2011 02:12:11 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0374D103A2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Sun, May 8, 2011 at 10:29, Pedanekar, Hemant <hemantp@ti.com> wrote:
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/tim=
er-gp.c
> index 3b9cf85..290fbfa 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -229,6 +229,11 @@ static void __init omap2_gp_clocksource_init(voi=
d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: failed to request dm-timer\n";
> =A0 =A0 =A0 =A0static char err2[] __initdata =3D KERN_ERR
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: can't register clocksource!\n";
> + =A0 =A0 =A0 char clocksource_hwmod_name[8]; /* 8 =3D sizeof("timerX=
X0") */
> +
> + =A0 =A0 =A0 /* XXX: This may not be always true, we might get diffe=
rent timer */
> + =A0 =A0 =A0 sprintf(clocksource_hwmod_name, "timer%d", gptimer_id +=
 1);
> + =A0 =A0 =A0 omap_hwmod_setup_one(clocksource_hwmod_name);
>
> =A0 =A0 =A0 =A0gpt =3D omap_dm_timer_request();
> =A0 =A0 =A0 =A0if (!gpt)
>

Thanks, this appears to fix the gp timer clocksource on OMAP4:

Tested-by: Rabin Vincent <rabin@rab.in>

However, sched_clock() is broken with !CONFIG_OMAP_32K_TIMER, and it
needs the below patch in addition to yours:

8<----------

=46rom 3fa494b910cc65c31b661a0a99a9fcf207d9b795 Mon Sep 17 00:00:00 200=
1
=46rom: Rabin Vincent <rabin@rab.in>
Date: Sun, 8 May 2011 14:23:50 +0530
Subject: [PATCH] OMAP2+: use timer-gp as sched_clock when 32k timer is =
disabled

When OMAP_32K_TIMER is disabled, sched_clock() always returns zero
because it incorrectly always uses the (non-initialized) 32k timer
clocksource.  To fix this, make sched_clock() use the gp timer
clocksource when the 32k timer is disabled.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/mach-omap2/timer-gp.c   |   16 ++++++++++++++--
 arch/arm/plat-omap/counter_32k.c |    8 ++++----
 arch/arm/plat-omap/dmtimer.c     |    2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer=
-gp.c
index 3b9cf85..e783bfe 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -198,15 +198,20 @@ static void __init omap2_gp_clocksource_init(void=
)
  */
 static DEFINE_CLOCK_DATA(cd);
 static struct omap_dm_timer *gpt_clocksource;
-static cycle_t clocksource_read_cycles(struct clocksource *cs)
+static cycle_t notrace clocksource_read_cycles(struct clocksource *cs)
 {
 	return (cycle_t)omap_dm_timer_read_counter(gpt_clocksource);
 }

+static cycle_t notrace clocksource_gpt_read_dummy(struct clocksource *=
cs)
+{
+	return 0;
+}
+
 static struct clocksource clocksource_gpt =3D {
 	.name		=3D "gp timer",
 	.rating		=3D 300,
-	.read		=3D clocksource_read_cycles,
+	.read		=3D clocksource_gpt_read_dummy,
 	.mask		=3D CLOCKSOURCE_MASK(32),
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
 };
@@ -220,6 +225,12 @@ static void notrace dmtimer_update_sched_clock(voi=
d)
 	update_sched_clock(&cd, cyc, (u32)~0);
 }

+unsigned long long notrace sched_clock(void)
+{
+	u32 cyc =3D clocksource_gpt.read(&clocksource_gpt);
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
+
 /* Setup free-running counter for clocksource */
 static void __init omap2_gp_clocksource_init(void)
 {
@@ -240,6 +251,7 @@ static void __init omap2_gp_clocksource_init(void)

 	omap_dm_timer_set_load_start(gpt, 1, 0);

+	clocksource_gpt.read =3D clocksource_read_cycles;
 	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, tick_rate);

 	if (clocksource_register_hz(&clocksource_gpt, tick_rate))
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/coun=
ter_32k.c
index f7fed60..9231499 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -126,13 +126,13 @@ static inline unsigned long long notrace
_omap_32k_sched_clock(void)
 	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT)=
;
 }

-#ifndef CONFIG_OMAP_MPU_TIMER
-unsigned long long notrace sched_clock(void)
+#ifdef CONFIG_OMAP_MPU_TIMER
+unsigned long long notrace omap_32k_sched_clock(void)
 {
 	return _omap_32k_sched_clock();
 }
-#else
-unsigned long long notrace omap_32k_sched_clock(void)
+#elif defined(CONFIG_OMAP_32K_TIMER)
+unsigned long long notrace sched_clock(void)
 {
 	return _omap_32k_sched_clock();
 }
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.=
c
index ee9f6eb..0648d63 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -700,7 +700,7 @@ void omap_dm_timer_write_status(struct
omap_dm_timer *timer, unsigned int value)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);

-unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
+unsigned int notrace omap_dm_timer_read_counter(struct omap_dm_timer *=
timer)
 {
 	unsigned int l;

--=20
1.7.4.1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
