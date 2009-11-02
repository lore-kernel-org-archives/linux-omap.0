From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] [OMAP3_PM] Fix zoom2 defconfig build
Date: Mon, 2 Nov 2009 22:00:35 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940254037B8F@dbde02.ent.ti.com>
References: <1257148563-18604-1-git-send-email-manjugk@ti.com>
	<1257150370.29885.986.camel@localhost>
	<E0D41E29EB0DAC4E9F3FF173962E9E940254037933@dbde02.ent.ti.com>
	<20091102091427.GE9446@nokia.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402540379AA@dbde02.ent.ti.com>
 <87k4y8lxhg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46691 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755902AbZKBQam convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 11:30:42 -0500
In-Reply-To: <87k4y8lxhg.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> > diff --git a/arch/arm/mach-omap2/pm-debug.c 
> b/arch/arm/mach-omap2/pm-debug.c
> > index 767ebbc..3a42615 100644
> > --- a/arch/arm/mach-omap2/pm-debug.c
> > +++ b/arch/arm/mach-omap2/pm-debug.c
> > @@ -625,4 +625,6 @@ arch_initcall(pm_dbg_init);
> >
> >  #else
> >  void pm_dbg_update_time(struct powerdomain *pwrdm, int prev) {}
> > +int pm_dbg_regset_init(int reg_set) {}
> > +int pm_dbg_regset_save(int reg_set) {}
> 
> you'll get compiler warnings from these.

Can be changed to return with value zero for these API's.

> 
> >  #endif
> 
> but even there, this should be fixed in pm.h.  The current PM branch
> has these defines already:
> 
> #define pm_dbg_regset_save(reg_set) do {} while (0);
> #define pm_dbg_regset_init(reg_set) do {} while (0);
> 
> It would be cleaner to fix the #ifdef there to handle the
> !CONFIG_DEBUG_FS case.

pm branch has else condition for CONFIG_PM_DEBUG. But, CONFIG_DEBUG_FS
is not handled. As there is already similar API -  pm_dbg_update_time in
pm_debug.c, these API's can also fit there. More over, using !CONFIG_DEBUG_FS
will add some #ifdef's in header.

-Manjunath