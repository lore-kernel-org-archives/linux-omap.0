From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH] arm: Fix build error with context tracking calls
Date: Fri, 13 Sep 2013 19:03:34 +0200
Message-ID: <20130913170331.GA8453@somewhere>
References: <20130908090206.GK25647@n2100.arm.linux.org.uk>
 <522CB0DE.2010102@roeck-us.net>
 <20130909105115.GL25647@n2100.arm.linux.org.uk>
 <522DB86A.8010207@roeck-us.net>
 <alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
 <20130909160348.GB18975@roeck-us.net>
 <20130909203141.GM25647@n2100.arm.linux.org.uk>
 <20130909210203.GC28416@roeck-us.net>
 <alpine.LFD.2.03.1309091714420.20709@syhkavp.arg>
 <87y574g1fi.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35153 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587Ab3IMRDh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Sep 2013 13:03:37 -0400
Received: by mail-wg0-f50.google.com with SMTP id f12so1417527wgh.17
        for <linux-omap@vger.kernel.org>; Fri, 13 Sep 2013 10:03:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87y574g1fi.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

On Tue, Sep 10, 2013 at 08:07:45AM -0700, Kevin Hilman wrote:
> Nicolas Pitre <nicolas.pitre@linaro.org> writes:
> 
> > Adding Kevin Hilman to the CC as he might be interested as well.
> 
> Thanks, I'd already noticed this but was distracted getting arm-soc
> changes ready for the merge window.  Looking into it now.

Kevin, can you please try this patch? It built tested fine on ARM
and live tested correctly on x86. There should be no problem but
just in case.

Thanks!

---
>From 9bb601401baea0a2b2eead3909a9f186d894d617 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Tue, 10 Sep 2013 00:54:17 +0200
Subject: [PATCH] arm: Fix build error with context tracking calls

ad65782fba50 (context_tracking: Optimize main APIs off case
with static key) converted context tracking main APIs to inline
functions and left ARM asm callers behind.

This can be easily fixed by making ARM calling the post static
keys context tracking functions. We just need to replicate the
static key checks there. We'll remove these later when ARM will
support the context tracking static keys.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Anil Kumar <anilk4.v@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/kernel/entry-header.S |    8 ++++----
 kernel/context_tracking.c      |   12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index de23a9b..39f89fb 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -329,10 +329,10 @@
 #ifdef CONFIG_CONTEXT_TRACKING
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
-	bl	user_exit
+	bl	context_tracking_user_exit
 	ldmia	sp!, {r0-r3, ip, lr}
 	.else
-	bl	user_exit
+	bl	context_tracking_user_exit
 	.endif
 #endif
 	.endm
@@ -341,10 +341,10 @@
 #ifdef CONFIG_CONTEXT_TRACKING
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
-	bl	user_enter
+	bl	context_tracking_user_enter
 	ldmia	sp!, {r0-r3, ip, lr}
 	.else
-	bl	user_enter
+	bl	context_tracking_user_enter
 	.endif
 #endif
 	.endm
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 247091b..859c8df 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -51,6 +51,15 @@ void context_tracking_user_enter(void)
 	unsigned long flags;
 
 	/*
+	 * Repeat the user_enter() check here because some archs may be calling
+	 * this from asm and if no CPU needs context tracking, they shouldn't
+	 * go further. We can remove that check here once these archs support the static key
+	 * check.
+	 */
+	if (!static_key_false(&context_tracking_enabled))
+		return;
+
+	/*
 	 * Some contexts may involve an exception occuring in an irq,
 	 * leading to that nesting:
 	 * rcu_irq_enter() rcu_user_exit() rcu_user_exit() rcu_irq_exit()
@@ -151,6 +160,9 @@ void context_tracking_user_exit(void)
 {
 	unsigned long flags;
 
+	if (!static_key_false(&context_tracking_enabled))
+		return;
+
 	if (in_interrupt())
 		return;
 
-- 
1.7.5.4

