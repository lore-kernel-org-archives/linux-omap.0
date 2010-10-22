From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 10/11] OMAP3: PM: Program correct init voltages for VDD1 and VDD2
Date: Fri, 22 Oct 2010 09:44:17 -0700
Message-ID: <87fwvy9nz2.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-11-git-send-email-thara@ti.com>
	<871v7spc07.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB95EAD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34760 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757856Ab0JVQoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 12:44:22 -0400
Received: by pwj8 with SMTP id 8so8049pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 09:44:22 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035EB95EAD@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Fri, 22 Oct 2010 20:14:51 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>> +static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
>>>> +						struct device *dev)
>>>> +{
>>>> +	struct voltagedomain *voltdm;
>>>> +	struct clk *_clk;
>>>
>>>s/_clk/clk/
>
> Will it not conflict with struct clk??
>

Nope.

$ find . -type f -print0 | xargs -0 -e grep -nH -e 'struct clk \*clk'
./clock2430.c:43:static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
./clock34xx.c:42:static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
./clock34xx.c:76:static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
./clock34xx.c:108:static void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
./clkt34xx_dpll3m2.c:50:int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
./clkt2xxx_osc.c:33:static int omap2_enable_osc_ck(struct clk *clk)
./clkt2xxx_osc.c:44:static void omap2_disable_osc_ck(struct clk *clk)
./clkt2xxx_osc.c:58:unsigned long omap2_osc_clk_recalc(struct clk *clk)
./clkt_dpll.c:72:static int _dpll_test_fint(struct clk *clk, u8 n)
./clkt_dpll.c:173:void omap2_init_dpll_parent(struct clk *clk)
./clkt_dpll.c:219:u32 omap2_get_dpll_rate(struct clk *clk)
./clkt_dpll.c:277:int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance)
./clkt_dpll.c:303:long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)
./clkt_clksel.c:62:static const struct clksel *_get_clksel_by_parent(struct clk *clk,
./clkt_clksel.c:96:static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
./clkt_clksel.c:151:static void _write_clksel_reg(struct clk *clk, u32 field_val)
./clkt_clksel.c:174:static u32 _clksel_to_divisor(struct clk *clk, u32 field_val)
./clkt_clksel.c:211:static u32 _divisor_to_clksel(struct clk *clk, u32 div)
./clkt_clksel.c:248:static u32 _read_divisor(struct clk *clk)
./clkt_clksel.c:276:u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
./clkt_clksel.c:342:void omap2_init_clksel_parent(struct clk *clk)
./clkt_clksel.c:389:unsigned long omap2_clksel_recalc(struct clk *clk)
./clkt_clksel.c:417:long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
./clkt_clksel.c:439:int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
./clkt_clksel.c:483:int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent)
./clockdomain.c:892:int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
./clockdomain.c:947:int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
./clock2xxx.h:11:unsigned long omap2_table_mpu_recalc(struct clk *clk);
./clock2xxx.h:12:int omap2_select_table_rate(struct clk *clk, unsigned long rate);
./clock2xxx.h:13:long omap2_round_to_table_rate(struct clk *clk, unsigned long rate);
./clock2xxx.h:14:unsigned long omap2xxx_sys_clk_recalc(struct clk *clk);
./clock2xxx.h:15:unsigned long omap2_osc_clk_recalc(struct clk *clk);
./clock2xxx.h:16:unsigned long omap2_dpllcore_recalc(struct clk *clk);
./clock2xxx.h:17:int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
./clock2xxx.h:18:unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
./dpll3xxx.c:49:static void _omap3_dpll_write_clken(struct clk *clk, u8 clken_bits)
./dpll3xxx.c:63:static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
./dpll3xxx.c:93:static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
./dpll3xxx.c:138:static int _omap3_noncore_dpll_lock(struct clk *clk)
./dpll3xxx.c:172:static int _omap3_noncore_dpll_bypass(struct clk *clk)
./dpll3xxx.c:206:static int _omap3_noncore_dpll_stop(struct clk *clk)
./dpll3xxx.c:240:static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
./dpll3xxx.c:278:static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
./dpll3xxx.c:336:unsigned long omap3_dpll_recalc(struct clk *clk)
./dpll3xxx.c:357:int omap3_noncore_dpll_enable(struct clk *clk)
./dpll3xxx.c:390:void omap3_noncore_dpll_disable(struct clk *clk)
./dpll3xxx.c:409:int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
./dpll3xxx.c:494:u32 omap3_dpll_autoidle_read(struct clk *clk)
./dpll3xxx.c:520:void omap3_dpll_allow_idle(struct clk *clk)
./dpll3xxx.c:547:void omap3_dpll_deny_idle(struct clk *clk)
./dpll3xxx.c:573:unsigned long omap3_clkoutx2_recalc(struct clk *clk)
./clkt2xxx_virt_prcm_set.c:55:unsigned long omap2_table_mpu_recalc(struct clk *clk)
./clkt2xxx_virt_prcm_set.c:67:long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
./clkt2xxx_virt_prcm_set.c:90:int omap2_select_table_rate(struct clk *clk, unsigned long rate)
./clkt2xxx_sys.c:45:unsigned long omap2xxx_sys_clk_recalc(struct clk *clk)
./clock3xxx.h:12:int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
./clock3xxx.h:13:int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
./clkt2xxx_apll.c:46:static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
./clkt2xxx_apll.c:71:static int omap2_clk_apll96_enable(struct clk *clk)
./clkt2xxx_apll.c:76:static int omap2_clk_apll54_enable(struct clk *clk)
./clkt2xxx_apll.c:82:static void omap2_clk_apll_disable(struct clk *clk)
./clkt2xxx_dpllcore.c:50:unsigned long omap2xxx_clk_get_core_rate(struct clk *clk)
./clkt2xxx_dpllcore.c:101:unsigned long omap2_dpllcore_recalc(struct clk *clk)
./clkt2xxx_dpllcore.c:106:int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
./clock.h:54:int omap2_clk_enable(struct clk *clk);
./clock.h:55:void omap2_clk_disable(struct clk *clk);
./clock.h:56:long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
./clock.h:57:int omap2_clk_set_rate(struct clk *clk, unsigned long rate);
./clock.h:58:int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
./clock.h:59:int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolerance);
./clock.h:60:long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate);
./clock.h:61:unsigned long omap3_dpll_recalc(struct clk *clk);
./clock.h:62:unsigned long omap3_clkoutx2_recalc(struct clk *clk);
./clock.h:63:void omap3_dpll_allow_idle(struct clk *clk);
./clock.h:64:void omap3_dpll_deny_idle(struct clk *clk);
./clock.h:65:u32 omap3_dpll_autoidle_read(struct clk *clk);
./clock.h:66:int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
./clock.h:67:int omap3_noncore_dpll_enable(struct clk *clk);
./clock.h:68:void omap3_noncore_dpll_disable(struct clk *clk);
./clock.h:71:void omap2_clk_disable_unused(struct clk *clk);
./clock.h:76:void omap2_init_clk_clkdm(struct clk *clk);
./clock.h:79:u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
./clock.h:81:void omap2_init_clksel_parent(struct clk *clk);
./clock.h:82:unsigned long omap2_clksel_recalc(struct clk *clk);
./clock.h:83:long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
./clock.h:84:int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
./clock.h:85:int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent);
./clock.h:87:u32 omap2_get_dpll_rate(struct clk *clk);
./clock.h:88:void omap2_init_dpll_parent(struct clk *clk);
./clock.h:117:int omap2_dflt_clk_enable(struct clk *clk);
./clock.h:118:void omap2_dflt_clk_disable(struct clk *clk);
./clock.h:119:void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
./clock.h:121:void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
./clock.c:56:static void _omap2_module_wait_ready(struct clk *clk)
./clock.c:84:void omap2_init_clk_clkdm(struct clk *clk)
./clock.c:123:void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
./clock.c:152:void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
./clock.c:175:int omap2_dflt_clk_enable(struct clk *clk)
./clock.c:199:void omap2_dflt_clk_disable(struct clk *clk)
./clock.c:249:void omap2_clk_disable(struct clk *clk)
./clock.c:286:int omap2_clk_enable(struct clk *clk)
./clock.c:338:long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
./clock.c:347:int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
./clock.c:360:int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
./clock.c:388:void omap2_clk_disable_unused(struct clk *clk)
./clock36xx.c:42:static int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk *clk)
./clock3xxx.c:43:int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
./clock3517.c:52:static void am35xx_clk_find_idlest(struct clk *clk,
./clock3517.c:76:static void am35xx_clk_find_companion(struct clk *clk, void __iomem **other_reg,
./clock3517.c:104:static void am35xx_clk_ipss_find_idlest(struct clk *clk,

