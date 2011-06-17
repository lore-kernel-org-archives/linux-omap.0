From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 18/18] GPIO: OMAP2+: Clean prepare_for_idle and
 resume_after_idle
Date: Fri, 17 Jun 2011 10:27:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC54B@dbde02.ent.ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-9-git-send-email-tarun.kanti@ti.com>
 <87ips5lkal.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53925 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098Ab1FQE5w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 00:57:52 -0400
In-Reply-To: <87ips5lkal.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

[...]
> 
> > Simplify  omap2_gpio_prepare_for_idle() and
> omap2_gpio_resume_after_idle()
> > by moving most of the stuff to *_pm_runtime_suspend() and
> *_pm_runtime_resume().
> > Also, omap_gpio_suspend() and omap_gpio_resume() optimized to operate
> per
> > GPIO bank instead of operating on entire list every time.
> 
> This second part should be a separate patch.
OK.

> 
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Charulatha V <charu@ti.com>
> 
> [...]
> 
> >
> > +#ifdef CONFIG_ARCH_OMAP2PLUS
> > +static void omap_gpio_save_context(struct gpio_bank *bank);
> > +static void omap_gpio_restore_context(struct gpio_bank *bank);
> > +#endif
> > +
> >  static int omap_gpio_pm_runtime_suspend(struct device *dev)
> >  {
> > +#ifdef CONFIG_ARCH_OMAP2PLUS
> 
> c.f. #ifdefs are ugly in Documentation/SubmittingPatches
> 
> Just wrap all of these funcions: runtime PM, save/restore context,
> prepare/resume from idle inside the #ifdef.  Then have an else
> clause with NULL versions of the runtime PM functions.
OK.
--
Tarun

> 
> Kevin
