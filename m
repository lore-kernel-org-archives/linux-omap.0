From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Issue with _are_all_hardreset_lines_asserted()
Date: Tue, 9 Oct 2012 08:38:04 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB39962@DBDE01.ent.ti.com>
References: <506D8C0E.8010600@ti.com>
 <alpine.DEB.2.00.1210090503470.5736@utopia.booyaka.com>
 <5073C797.1010100@ti.com>
 <alpine.DEB.2.00.1210090658200.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37005 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab2JIIiS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 04:38:18 -0400
In-Reply-To: <alpine.DEB.2.00.1210090658200.5736@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Taneja, Archit" <archit@ti.com>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

On Tue, Oct 09, 2012 at 12:29:53, Paul Walmsley wrote:
> On Tue, 9 Oct 2012, Archit Taneja wrote:
> 
> > The patch looks fine to me. I tried it out for DSS(with an additional patch to
> > not represent DSS modulemode bits as a slave clock), and modulemode is getting
> > disabled correctly now.
> 
> Thanks, I added your Tested-by: and also updated the patch description 
> which was a little unclear.
> 
> 
> - Paul
> 
> From: Paul Walmsley <paul@pwsan.com>
> Date: Mon, 8 Oct 2012 23:08:15 -0600
> Subject: [PATCH] ARM: OMAP4/AM335x: hwmod: fix disable_module regression in
>  hardreset handling
> 
> Commit eb05f691290e99ee0bd1672317d6add789523c1e ("ARM: OMAP: hwmod:
> partially un-reset hwmods might not be properly enabled") added code
> to skip the IP block disable sequence if all of the block's hardreset
> lines weren't asserted.  But this did not handle the case when no
> hardreset lines were associated with a module, which is the general
> case.  In that situation, the IP block disable would be skipped.  This
> is likely to cause PM regressions.
> 
> So, modify _omap4_disable_module() and _am33xx_disable_module() to
> only bail out early if there are any hardreset lines asserted.  And
> move the AM33xx test above the actual module disable code to ensure
> that the behavior is consistent.
> 

Paul,

I just tested it on Bone + one gpmc fix (will submit shortly) and it boots 
up fine for me. I have also tested for module disable, and it works.

Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>


Log for reference - 


[    0.749504] _clkctrl_idlest:109 inst - 0, clkctrl_offs - 84, v - 2
[    0.749630] omap_hwmod: timer3: _am33xx_disable_module
[    0.749652] _clkctrl_idlest:109 inst - 0, clkctrl_offs - 84, v - 30000
[    0.749819] _clkctrl_idlest:109 inst - 0, clkctrl_offs - 88, v - 30002
[    0.749841] _clkctrl_idlest:109 inst - 0, clkctrl_offs - 88, v - 2
[    0.749904] omap_hwmod: timer4: _am33xx_disable_module
[    0.749923] _clkctrl_idlest:109 inst - 0, clkctrl_offs - 88, v - 30000
[    0.750131] _clkctrl_idlest:109 inst - 0, clkctrl_offs - ec, v - 10002
[    0.750152] _clkctrl_idlest:109 inst - 0, clkctrl_offs - ec, v - 2
[    0.750218] omap_hwmod: timer5: _am33xx_disable_module
[    0.750236] _clkctrl_idlest:109 inst - 0, clkctrl_offs - ec, v - 10000
[    0.750253] _clkctrl_idlest:109 inst - 0, clkctrl_offs - ec, v - 30000
[    0.750404] _clkctrl_idlest:109 inst - 0, clkctrl_offs - f0, v - 30002
[    0.750423] _clkctrl_idlest:109 inst - 0, clkctrl_offs - f0, v - 2
[    0.750485] omap_hwmod: timer6: _am33xx_disable_module
[    0.750504] _clkctrl_idlest:109 inst - 0, clkctrl_offs - f0, v - 10000
[    0.750520] _clkctrl_idlest:109 inst - 0, clkctrl_offs - f0, v - 30000
[    0.750666] _clkctrl_idlest:109 inst - 0, clkctrl_offs - 7c, v - 30002
[    0.750685] _clkctrl_idlest:109 inst - 0, clkctrl_offs - 7c, v - 2
[    0.750747] omap_hwmod: timer7: _am33xx_disable_module
[    0.750765] _clkctrl_idlest:109 inst - 0, clkctrl_offs - 7c, v - 10000
[    0.750782] _clkctrl_idlest:109 inst - 0, clkctrl_offs - 7c, v - 30000


Thanks,
Vaibhav


> Reported-by: Archit Taneja <a0393947@ti.com>
> Tested-by: Archit Taneja <a0393947@ti.com> # DSS
> Cc: Omar Ramirez Luna <omar.luna@linaro.org>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 299ca28..b969ab1 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1698,6 +1698,29 @@ static bool _are_all_hardreset_lines_asserted(struct omap_hwmod *oh)
>  }
>  
>  /**
> + * _are_any_hardreset_lines_asserted - return true if any part of @oh is
> + * hard-reset
> + * @oh: struct omap_hwmod *
> + *
> + * If any hardreset lines associated with @oh are asserted, then
> + * return true.  Otherwise, if no hardreset lines associated with @oh
> + * are asserted, or if @oh has no hardreset lines, then return false.
> + * This function is used to avoid executing some parts of the IP block
> + * enable/disable sequence if any hardreset line is set.
> + */
> +static bool _are_any_hardreset_lines_asserted(struct omap_hwmod *oh)
> +{
> +	int rst_cnt = 0;
> +	int i;
> +
> +	for (i = 0; i < oh->rst_lines_cnt && rst_cnt == 0; i++)
> +		if (_read_hardreset(oh, oh->rst_lines[i].name) > 0)
> +			rst_cnt++;
> +
> +	return (rst_cnt) ? true : false;
> +}
> +
> +/**
>   * _omap4_disable_module - enable CLKCTRL modulemode on OMAP4
>   * @oh: struct omap_hwmod *
>   *
> @@ -1715,7 +1738,7 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
>  	 * Since integration code might still be doing something, only
>  	 * disable if all lines are under hardreset.
>  	 */
> -	if (!_are_all_hardreset_lines_asserted(oh))
> +	if (_are_any_hardreset_lines_asserted(oh))
>  		return 0;
>  
>  	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
> @@ -1749,12 +1772,12 @@ static int _am33xx_disable_module(struct omap_hwmod *oh)
>  
>  	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
>  
> +	if (_are_any_hardreset_lines_asserted(oh))
> +		return 0;
> +
>  	am33xx_cm_module_disable(oh->clkdm->cm_inst, oh->clkdm->clkdm_offs,
>  				 oh->prcm.omap4.clkctrl_offs);
>  
> -	if (_are_all_hardreset_lines_asserted(oh))
> -		return 0;
> -
>  	v = _am33xx_wait_target_disable(oh);
>  	if (v)
>  		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
> -- 
> 1.7.10.4
> 
> 

