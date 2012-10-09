From: Archit Taneja <archit@ti.com>
Subject: Re: Issue with _are_all_hardreset_lines_asserted()
Date: Tue, 9 Oct 2012 12:13:35 +0530
Message-ID: <5073C797.1010100@ti.com>
References: <506D8C0E.8010600@ti.com> <alpine.DEB.2.00.1210090503470.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60089 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab2JIGnn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Oct 2012 02:43:43 -0400
In-Reply-To: <alpine.DEB.2.00.1210090503470.5736@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>, hvaibhav@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>

Hi,

On Tuesday 09 October 2012 11:08 AM, Paul Walmsley wrote:
> cc Vaibhav due to the AM33xx change
>
> Hi
>
> On Thu, 4 Oct 2012, Archit Taneja wrote:
>
>> I was trying out the linux-next kernel, and I noticed that DSS MODULEMODE bits
>> are never cleared.
>>
>> In _omap4_disable_module(), there is a check:
>>
>> 	...
>>
>> 	if (!_are_all_hardreset_lines_asserted(oh))
>> 		return 0;
>>
>> 	/* MODULEMODE bits cleared here */
>> 	...
>> 	...
>> 	...
>>
>> The function _are_all_hardreset_lines_asserted() returns false if
>> 'oh->rst_lines_cnt == 0', so we bail out from _omap4_disable_module() before
>> clearing the MODULEMODE bits.
>>
>> Is this correct behavior? This would prevent all hwmods who have rst_lines_cnt
>> as 0 to not get their MODULEMODE bits cleared.
>
> You're right, that looks bogus.  What do you think about the following
> patch?
>

The patch looks fine to me. I tried it out for DSS(with an additional 
patch to not represent DSS modulemode bits as a slave clock), and 
modulemode is getting disabled correctly now.

Thanks,
Archit

>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Mon, 8 Oct 2012 23:08:15 -0600
> Subject: [PATCH] ARM: OMAP4/AM335x: hwmod: fix disable_module regression in
>   hardreset handling
>
> Commit eb05f691290e99ee0bd1672317d6add789523c1e ("ARM: OMAP: hwmod:
> partially un-reset hwmods might not be properly enabled") added code
> to skip the IP block disable sequence if any hardreset lines were left
> unasserted.  But this did not handle the case when no hardreset lines
> were associated with a module, which is the general case.  In that
> situation, the IP block would be skipped, which is likely to cause PM
> regressions.
>
> So, modify _omap4_disable_module() and _am33xx_disable_module() to
> only bail out early if there are any hardreset lines asserted.  And
> move the AM33xx test above the actual module disable code to ensure
> that the behavior is consistent.
>
> Reported-by: Archit Taneja <a0393947@ti.com>
> Cc: Omar Ramirez Luna <omar.luna@linaro.org>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 299ca28..b969ab1 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1698,6 +1698,29 @@ static bool _are_all_hardreset_lines_asserted(struct omap_hwmod *oh)
>   }
>
>   /**
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
>    * _omap4_disable_module - enable CLKCTRL modulemode on OMAP4
>    * @oh: struct omap_hwmod *
>    *
> @@ -1715,7 +1738,7 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
>   	 * Since integration code might still be doing something, only
>   	 * disable if all lines are under hardreset.
>   	 */
> -	if (!_are_all_hardreset_lines_asserted(oh))
> +	if (_are_any_hardreset_lines_asserted(oh))
>   		return 0;
>
>   	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
> @@ -1749,12 +1772,12 @@ static int _am33xx_disable_module(struct omap_hwmod *oh)
>
>   	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
>
> +	if (_are_any_hardreset_lines_asserted(oh))
> +		return 0;
> +
>   	am33xx_cm_module_disable(oh->clkdm->cm_inst, oh->clkdm->clkdm_offs,
>   				 oh->prcm.omap4.clkctrl_offs);
>
> -	if (_are_all_hardreset_lines_asserted(oh))
> -		return 0;
> -
>   	v = _am33xx_wait_target_disable(oh);
>   	if (v)
>   		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
>

