From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: RE: [PATCH] ARM: OMAP4 clock domain: Add check for avoiding
 dependency related update.
Date: Thu, 11 Feb 2010 10:32:11 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0CD3DDD@dbde02.ent.ti.com>
References: <1265789523-6413-1-git-send-email-abhijitpagare@ti.com>
 <alpine.DEB.2.00.1002101711170.28188@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34420 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710Ab0BKFCZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 00:02:25 -0500
In-Reply-To: <alpine.DEB.2.00.1002101711170.28188@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Paul,

>-----Original Message-----
>From: Paul Walmsley [mailto:paul@pwsan.com]
>Sent: Thursday, February 11, 2010 5:44 AM
>To: Pagare, Abhijit
>Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>Subject: Re: [PATCH] ARM: OMAP4 clock domain: Add check for avoiding
>dependency related update.
>
>Hi Abhijit,
>
>On Wed, 10 Feb 2010, Abhijit Pagare wrote:
>
>> A check is added for avoiding the sleep/wakeup dependency updates
>> for OMAP4 as the structures for the dependencies are currently absen=
t.
>>
>> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>
>Thanks, I've made the following changes to the patch to try to ensure =
that
>this doesn't slip through the cracks, and queued it for 2.6.34.  If yo=
u
>have any comments on the revised patch, please let me know.

Looks neat. Thanks.

-Abhijit

>
>
>- Paul
>
>From: Abhijit Pagare <abhijitpagare@ti.com>
>Date: Wed, 10 Feb 2010 13:42:03 +0530
>Subject: [PATCH] ARM: OMAP4 clock domain: Add check for avoiding depen=
dency
>related update.
>
>A check is added for avoiding the sleep/wakeup dependency updates
>for OMAP4 as the structures for the dependencies are currently absent.
>
>Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
>[paul@pwsan.com: added warnings, explanatory comment, copyright update=
]
>Signed-off-by: Paul Walmsley <paul@pwsan.com>
>---
> arch/arm/mach-omap2/clockdomain.c |   30 ++++++++++++++++++++++++----=
--
> 1 files changed, 24 insertions(+), 6 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-
>omap2/clockdomain.c
>index a38a615..de4278c 100644
>--- a/arch/arm/mach-omap2/clockdomain.c
>+++ b/arch/arm/mach-omap2/clockdomain.c
>@@ -1,8 +1,8 @@
> /*
>  * OMAP2/3/4 clockdomain framework functions
>  *
>- * Copyright (C) 2008-2009 Texas Instruments, Inc.
>- * Copyright (C) 2008-2009 Nokia Corporation
>+ * Copyright (C) 2008-2010 Texas Instruments, Inc.
>+ * Copyright (C) 2008-2010 Nokia Corporation
>  *
>  * Written by Paul Walmsley and Jouni H=F6gander
>  * Added OMAP4 specific support by Abhijit Pagare <abhijitpagare@ti.c=
om>
>@@ -891,8 +891,17 @@ void omap2_clkdm_allow_idle(struct clockdomain *c=
lkdm)
> 	pr_debug("clockdomain: enabling automatic idle transitions for %s\n"=
,
> 		 clkdm->name);
>
>-	if (atomic_read(&clkdm->usecount) > 0)
>-		_clkdm_add_autodeps(clkdm);
>+	/*
>+	 * XXX This should be removed once TI adds wakeup/sleep
>+	 * dependency code and data for OMAP4.
>+	 */
>+	if (cpu_is_omap44xx()) {
>+		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
>+			  "support is not yet implemented\n");
>+	} else {
>+		if (atomic_read(&clkdm->usecount) > 0)
>+			_clkdm_add_autodeps(clkdm);
>+	}
>
> 	_omap2_clkdm_set_hwsup(clkdm, 1);
>
>@@ -924,8 +933,17 @@ void omap2_clkdm_deny_idle(struct clockdomain *cl=
kdm)
>
> 	_omap2_clkdm_set_hwsup(clkdm, 0);
>
>-	if (atomic_read(&clkdm->usecount) > 0)
>-		_clkdm_del_autodeps(clkdm);
>+	/*
>+	 * XXX This should be removed once TI adds wakeup/sleep
>+	 * dependency code and data for OMAP4.
>+	 */
>+	if (cpu_is_omap44xx()) {
>+		WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
>+			  "support is not yet implemented\n");
>+	} else {
>+		if (atomic_read(&clkdm->usecount) > 0)
>+			_clkdm_del_autodeps(clkdm);
>+	}
> }
>
>
>--
>1.6.6.GIT
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
