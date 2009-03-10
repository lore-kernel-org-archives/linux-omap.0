From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Problems in cpuidle
Date: Tue, 10 Mar 2009 07:12:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC1855E0@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC0EDF9C@dbde02.ent.ti.com>
 <871vt7ko3z.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48091 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbZCJBmn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 21:42:43 -0400
In-Reply-To: <871vt7ko3z.fsf@trdhcp146196.ntc.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]=20
> Sent: Monday, March 09, 2009 3:36 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Problems in cpuidle
>=20
> "ext Premi, Sanjeev" <premi@ti.com> writes:
>=20
> > While working with cpuidle, I have come across these problems.
> > I am also working on the solutions, but would be good to hear more=20
> > thoughts.
> >
> > 1) The flag 'enable_dyn_sleep' is honoured only in=20
> omap3_idle_bm_check()
> >    but in the C1 state, omap3_enter_idle() is invoked directly.
> >    So, the system can transition to deeper idle state(s)
> >
> >    Same is the case with 'sleep_block'.
> >
> >    Possible Solutions:
> >      a)  Call omap3_can_sleep() in omap3_enter_idle().
> >          This makes omap3_idle_bm_check() redundant; and=20
> can be removed.
> >
> >      b)  Make single entry point for all idle states
> >          But would be an overkill for C1 state.
> >
> >      c)  Change omap3_can_sleep() to check for omap_uart_can_sleep(=
)
> >          and omap3_fclks_active() only.
> >          Move check for 'enable_dyn_sleep' and 'sleep_block' into
> >          omap3_enter_idle()
> >
> >     I believe (c) would be the most optimal.
>=20
> Selecting (c) will break traditional pm_idle. Current plan is=20
> to add one more C state (C1) which would prevent mpu/core=20
> sleep transitions. Then remove fclk_active check completely.

[sp] I meant doing the same for pm_idle as well.
     Also, the new cstate will not help with 'sleep' block.

     The proposed change look like:

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cp=
uidle34xx
index 7fc3cb3..c25158c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -82,6 +82,11 @@ static int omap3_enter_idle(struct cpuidle_device *d=
ev,
        /* Used to keep track of the total time in idle */
        getnstimeofday(&ts_preidle);

+       if (!enable_dyn_sleep)
+               goto return_sleep_time;
+       if (atomic_read(&sleep_block) > 0)
+               goto return_sleep_time;
+
        /*
         * Adjust the idle state (if required).
         * Also, ensure that usage statistics of correct state are upda=
ted.
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index 0716d60..5c7819a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -476,14 +476,10 @@ static int omap3_fclks_active(void)

 int omap3_can_sleep(void)
 {
-       if (!enable_dyn_sleep)
-               return 0;
        if (!omap_uart_can_sleep())
                return 0;
        if (omap3_fclks_active())
                return 0;
-       if (atomic_read(&sleep_block) > 0)
-               return 0;
        return 1;
 }

@@ -534,6 +530,11 @@ err:

 static void omap3_pm_idle(void)
 {
+       if (!enable_dyn_sleep)
+               return;
+       if (atomic_read(&sleep_block) > 0)
+               return;
+
        local_irq_disable();
        local_fiq_disable();

>=20
> --
> Jouni H=F6gander
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
