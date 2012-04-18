From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from
 both clk and hwmod
Date: Wed, 18 Apr 2012 11:09:48 +0200
Message-ID: <4F8E84DC.70600@ti.com>
References: <1334238098-29859-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com> <4F8E76C3.7080803@ti.com> <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37610 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab2DRJJx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 05:09:53 -0400
In-Reply-To: <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 4/18/2012 10:52 AM, Paul Walmsley wrote:
> On Wed, 18 Apr 2012, Cousson, Benoit wrote:
> 
>> On 4/12/2012 7:06 PM, Paul Walmsley wrote:
>>> On Thu, 12 Apr 2012, Rajendra Nayak wrote:
>>>
>>>> On OMAP4+, the clkdm association is moved to hwmod while on older OMAPs'
>>>> its associated with a clk.
>>>
>>> Sounds like this should be conditional based on the platform, then,
>>> rather than weakening the warning for all platforms ?
>>
>> Well, as already discussed the clockdomain information is mostly useless for
>> most clock nodes because the HW is taking care of the dependencies, so
>> highlighting only the ones missing in hwmod is far from enough and will avoid
>> scaring people with something that is normal.
> 
> Sounds to me like the right time to make this change for OMAP4 is when the
> call to omap2_clk_disable_clkdm_control() is removed from
> clock44xx_data.c.  Hopefully that can happen as soon as someone can finish
> the analysis work that we discussed to figure out what drivers still
> aren't converted to using runtime PM, backed with omap_device&
> omap_hwmod.

Well, the point is that we do not need this warning even for that.
This is something we have to ensure by reviewing carefully the code.
If you look today, the warning is complaining about clocks that are perfectly fine. So keeping it will just add some noise and not necessarily highlighting the real issue.

FYI here is what we have after the clock cleanup on OMAP4 (i.e removal of modulemode clock nodes):

[    0.287292] omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
[    0.294250] omap_hwmod: func_dmic_abe_gfclk: missing clockdomain for func_dmic_abe_gfclk.
[    0.302795] omap_hwmod: dpll_iva_m4x2_ck: missing clockdomain for dpll_iva_m4x2_ck.
[    0.310821] omap_hwmod: l4_wkup_clk_mux: missing clockdomain for l4_wkup_clk_mux.
[    0.318603] omap_hwmod: l4_div_ck: missing clockdomain for l4_div_ck.
[    0.325317] omap_hwmod: l4_div_ck: missing clockdomain for l4_div_ck.
[    0.332031] omap_hwmod: l4_div_ck: missing clockdomain for l4_div_ck.
[    0.338745] omap_hwmod: l4_div_ck: missing clockdomain for l4_div_ck.
[    0.345458] omap_hwmod: l4_div_ck: missing clockdomain for l4_div_ck.
[    0.352172] omap_hwmod: func_96m_fclk: missing clockdomain for func_96m_fclk.
[    0.359588] omap_hwmod: func_96m_fclk: missing clockdomain for func_96m_fclk.
[    0.367034] omap_hwmod: func_96m_fclk: missing clockdomain for func_96m_fclk.
[    0.374450] omap_hwmod: func_96m_fclk: missing clockdomain for func_96m_fclk.
[    0.381866] omap_hwmod: ducati_clk_mux: missing clockdomain for ducati_clk_mux.
[    0.389465] omap_hwmod: dpll_iva_m5x2_ck: missing clockdomain for dpll_iva_m5x2_ck.
[    0.397460] omap_hwmod: sys_32k_ck: missing clockdomain for sys_32k_ck.
[    0.404357] omap_hwmod: l4_div_ck: missing clockdomain for l4_div_ck.
[    0.411041] omap_hwmod: func_mcbsp1_gfclk: missing clockdomain for func_mcbsp1_gfclk.
[    0.419219] omap_hwmod: func_mcbsp2_gfclk: missing clockdomain for func_mcbsp2_gfclk.
[    0.427337] omap_hwmod: func_mcbsp3_gfclk: missing clockdomain for func_mcbsp3_gfclk.
[    0.435485] omap_hwmod: per_mcbsp4_gfclk: missing clockdomain for per_mcbsp4_gfclk.
[    0.443481] omap_hwmod: pad_clks: missing clockdomain for pad_clks.
[    0.449981] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.457427] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.464843] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.472259] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.479705] omap_hwmod: hsmmc1_fclk: missing clockdomain for hsmmc1_fclk.
[    0.486755] omap_hwmod: hsmmc2_fclk: missing clockdomain for hsmmc2_fclk.
[    0.493835] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.501251] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.508666] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.516113] omap_hwmod: l4_wkup_clk_mux: missing clockdomain for l4_wkup_clk_mux.
[    0.523895] omap_hwmod: l4_wkup_clk_mux: missing clockdomain for l4_wkup_clk_mux.
[    0.531677] omap_hwmod: l4_wkup_clk_mux: missing clockdomain for l4_wkup_clk_mux.
[    0.539459] omap_hwmod: l4_div_ck: missing clockdomain for l4_div_ck.
[    0.546173] omap_hwmod: cm2_dm2_mux_ck: missing clockdomain for cm2_dm2_mux_ck.
[    0.553771] omap_hwmod: cm2_dm3_mux_ck: missing clockdomain for cm2_dm3_mux_ck.
[    0.561370] omap_hwmod: cm2_dm4_mux_ck: missing clockdomain for cm2_dm4_mux_ck.
[    0.568969] omap_hwmod: timer5_sync_mux_ck: missing clockdomain for timer5_sync_mux_ck.
[    0.577270] omap_hwmod: timer6_sync_mux_ck: missing clockdomain for timer6_sync_mux_ck.
[    0.585601] omap_hwmod: timer7_sync_mux_ck: missing clockdomain for timer7_sync_mux_ck.
[    0.593902] omap_hwmod: timer8_sync_mux_ck: missing clockdomain for timer8_sync_mux_ck.
[    0.602233] omap_hwmod: cm2_dm9_mux_ck: missing clockdomain for cm2_dm9_mux_ck.
[    0.609832] omap_hwmod: cm2_dm10_mux_ck: missing clockdomain for cm2_dm10_mux_ck.
[    0.617614] omap_hwmod: cm2_dm11_mux_ck: missing clockdomain for cm2_dm11_mux_ck.
[    0.625396] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.632843] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.640258] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.647674] omap_hwmod: func_48m_fclk: missing clockdomain for func_48m_fclk.
[    0.655120] omap_hwmod: l4_div_ck: missing clockdomain for l4_div_ck.
[    0.661804] omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
[    0.668518] omap_hwmod: sys_32k_ck: missing clockdomain for sys_32k_ck.
[    0.675415] omap_hwmod: sys_32k_ck: missing clockdomain for sys_32k_ck.

That's a lot of noise for nothing. That's why Rajendra's patch is needed now.

> And at that point, there shouldn't be any reason to test oh->_clk->clkdm
> at all on OMAP4, no?  OMAP4 should only warn if oh->clkdm_name is missing
> or can't be resolved.

Yes, that's right.

>> Considering that OMAP4 clock domain partition is way more complex than it was
>> on OMAP2&  3, if OMAP4 can leave without that, I doubt OMAP2&  3 clock nodes
>> will ever need it, except HW bugs, as usual.
>>
>> But still, it is an exception more than the regular case.
> 
> As far as OMAP2/3 goes, when OMAP2/3 is converted to use the hwmod
> clockdomain enable sequence, that seems like a good time to drop the
> oh->_clk->clkdm test for main clocks.

Yes, indeed.

> I'm also wondering if we should be checking clockdomains for the optional
> clocks in _init_opt_clks()... at least on OMAP2/3, unsure about OMAP4.
> Right now we don't implement any hwmod clockdomain enable sequence for the
> optional clocks.

This will not be necessary as soon as we ensure that we always have one main_clk.

The issue was mainly with the DSS, but since we upgraded the dss_dss_fck to become the main_clk, we do not have any opt_clk issue.

Regards,
Benoit  

