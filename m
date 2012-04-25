From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 08/19] ARM: OMAP4: PM: Add device-off support
Date: Wed, 25 Apr 2012 10:30:15 +0300
Message-ID: <1335339015.2149.106.camel@sokoban>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
	 <1334914432-26456-9-git-send-email-t-kristo@ti.com>
	 <4F96E70C.4040008@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60649 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab2DYHaU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 03:30:20 -0400
In-Reply-To: <4F96E70C.4040008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On Tue, 2012-04-24 at 12:46 -0500, Jon Hunter wrote:
> Hi Tero,
> 
> On 04/20/2012 04:33 AM, Tero Kristo wrote:
> > This patch adds device off support to OMAP4 device type.
> > 
> > OFF mode is disabled by default, however, there are two ways to enable
> > OFF mode:
> > a) In the board file, call omap4_pm_off_mode_enable(1)
> > b) Enable OFF mode using the debugfs entry
> > echo "1">/sys/kernel/debug/pm_debug/enable_off_mode
> > (conversely echo '0' will disable it as well).
> > 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > [t-kristo@ti.com: largely re-structured the code]
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   24 ++++++++++-
> >  arch/arm/mach-omap2/omap-wakeupgen.c      |   47 +++++++++++++++++++-
> >  arch/arm/mach-omap2/pm-debug.c            |   17 +++++--
> >  arch/arm/mach-omap2/pm.h                  |   28 ++++++++++--
> >  arch/arm/mach-omap2/pm44xx.c              |   45 +++++++++++++++++++
> >  arch/arm/mach-omap2/prm44xx.c             |   66 +++++++++++++++++++++++++++++
> >  6 files changed, 214 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> > index e02c082..b9a2cc7 100644
> > --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> > +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> > @@ -60,6 +60,7 @@
> >  #include "prcm44xx.h"
> >  #include "prm44xx.h"
> >  #include "prm-regbits-44xx.h"
> > +#include "cm44xx.h"
> >  
> >  #ifdef CONFIG_SMP
> >  
> > @@ -232,6 +233,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
> >  {
> >  	unsigned int save_state = 0;
> >  	unsigned int wakeup_cpu;
> > +	int ret;
> >  
> >  	if (omap_rev() == OMAP4430_REV_ES1_0)
> >  		return -ENXIO;
> > @@ -263,9 +265,21 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
> >  	 * In MPUSS OSWR or device OFF, interrupt controller  contest is lost.
> >  	 */
> >  	mpuss_clear_prev_logic_pwrst();
> > -	if ((pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_RET) &&
> > -		(pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
> > +	if (omap4_device_next_state_off()) {
> > +		/* Save the device context to SAR RAM */
> > +		ret = omap_sar_save();
> > +		if (ret)
> > +			return ret;
> 
> Is it safe to simply return here? I was not sure if we need to call
> pwrdm_post_transition, given that we have already called
> pwrdm_pre_transition on entry.

Hmm, thats a good point, I'll change the patch slightly. Anyway,
currently the potential solo pwrdm_pre_transition() will not break
anything, but in future it would, as we are planning to control AUTO_RET
feature through the pwrdm_pre / pwrdm_post calls.

-Tero

