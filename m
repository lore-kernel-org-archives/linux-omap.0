From: Tero Kristo <t-kristo@ti.com>
Subject: RE: [PATCHv4 3/8] ARM: OMAP3+: voltage: add support for
 voltagedomain usecounts
Date: Wed, 25 Jul 2012 11:07:50 +0300
Message-ID: <1343203670.30247.79.camel@sokoban>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
	 <1342189185-5306-4-git-send-email-t-kristo@ti.com>
	 <6cfa1276727a03e26caea893ced86b92@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53395 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756204Ab2GYIIE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 04:08:04 -0400
In-Reply-To: <6cfa1276727a03e26caea893ced86b92@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org

On Tue, 2012-07-24 at 15:58 -0500, Vishwanath Sripathy wrote:
> Tero,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tero Kristo
> > Sent: Friday, July 13, 2012 9:20 AM
> > To: linux-omap@vger.kernel.org; paul@pwsan.com; khilman@ti.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Subject: [PATCHv4 3/8] ARM: OMAP3+: voltage: add support for
> > voltagedomain usecounts
> >
> > These are updated based on powerdomain usecounts. Also added support
> > for voltdm->sleep and voltdm->wakeup calls that will be invoked once
> > voltagedomain enters sleep or wakes up based on usecount numbers.
> > These
> > will be used for controlling voltage scaling functionality.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > ---
> >  arch/arm/mach-omap2/powerdomain.c |    6 +++-
> >  arch/arm/mach-omap2/voltage.c     |   56
> > +++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/voltage.h     |   11 +++++++
> >  3 files changed, 72 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-
> > omap2/powerdomain.c
> > index 68bdf36..3b4b15d 100644
> > --- a/arch/arm/mach-omap2/powerdomain.c
> > +++ b/arch/arm/mach-omap2/powerdomain.c
> > @@ -994,7 +994,8 @@ void pwrdm_clkdm_enable(struct powerdomain
> > *pwrdm)
> >  	if (!pwrdm)
> >  		return;
> >
> > -	atomic_inc(&pwrdm->usecount);
> > +	if (atomic_inc_return(&pwrdm->usecount) == 1)
> > +		voltdm_pwrdm_enable(pwrdm->voltdm.ptr);
> >  }
> >
> >  /**
> > @@ -1013,6 +1014,9 @@ void pwrdm_clkdm_disable(struct powerdomain
> > *pwrdm)
> >
> >  	val = atomic_dec_return(&pwrdm->usecount);
> >
> > +	if (!val)
> > +		voltdm_pwrdm_disable(pwrdm->voltdm.ptr);
> > +
> >  	BUG_ON(val < 0);
> >  }
> >
> > diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
> > omap2/voltage.c
> > index 4dc60e8..8c6439b 100644
> > --- a/arch/arm/mach-omap2/voltage.c
> > +++ b/arch/arm/mach-omap2/voltage.c
> > @@ -38,6 +38,7 @@
> >
> >  #include "voltage.h"
> >  #include "powerdomain.h"
> > +#include "smartreflex.h"
> >
> >  #include "vc.h"
> >  #include "vp.h"
> > @@ -340,6 +341,61 @@ int voltdm_add_pwrdm(struct voltagedomain
> > *voltdm, struct powerdomain *pwrdm)
> >  }
> >
> >  /**
> > + * voltdm_pwrdm_enable - increase usecount for a voltagedomain
> > + * @voltdm: struct voltagedomain * to increase count for
> > + *
> > + * Increases usecount for a given voltagedomain. If the usecount
> > reaches
> > + * 1, the domain is awakened from idle and the function will call
> > the
> > + * voltagedomain->wakeup callback for this domain.
> > + */
> > +void voltdm_pwrdm_enable(struct voltagedomain *voltdm)
> > +{
> > +	if (!voltdm)
> > +		return;
> > +
> > +	if (atomic_inc_return(&voltdm->usecount) == 1) {
> > +		if (voltdm->wakeup)
> > +			voltdm->wakeup(voltdm);
> > +	}
> > +}
> I think these usecounting functions are prone to race conditions and need
> to be protected using spin_lock or something like that (not just the
> usecounter). Otherwise right sequence will not be followed when multiple
> modules try to idle and enable simultaneously. You can see this issue when
> 2 cpus enter idle independently.

Yes, you are right... something like this needs to be added for SMP once
individual cpuidle is in place. I'll add this kind of fix for the next
version.

-Tero


