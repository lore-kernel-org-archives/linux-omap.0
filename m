From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH/RFT 1/3] ARM: OMAP2+: powerdomain: allow pre/post
 transtion to be per pwrdm
Date: Wed, 25 Apr 2012 14:14:13 +0530
Message-ID: <CAMQu2gxat-QuEeX4Gg_CQ64exGeh-bjiJQqQ1PF14bCNyvnRLw@mail.gmail.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com> <1335277420-29124-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34280 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752419Ab2DYIof convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 04:44:35 -0400
Received: by qcsp15 with SMTP id p15so1507761qcs.16
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 01:44:34 -0700 (PDT)
In-Reply-To: <1335277420-29124-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Apr 24, 2012 at 7:53 PM, Kevin Hilman <khilman@ti.com> wrote:
> Iteration over all power domains in the idle path is unnecessary sinc=
e
> only power domains that are transitioning need to be accounted for.
> Also PRCM register accesses are known to be expensive, so the
> additional latency added to the idle path is signficiant.
>
> In order allow the pre/post transitions to be isolated and called
> per-pwrdm, change the API so passing in a specific power domain will
> trigger the pre/post transtion accounting for only that specific powe=
r
> domain. =A0Passing NULL means iterating over all power domains as is
> current behavior.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap-mpuss-lowpower.c | =A0 =A04 ++--
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04=
 ++--
> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 | =A0 16 +++++++=
+++++----
> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 | =A0 =A04 ++--
> =A04 files changed, 18 insertions(+), 10 deletions(-)
>
[...]

> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index 96ad3dbe..0baf8c3 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -991,15 +991,23 @@ int pwrdm_clkdm_state_switch(struct clockdomain=
 *clkdm)
> =A0 =A0 =A0 =A0return -EINVAL;
> =A0}
>
> -int pwrdm_pre_transition(void)
> +int pwrdm_pre_transition(struct powerdomain *pwrdm)
> =A0{
> - =A0 =A0 =A0 pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
> + =A0 =A0 =A0 if (pwrdm)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _pwrdm_pre_transition_cb(pwrdm, NULL);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each(_pwrdm_pre_transition_cb=
, NULL);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
Minor nit. Noticed couple of whitespace errors in the patch.

-------
ERROR: trailing whitespace
#82: FILE: arch/arm/mach-omap2/powerdomain.c:996:
+^Iif (pwrdm) $

ERROR: trailing whitespace
#84: FILE: arch/arm/mach-omap2/powerdomain.c:998:
+^Ielse $

total: 2 errors, 0 warnings, 69 lines checked
-------

Updated patch below with that fixed.

Regards
Santosh

=46rom 2782503adcf91142d2aee4bafe29989095ece3ba Mon Sep 17 00:00:00 200=
1
=46rom: Kevin Hilman <khilman@ti.com>
Date: Wed, 25 Apr 2012 14:05:21 +0530
Subject: [PATCH 1/1] ARM: OMAP2+: powerdomain: allow pre/post transtion=
 to be
 per pwrdm

Iteration over all power domains in the idle path is unnecessary since
only power domains that are transitioning need to be accounted for.
Also PRCM register accesses are known to be expensive, so the
additional latency added to the idle path is signficiant.

In order allow the pre/post transitions to be isolated and called
per-pwrdm, change the API so passing in a specific power domain will
trigger the pre/post transtion accounting for only that specific power
domain.  Passing NULL means iterating over all power domains as is
current behavior.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 ++--
 arch/arm/mach-omap2/pm34xx.c              |    4 ++--
 arch/arm/mach-omap2/powerdomain.c         |   16 ++++++++++++----
 arch/arm/mach-omap2/powerdomain.h         |    4 ++--
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 13670aa..e35a86b 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -255,7 +255,7 @@ int omap4_enter_lowpower(unsigned int cpu,
unsigned int power_state)
 		return -ENXIO;
 	}

-	pwrdm_pre_transition();
+	pwrdm_pre_transition(NULL);

 	/*
 	 * Check MPUSS next state and save interrupt controller if needed.
@@ -287,7 +287,7 @@ int omap4_enter_lowpower(unsigned int cpu,
unsigned int power_state)
 	wakeup_cpu =3D smp_processor_id();
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);

-	pwrdm_post_transition();
+	pwrdm_post_transition(NULL);

 	return 0;
 }
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index 703bd10..2451b90 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -307,7 +307,7 @@ void omap_sram_idle(void)
 			omap3_enable_io_chain();
 	}

-	pwrdm_pre_transition();
+	pwrdm_pre_transition(NULL);

 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
@@ -372,7 +372,7 @@ void omap_sram_idle(void)
 	}
 	omap3_intc_resume_idle();

-	pwrdm_post_transition();
+	pwrdm_post_transition(NULL);

 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
diff --git a/arch/arm/mach-omap2/powerdomain.c
b/arch/arm/mach-omap2/powerdomain.c
index 96ad3dbe..bb6780d 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -991,15 +991,23 @@ int pwrdm_clkdm_state_switch(struct clockdomain *=
clkdm)
 	return -EINVAL;
 }

-int pwrdm_pre_transition(void)
+int pwrdm_pre_transition(struct powerdomain *pwrdm)
 {
-	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
+	if (pwrdm)
+		_pwrdm_pre_transition_cb(pwrdm, NULL);
+	else
+		pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
+
 	return 0;
 }

-int pwrdm_post_transition(void)
+int pwrdm_post_transition(struct powerdomain *pwrdm)
 {
-	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
+	if (pwrdm)
+		_pwrdm_post_transition_cb(pwrdm, NULL);
+	else
+		pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
+
 	return 0;
 }

diff --git a/arch/arm/mach-omap2/powerdomain.h
b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..a468de4 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -214,8 +214,8 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm=
);

 int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
-int pwrdm_pre_transition(void);
-int pwrdm_post_transition(void);
+int pwrdm_pre_transition(struct powerdomain *pwrdm);
+int pwrdm_post_transition(struct powerdomain *pwrdm);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
--=20
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
