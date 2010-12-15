From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 1/5] OMAP4: PM: Use the lowpwrstatechange feature on OMAP4
Date: Wed, 15 Dec 2010 20:47:52 +0530
Message-ID: <c454400af490d75c274f19a5d0a5a655@mail.gmail.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com><1292276969-29733-2-git-send-email-b-cousson@ti.com>
 <87zks8rv3b.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47004 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754450Ab0LOPRz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 10:17:55 -0500
Received: by mail-qw0-f47.google.com with SMTP id 5so1810972qwg.6
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 07:17:54 -0800 (PST)
In-Reply-To: <87zks8rv3b.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Kevin,

<snip>..

> >  	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
> > +		if ((pwrdm_read_pwrst(pwrdm) > state) &&
> > +			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
> > +				ret = pwrdm_set_next_pwrst(pwrdm, state);
> > +				pwrdm_set_lowpwrstchange(pwrdm);
> > +				pwrdm_wait_transition(pwrdm);
> > +				pwrdm_state_switch(pwrdm);
> > +				return ret;
>
> Personally, I'd prefer if this function flowed through better instead of
> the early return in order to emphasize the common code.
>
> Rather than the return here, can you just set the low-power state change
> bit here (and put the clkdm_wakeup + sleep_switch = 1 into the else
> clause?
>
> Or, does the next state have to be set before the low-power state change
> bit?

Yes, that sequencing is needed.

>
> Basically, what I'm getting at is this should be a single function with
> common flow.  The conditional code based on low-power state change
> should be isolated instead of having a special path.

I get your point. See if the below approach looks better.
If it looks fine, I'll do some more testing (currently only tested
on OMAP4430sdp) and repost the 2 patches.

>From 5d206ba908071edafae6c044bd3ef6ad8a9c32e7 Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Thu, 25 Nov 2010 14:26:51 +0530
Subject: [PATCH 1/5] OMAP4: PM: Use the low-power state change feature on
OMAP4

For pwrdm's which support LOWPOWERSTATECHANGE, do not try waking
up the domain to put it back to deeper sleep state.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/pm.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

Index: linux/arch/arm/mach-omap2/pm.c
===================================================================
--- linux.orig/arch/arm/mach-omap2/pm.c	2010-12-15 17:29:42.361228780
+0530
+++ linux/arch/arm/mach-omap2/pm.c	2010-12-15 20:19:48.321228780
+0530
@@ -89,6 +89,10 @@
 	}
 }

+/* Types of sleep_switch used in omap_set_pwrdm_state */
+#define FORCEWAKEUP_SWITCH	0
+#define LOWPOWERSTATE_SWITCH	1
+
 /*
  * This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported. Function is assuming that clkdm doesn't have
@@ -114,9 +118,14 @@
 		return ret;

 	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
-		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
-		sleep_switch = 1;
-		pwrdm_wait_transition(pwrdm);
+		if ((pwrdm_read_pwrst(pwrdm) > state) &&
+			(pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE)) {
+			sleep_switch = LOWPOWERSTATE_SWITCH;
+		} else {
+			omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+			pwrdm_wait_transition(pwrdm);
+			sleep_switch = FORCEWAKEUP_SWITCH;
+		}
 	}

 	ret = pwrdm_set_next_pwrst(pwrdm, state);
@@ -126,12 +135,19 @@
 		goto err;
 	}

-	if (sleep_switch) {
+	switch (sleep_switch) {
+	case FORCEWAKEUP_SWITCH:
 		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
-		pwrdm_wait_transition(pwrdm);
-		pwrdm_state_switch(pwrdm);
+		break;
+	case LOWPOWERSTATE_SWITCH:
+		pwrdm_set_lowpwrstchange(pwrdm);
+		break;
+	default:
+		return ret;
 	}

+	pwrdm_wait_transition(pwrdm);
+	pwrdm_state_switch(pwrdm);
 err:
 	return ret;
 }


>
> Kevin
>
> > +		}
> >  		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
> >  		sleep_switch = 1;
> >  		pwrdm_wait_transition(pwrdm);
