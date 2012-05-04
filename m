From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V5 2/3] arm:omap:am33xx: Add AM335XEVM machine support
Date: Fri, 4 May 2012 06:00:28 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1409D@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
	<1322808204-12878-3-git-send-email-hvaibhav@ti.com>
	<alpine.DEB.2.00.1205020317151.19695@utopia.booyaka.com>
	<79CD15C6BA57404B839C016229A409A83EA10A64@DBDE01.ent.ti.com>
	<20120503155717.GE5140@atomide.com>
	<79CD15C6BA57404B839C016229A409A83EA1348F@DBDE01.ent.ti.com>
 <871un1j769.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54193 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab2EDGAm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 02:00:42 -0400
In-Reply-To: <871un1j769.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

On Fri, May 04, 2012 at 02:47:34, Hilman, Kevin wrote:
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> > On Thu, May 03, 2012 at 21:27:18, Tony Lindgren wrote:
> >> Hi,
> >> 
> >> * Hiremath, Vaibhav <hvaibhav@ti.com> [120502 02:37]:
> >> > On Wed, May 02, 2012 at 14:53:24, Paul Walmsley wrote:
> >> > > Hi
> >> > > 
> >> > > On Fri, 2 Dec 2011, hvaibhav@ti.com wrote:
> >> > > 
> >> > > > From: Afzal Mohammed <afzal@ti.com>
> >> > > > 
> >> > > > This patch adds minimal support for AM335X EVM.
> >> > > > The approach taken here is to add AM335X EVM support
> >> > > > to AM3517EVM, considering the fact that with device tree
> >> > > > developement we will get rid of board-*.c.
> >> > > > 
> >> > > > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> >> > > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> >> > > > Reviewed-by: Kevin Hilman <khilman@ti.com>
> >> > > 
> >> > > I realize people may not necessarily like this, but I think that the 
> >> > > AM33xx EVM needs its own board file.  This is because it really has 
> >> > > nothing to do with the AM3517EVM.  Also, the AM3517EVM depends on 
> >> > > CONFIG_ARCH_OMAP3, but the AM33xx EVM should not: it should depend on 
> >> > > either CONFIG_ARCH_OMAPAM33XX, or CONFIG_ARCH_OMAP4.
> >> 
> >> I guess adding CONFIG_SOC_AM33XX makes sense if it does not share anything
> >> except core with omap3. And the SOC is independent of the core selected,
> >> there is no dependency between SoC and the core.
> >> 
> >> Note that we have CONFIG_ARCH_OMAP2PLUS, all the other ones should be just
> >> CONFIG_SOC_XXX. As all omap3 omap4 and am33xx are v7, there's no need to
> >> compile with different flags either.
> >>  
> >
> > What about cpu_is_omap34xx() true for am33xx? Should we follow it?
> 
> Please, no.
> 
> I've already demonstrated that that is not necessary and only leads to
> confusion and maintenance headaches.
> 

That's what I was expecting...

Probably last question where I have confusion,

Tony, seems to be against adding new ARCH_OMAPAM33XX, but which _ARCH_ we need to follow for AM33XX?
I have to choose between ARCH_OMAP3 or ARCH_OMAP4 and what should I choose 
here?

Does it make sense to follow ARCH_OMAPx but not follow cpu_is_omapxxx()?
OR
Should we create ARCH_AMXXXX, assuming that all AM devices have similar 
memory map layout, interrupt mapping, etc...
OR
Should I just add SOC_OMAPAM33XX, wherever required?


Also, there are lot of thing wrapped under ARCH_OMAP3 || ARCH_OMAP4 option, which is required for AM33XX, how should we handle this?

For example,

"arch/arm/plat-omap/include/plat/clock.h"
struct dpll_data {
#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
	<dpll related variables>
#endif
};

"arch/arm/mach-omap2/clock.c"

#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)

const struct clkops clkops_omap3_noncore_dpll_ops = {
};
const struct clkops clkops_omap3_core_dpll_ops = {
}



