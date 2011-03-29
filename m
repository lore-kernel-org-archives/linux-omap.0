From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [pm-core][PATCH v3 14/21] OMAP4: pm-debug: Add wakeup timer and
 debug counters
Date: Tue, 29 Mar 2011 11:20:33 +0530
Message-ID: <9c68a4d00d3c2b521336acf09c7ca2bc@mail.gmail.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
 <1301304157-2466-15-git-send-email-santosh.shilimkar@ti.com> <20110328210046.GE30616@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49041 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753081Ab1C2FxW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 01:53:22 -0400
Received: by gwb11 with SMTP id 11so1826341gwb.34
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 22:53:21 -0700 (PDT)
In-Reply-To: <20110328210046.GE30616@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, March 29, 2011 2:31 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; rnayak@ti.com;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [pm-core][PATCH v3 14/21] OMAP4: pm-debug: Add wakeup
> timer and debug counters
>
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110328 02:21]:
> > --- a/arch/arm/mach-omap2/pm-debug.c
> > +++ b/arch/arm/mach-omap2/pm-debug.c
> > @@ -40,6 +41,11 @@ static int omap4_pm_suspend(void)
> >  	int state, ret = 0;
> >  	u32 cpu_id = smp_processor_id();
> >
> > +	/* Wakeup timer from suspend */
> > +	if (wakeup_timer_seconds || wakeup_timer_milliseconds)
> > +		omap2_pm_wakeup_on_timer(wakeup_timer_seconds,
> > +					 wakeup_timer_milliseconds);
> > +
> >  	/* Save current powerdomain state */
> >  	list_for_each_entry(pwrst, &pwrst_list, node) {
> >  		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst-
> >pwrdm);
>
> This hack to mess diretly with sys_timer will be ripped out,
> so please drop this patch.
>
Ok.

> In the long run we'll have dmtimer1 dedicated to the PM code,
> so then it's possible to do similar things.
>

Regards,
Santosh
