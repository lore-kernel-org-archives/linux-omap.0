From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv7 08/12] ARM: OMAP4430: PM: Work-around for ROM code
 BUG of PER pwrst ctrl
Date: Fri, 20 Jul 2012 12:20:15 +0300
Message-ID: <1342776015.4672.188.camel@sokoban>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
	 <1342704392-23657-9-git-send-email-t-kristo@ti.com>
	 <alpine.DEB.2.00.1207191717220.14390@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39524 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791Ab2GTJUp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 05:20:45 -0400
In-Reply-To: <alpine.DEB.2.00.1207191717220.14390@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 2012-07-19 at 17:21 -0600, Paul Walmsley wrote:
> Hi
> 
> On Thu, 19 Jul 2012, Tero Kristo wrote:
> 
> > On OMAP4430 HS / EMU chips, ROM code appears to re-configure L4PER domain
> > next powerstate during wakeup from OSWR / OFF, programming it to ON.
> > This will prevent successive entries to cpuidle retention / off, until
> > kernel decices to change the L4PER target state, which can be delayed
> > for a very long time as kernel is lazy programming the target state.
> > 
> > This patch fixes the issue within the low power OSWR / OFF mode code, so
> > that this register is saved / restored across MPU OSWR / OFF state.
> > 
> > This problem seems to only occur with OMAP4430 HS/EMU, it does not impact
> > OMAP4460+ or GP devices.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   39 ++++++++++++++++++++++++++++-
> >  arch/arm/mach-omap2/pm.h                  |    1 +
> >  arch/arm/mach-omap2/pm44xx.c              |   10 +++++++
> >  3 files changed, 49 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> > index 0e5f81b..963a61b 100644
> > --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> > +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> 
> ...
> 
> > @@ -215,6 +225,28 @@ static void save_l2x0_context(void)
> >  {}
> >  #endif
> >  
> > +static inline void save_l4per_regs(void)
> > +{
> > +	int i;
> > +
> > +	if (!IS_PM44XX_ERRATUM(PM_OMAP4_ROM_L4PER_ERRATUM_PWSTCT))
> > +		return;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(l4per_reg); i++)
> > +		l4per_reg[i].val = __raw_readl(l4per_reg[i].addr);
> 
> This is accessing the system PRM registers directly.  We're trying to 
> remove these raw register accesses from non-PRM code because a PRM driver 
> is in the works.  Please move this to prm44xx.c or prminst44xx.c and 
> implement a higher-level interface that omap-mpuss-lowpower.c can call.

Ok, will figure out something for next rev.

-Tero


