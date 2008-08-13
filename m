From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 00/11] OMAP3 CPUidle patches - ver 2
Date: Wed, 13 Aug 2008 11:36:07 +0530
Message-ID: <00ae01c8fd0a$ad278dd0$LocalHost@wipultra1382>
References: <00ad01c8fd09$6bcdc6c0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:47441 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbYHMGGT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 02:06:19 -0400
In-Reply-To: <00ad01c8fd09$6bcdc6c0$LocalHost@wipultra1382>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?'=22H=C3=B6gander=22_Jouni'?= <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

> 
> >  
> > Serial and gpio clock disabling and gpio_prepare/resume can 
> be removed 
> > from omap3_pm_idle because they are already done in omap_sram_idle. 
> > And if omap_serial_can_sleep is removed from 
> omap3_can_sleep it should 
> > be added to omap3_pm_idle.
> > Omap3_pm_idle can be also put behind #ifndef CONFIG_CPU_IDLE:
> > 
> > +#ifndef CONFIG_CPU_IDLE
> >  static void omap3_pm_idle(void)
> >  {
> >         local_irq_disable();
> > @@ -454,33 +455,16 @@ static void omap3_pm_idle(void)
> >         if (omap_irq_pending())
> >                 goto out;
> >  
> > -       omap2_gpio_prepare_for_retention();
> > -
> > -       if (clocks_off_while_idle) {
> > -               omap_serial_enable_clocks(0, 0);
> > -               omap_serial_enable_clocks(0, 1);
> > -               omap_serial_enable_clocks(0, 2);
> > -               /* XXX This is for gpio fclk hack. Will be 
> removed as
> > -                * gpio driver * handles fcks correctly */
> > -               per_gpio_clk_disable();
> > -       }
> > +       if (!omap_serial_can_sleep())
> > +               goto out;
> >  
> >         omap_sram_idle();
> >  
> > -       if (clocks_off_while_idle) {
> > -               omap_serial_enable_clocks(1, 0);
> > -               omap_serial_enable_clocks(1, 1);
> > -               omap_serial_enable_clocks(1, 2);
> > -               /* XXX This is for gpio fclk hack. Will be 
> removed as
> > -                * gpio driver * handles fcks correctly */
> > -               per_gpio_clk_enable();
> > -       }
> > -
> > -       omap2_gpio_resume_after_retention();
> >  out:
> >         local_fiq_enable();
> >         local_irq_enable();
> >  }
> > +#endif /* CONFIG_CPU_IDLE */
> 
> These are also done as part of the last patch in the series.
> 

Ok.. so I misunderstood your comment initially, I confused omap3_pm_idle with the 
omap3_enter_idle and thought this was already done.
Yes, these can be now removed.

