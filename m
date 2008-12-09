From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Bug in linux omap clock framework?
Date: Tue, 09 Dec 2008 15:58:06 +0200
Message-ID: <1228831086.31061.9.camel@tubuntu>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
	 <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
	 <1228726770.8668.66.camel@tubuntu>
	 <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33666 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbYLIN64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Dec 2008 08:58:56 -0500
In-Reply-To: <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

Hi,

On Mon, 2008-12-08 at 02:24 -0700, ext Paul Walmsley wrote:
> Hi Tomi,
> 
> On Mon, 8 Dec 2008, Tomi Valkeinen wrote:
> 
> > On Sat, 2008-12-06 at 16:51 -0700, ext Paul Walmsley wrote:
> > > Hi Tomi,
> > > 
> > > nice test case.
> > > 
> > > On Fri, 5 Dec 2008, Tomi.Valkeinen@nokia.com wrote:
> > > 
> > > > I have had strange clk_enable() crashes with DSS2, and now I managed to
> > > > isolate it. With the included patch, on OMAP3 SDP board, with default
> > > > kernel config, I always get the crash below. In this example case it
> > > > happens at specific time on boot, but with DSS2 it happens randomly at
> > > > runtime, when I enable the DSS clocks.
> > > 
> 
> At this point my guess would be that it is a DSS driver problem, but I 
> don't think it is clear yet.
> 

I don't know much about power and clock domains, but I believe I found
the reason and fix for this. At least this should point to the right
direction.

It looks to me that when I do clk_enable() to a clock which is inside a
turned off powerdomain, clk_enable() function will return before the
powerdomain is fully turned on. Reading PM_PWSTST_DSS shows that the
powerdomain is still in transition state.

The following change waits until the powerdomain has finished the
transition. At least it fixed the problem for me, and other things seem
to be still working =).


diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index fa62f14..f713d0b 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -567,6 +567,8 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
        else
                omap2_clkdm_wakeup(clkdm);
 
+       pwrdm_wait_transition(clkdm->pwrdm.ptr);
+
        return 0;
 }


