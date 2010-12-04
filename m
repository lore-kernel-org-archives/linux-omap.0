From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v2 3/6] TI816X: Update common OMAP machine specific
 sources
Date: Sat, 4 Dec 2010 05:50:12 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A00C60E@dbde02.ent.ti.com>
References: <1281546664-11477-1-git-send-email-hemantp@ti.com>
 <20100916222459.GQ29610@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03569BEEA3@dbde02.ent.ti.com>
 <20101105205943.GS9264@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0369E7C04D@dbde02.ent.ti.com>
 <20101129192927.GG17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52950 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab0LDAUU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 19:20:20 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Pedanekar, Hemant wrote on Wednesday, December 01, 2010 7:17 AM:

> Tony Lindgren wrote on Tuesday, November 30, 2010 12:59 AM:
> 
>> * Pedanekar, Hemant <hemantp@ti.com> [101129 09:07]:
>>> Tony Lindgren wrote on Saturday, November 06, 2010 2:30 AM:
>>> 
>>> Though based on Cortex A8, TI816X series has differences in PRCM, PLL,
>>> clock structure compared to OMAP3.
>>> 
>>> Many of the OMAP3 specific checks are not applicable for TI816X. For
>>> example, consider following: File -
> arch/arm/mach-omap2/omap_hwmod.c
>>> Function - _wait_target_ready()
>>> 
>>> 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>>> 		ret =
>> omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
>>> 				oh->prcm.omap2.idlest_reg_id,
>>> 				oh->prcm.omap2.idlest_idle_bit);
>>> 
>>> The above code inside cpu_is_omap34xx() check is not applicable for TI816X
>>> as there are no CM_IDELST registers.
>> 
>> OK, so places like these will need different handling, and should
>> then be based on some idlest flag that gets set during the init
>> based on cpu_is_omap24xx() || cpu_is_omap3430() || cpu_is_omap3630().
>> 
> Tony,
> 
> Thanks for clarifications. I have some concerns though:
> 1) I will eventually end up preceeding existing OMAP3 ckecks to have
> cpu_is_34xx() fail. Fo example, in above case, since
> cpu_is_omap34xx will
> be true for ti81xx (which we don't want), I need to update
> the code as:
> 
> 	if (cpu_is_omap24xx() || (cpu_is_omap34xx() &&
> !cpu_is_ti816x()) {
> OR
> 	if (cpu_is_omap24xx() || (cpu_is_omap34xx() &&
> omap_has_idlest()) {
> 
> Then proceed to have a TI816X specific handling in "else if" part with
> cpu_is_ti816x() check. 
> 
> 2) Various module base addresses part of global data are
> different compared to
> OMAP3/4 - e.g., .tap, .ctrl, .prm etc are different. This
> means I will still
> need separate global data in arch/arm/mach-omap2/common.c as
> present for
> OMAP3/4 and have it set up in omap2_set_globals_ti816x().
> 
> 3) Differences in PRCM, PLL mean we need a separate clock
> data files such as
> clock816x_data.c, clockdomains816x.h, powerdomains816x.h etc.
> In fact, future
> SoCs in 816x (or rather, 81xx) series will share the same organization and
> we will be adding to these files instead of growing
> omap3xxx_data.c etc. Of course,
> I see some special handling done depending upon cpu_is_ and
> features in
> omap3xxx_clk_init() - but will similar approach scale with
> TI816X which has
> completely different clock data?
> 
> Similarly, we will also need to add TI816X specific hwmods.
> 
> 4) TI816X series shares similarity with OMAP4 too - e.g.,
> various IPs are same,
> CM module is closer to OMAP4 than OMAP3. Thus, regaring (1)
> above, I could use
> OMAP4 code instead of adding new "else if". Of course, again,
> there are above
> mentioned differences too.
> 
> With all this, won't it be better if we add TI816X (or
> TI81XX) series to exist
> on similar lines with OMAP3/4?
> 
> Please let me know your thoughts on the above. I can send v3 patch set
> incorporating your suggestion of plugging TI816X into OMAP3.
> 
> Also, the patch set submitted doesn't have complete set of files yet
> (particularly PRCM/clock code), please have a look at code
> hosted on Arago.
> Below is the link to mach-omap2 folder (2.6.34 at the moment)
> http://arago-project.org/git/people/?p=sriram/ti-psp-omap.git;
a=tree;f=arch/arm/mach-omap2;h=>
7f2c48b8cb3213b3850d0b6ea242c0c53fa5d6fa;hb=refs/heads/ti816x-master 
> 
Tony,

Could you please provide your comments on the above?

Thanks
-
Hemant
