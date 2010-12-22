From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Re: Fix pm24xx.c compilation  problem
Date: Thu, 23 Dec 2010 11:53:22 +1300
Message-ID: <201012231153.22311.manningc2@actrix.gen.nz>
References: <201012230919.26344.manningc2@actrix.gen.nz> <87zkrxo3bh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:41394 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751937Ab0LVWxZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Dec 2010 17:53:25 -0500
In-Reply-To: <87zkrxo3bh.fsf@deeprootsystems.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Thursday 23 December 2010 11:22:42 Kevin Hilman wrote:
> Charles Manning <manningc2@actrix.gen.nz> writes:
> > arch/arm/mach-omap2/pm24xx.c doesn't compile without CONFIG_SUSPEND
> >
> > diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> > index aaeea49..ae6abda 100644
> > --- a/arch/arm/mach-omap2/pm24xx.c
> > +++ b/arch/arm/mach-omap2/pm24xx.c
> > @@ -53,8 +53,8 @@
> >  #include <plat/powerdomain.h>
> >  #include <plat/clockdomain.h>
> >
> > -#ifdef CONFIG_SUSPEND
> >  static suspend_state_t suspend_state = PM_SUSPEND_ON;
> > +#ifdef CONFIG_SUSPEND
> >  static inline bool is_suspending(void)
> >  {
> >         return (suspend_state != PM_SUSPEND_ON);
> > @@ -314,6 +314,7 @@ static int omap2_pm_prepare(void)
> >
> >  static int omap2_pm_suspend(void)
> >  {
> > +#ifdef CONFIG_SUSPEND
> >         u32 wken_wkup, mir1;
> >
> >         wken_wkup = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> > @@ -329,7 +330,7 @@ static int omap2_pm_suspend(void)
> >
> >         omap_writel(mir1, 0x480fe0a4);
> >         prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
> > -
> > +#endif
> >         return 0;
> >  }
>
> Indeed a bug, but not quite the right fix.
>
> Like we do on OMAP3, all of the _begin, _enter, _suspend, and _end
> fucntions can actually be left out when !CONFIG_SUSPEND.
>
> Will send patch shortly.
>
> Thanks for reporting this and proposing a fix.

I should have been clearer. I did not really propose this as a fix.
I really just as a way to get over the compilation hump and alert someone who 
can fix it properly.

Thanks

-- Charles

