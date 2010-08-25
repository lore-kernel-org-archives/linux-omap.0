From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/10] OMAP4: Add opp tables.
Date: Wed, 25 Aug 2010 16:24:52 -0700
Message-ID: <1282778692.11841.68.camel@localhost>
References: <1282130191-9062-1-git-send-email-thara@ti.com>
	 <1282130191-9062-11-git-send-email-thara@ti.com>
	 <87y6bu8et9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48380 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0HYXY5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 19:24:57 -0400
Received: by vws3 with SMTP id 3so1113641vws.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 16:24:56 -0700 (PDT)
In-Reply-To: <87y6bu8et9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

On Wed, 2010-08-25 at 16:15 -0700, Kevin Hilman wrote:
> Thara Gopinath <thara@ti.com> writes:
> 
> > This patch adds OPP tables for OMAP4. A new file
> > opp44xx.c has been added to keep the OMAP4 opp tables
> > and the registeration of these tables with the generic
> > opp framework.
> >
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > ---
> >  arch/arm/mach-omap2/Makefile       |    2 +-
> >  arch/arm/mach-omap2/opp44xx.h      |   26 ++++++++++++
> >  arch/arm/mach-omap2/opp44xx_data.c |   80 ++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/pm.c           |    6 ++-
> >  4 files changed, 112 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/opp44xx.h
> >  create mode 100644 arch/arm/mach-omap2/opp44xx_data.c
> >
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index d46fbec..ebe3f36 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -51,7 +51,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
> >  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
> >  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
> >  					   cpuidle34xx.o
> > -obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o
> > +obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o opp44xx_data.o
> >  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> >  obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
> >  obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
> > diff --git a/arch/arm/mach-omap2/opp44xx.h b/arch/arm/mach-omap2/opp44xx.h
> > new file mode 100644
> > index 0000000..2cae9f3
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/opp44xx.h
> 
> We don't really a new OMAP4-specific header for this.  Let's just rename
> omap3-opp.h to omap-opp.h and put both init functions there.
> 
> I'll update the pm-opp branch accordingly.

s/pm-opp/pm-cpufreq/

Actually, what I did was drop the header all together and just add the
definition to pm.c.

Kevin


