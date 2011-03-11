From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 00/19] OMAP4: PM: Suspend,CPU-hotplug and CPUilde support.
Date: Fri, 11 Mar 2011 22:56:41 +0530
Message-ID: <f1ee9adb49c6dbc49205c5ba70007e9a@mail.gmail.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com><87d3lycu0h.fsf@ti.com><3b3d5e28815aa8bcedf6f43688f403b5@mail.gmail.com>
 <871v2dd58y.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41704 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751041Ab1CKR0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 12:26:46 -0500
Received: by mail-qy0-f171.google.com with SMTP id 19so6309413qyj.16
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 09:26:44 -0800 (PST)
In-Reply-To: <871v2dd58y.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Kevin,

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-
> arm-kernel-bounces@lists.infradead.org] On Behalf Of Kevin Hilman
> Sent: Friday, March 11, 2011 9:22 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Rajendra Nayak
> Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend,CPU-hotplug and
> CPUilde support.
>

[....]

> >
> > So just to summaries, on OMAP$ 'enable_off_mode' flag is
> > used __only__ in Suspend. CPUx power domain always hit OFF
> > mode no matter what is state of this flag because CSWR isn't
> > supported on these PD's.
>
> If it's useful only in suspend, then it's redundant with the
> <debugfs>/pm_debug/*_pwrdm/suspend controls which allow per-pwrdm
> control over next states.
>
> > We could remove this flag as well but thought that this might be
> > useful especially when we add CORE RET, DEVICE OFF support.
>
> I'd rather see working off-mode be a requirement for getting OMAP4
> drivers supported.
>
> Also, we can still test suspend/resume with off-mode disabled by
> using the above debugfs controls.
>
> > May be we keep this till the constraint frameworks comes in and
> > then drop it once for all. I am ok with whatever direction you
> > decide here.
>
> I prefer to drop it completely for OMAP4.
>
OK. Lets do that.

Just to not miss your point here, what I understood here
is default suspend state on OMAP$B will be off mode.

We still keep "enable_off_mode" flag for testing so that we
can disable off mode to debug regressions.

Is that right?
If yes then only below update is needed.

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 2e18c1d..1a8cbdd 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -167,7 +167,7 @@ static int __init pwrdms_setup(struct powerdomain
*pwrdm, void *unused)
 		return -ENOMEM;

 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+	pwrst->next_state = PWRDM_POWER_OFF;
 	list_add(&pwrst->node, &pwrst_list);

 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
@@ -253,6 +253,8 @@ static int __init omap4_pm_init(void)
 		pr_err("Failed to initialise OMAP4 MPUSS\n");
 		goto err2;
 	}
+	
+	enable_off_mode = 1;
 #endif

 #ifdef CONFIG_SUSPEND
