From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 07/15] ARM: OMAP5: Add init_late() hook to enable pm
 initialization
Date: Mon, 4 Mar 2013 12:35:48 -0600
Message-ID: <20130304183548.GA14958@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-8-git-send-email-santosh.shilimkar@ti.com>
 <20130301201235.GC22626@kahuna>
 <5131956C.5060602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37752 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758566Ab3CDSfw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 13:35:52 -0500
Content-Disposition: inline
In-Reply-To: <5131956C.5060602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 11:30-20130302, Santosh Shilimkar wrote:
> On Saturday 02 March 2013 01:42 AM, Nishanth Menon wrote:
> > On 17:40-20130301, Santosh Shilimkar wrote:
> >> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> >> index 2c3fdd6..e6ba596 100644
> >> --- a/arch/arm/mach-omap2/io.c
> >> +++ b/arch/arm/mach-omap2/io.c
> >> @@ -620,6 +620,14 @@ void __init omap5_init_early(void)
> >>  	omap_cm_base_init();
> >>  	omap5xxx_check_revision();
> >>  }
> >> +
> >> +void __init omap5_init_late(void)
> >> +{
> >> +	omap_mux_late_init();
> >> +	omap2_common_pm_late_init();
> >> +	omap4_pm_init();
> > as part of init sequence, we'd late_initcall *after* module_inits,
> > implying probes of drivers will be called (for built-in drivers) prior
> > to PM getting ready.
> > 
> > This basically makes key features like dvfs not available for drivers until
> > late_init is complete.
> > 
> > We have faced tons of problems in the past with this approach, cant we
> > improve this? One solution(we used in Android kernel fork) might be to
> > ensure all core framework initialized before module_init either in
> > arch_init or subsys_init. I am aware that machine_desc does not provide us
> > that flexibility - should'nt we rather extend it for the same instead of
> > having to go through the same pain all over again?
> > 
> I have seen those tons of internal patches as well :)
> The point is, there is nothing at the moment in mainline code breaks
> with this init sequence so it just fine.
> 
> You might have valid point but it is more of generic init sequence
> for all PM code. Since you are aware of all the needs, I suggest
> you to address that in another series so that all devices gets
> addressed. Looking at current mainline supported code and the scope
> of PM, I suspect there is any issue.
:( Sigh.. We will eventually need to fix this up (aka will need tons of
patches eventually). But this patch is inline with the existing usage,
so no complaints on this one.
-- 
Regards,
Nishanth Menon
