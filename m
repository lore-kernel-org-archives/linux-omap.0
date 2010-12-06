From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/6] TI816X: Update common OMAP machine specific
 sources
Date: Mon, 6 Dec 2010 08:53:09 -0800
Message-ID: <20101206165308.GB8345@atomide.com>
References: <1281546664-11477-1-git-send-email-hemantp@ti.com>
 <20100916222459.GQ29610@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03569BEEA3@dbde02.ent.ti.com>
 <20101105205943.GS9264@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0369E7C04D@dbde02.ent.ti.com>
 <20101129192927.GG17222@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0369F61ACE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46833 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab0LFQxO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 11:53:14 -0500
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0369F61ACE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi,

Sorry for the delay.

* Pedanekar, Hemant <hemantp@ti.com> [101130 17:36]:
> Tony Lindgren wrote on Tuesday, November 30, 2010 12:59 AM:
> 
> Thanks for clarifications. I have some concerns though:
> 1) I will eventually end up preceeding existing OMAP3 ckecks to have
> cpu_is_34xx() fail. Fo example, in above case, since cpu_is_omap34xx will
> be true for ti81xx (which we don't want), I need to update the code as:
> 
> 	if (cpu_is_omap24xx() || (cpu_is_omap34xx() && !cpu_is_ti816x()) {
> OR
> 	if (cpu_is_omap24xx() || (cpu_is_omap34xx() && omap_has_idlest()) {
> 
> Then proceed to have a TI816X specific handling in "else if" part with
> cpu_is_ti816x() check.

In places like that omap_has_idlest or similar should be the only test
needed to avoid having to patch all over the place to add new processors.
  
> 2) Various module base addresses part of global data are different compared to
> OMAP3/4 - e.g., .tap, .ctrl, .prm etc are different. This means I will still
> need separate global data in arch/arm/mach-omap2/common.c as present for
> OMAP3/4 and have it set up in omap2_set_globals_ti816x().

Yes that we're already handling.
 
> 3) Differences in PRCM, PLL mean we need a separate clock data files such as
> clock816x_data.c, clockdomains816x.h, powerdomains816x.h etc. In fact, future
> SoCs in 816x (or rather, 81xx) series will share the same organization and we
> will be adding to these files instead of growing omap3xxx_data.c etc. Of course,
> I see some special handling done depending upon cpu_is_ and features in
> omap3xxx_clk_init() - but will similar approach scale with TI816X which has
> completely different clock data?

Those patches should be separate patches on top of the minimal supoort
to boot to console. 
 
> Similarly, we will also need to add TI816X specific hwmods.
> 
> 4) TI816X series shares similarity with OMAP4 too - e.g., various IPs are same,
> CM module is closer to OMAP4 than OMAP3. Thus, regaring (1) above, I could use
> OMAP4 code instead of adding new "else if". Of course, again, there are above
> mentioned differences too.

We really want to use same code for the shared modules so using feature
based detection is the way to go.
 
> With all this, won't it be better if we add TI816X (or TI81XX) series to exist
> on similar lines with OMAP3/4?

It depends, to me it still sounds like it should be done based on the
features. If necessary we can initialize more things with set_globals.
 
> Please let me know your thoughts on the above. I can send v3 patch set
> incorporating your suggestion of plugging TI816X into OMAP3.    

Well let's start with the absolute minimal patches to get those
integrated.
 
> Also, the patch set submitted doesn't have complete set of files yet
> (particularly PRCM/clock code), please have a look at code hosted on Arago.
> Below is the link to mach-omap2 folder (2.6.34 at the moment)
> http://arago-project.org/git/people/?p=sriram/ti-psp-omap.git;a=tree;f=arch/arm/mach-omap2;h=7f2c48b8cb3213b3850d0b6ea242c0c53fa5d6fa;hb=refs/heads/ti816x-master

Those you might want to post also for people to look at even if
we don't know yet how we should deal with them.

Regards,

Tony
