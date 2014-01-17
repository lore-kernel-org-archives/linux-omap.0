From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Fri, 17 Jan 2014 12:58:32 -0800
Message-ID: <20140117205832.4167.95162@quantum>
References: <52D53084.1070105@ti.com> <20140115031632.4167.2698@quantum>
 <20140115035011.4167.96678@quantum> <20140115171323.GA22739@atomide.com>
 <20140115192340.4167.87685@quantum> <20140115193547.GF7993@atomide.com>
 <20140116213954.4167.37071@quantum> <87r486mrh5.fsf@linaro.org>
 <20140117175312.GH7993@atomide.com> <52D9723A.6000700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f182.google.com ([209.85.161.182]:48407 "EHLO
	mail-gg0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbaAQU6o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jan 2014 15:58:44 -0500
Received: by mail-gg0-f182.google.com with SMTP id e27so1464686gga.27
        for <linux-omap@vger.kernel.org>; Fri, 17 Jan 2014 12:58:41 -0800 (PST)
In-Reply-To: <52D9723A.6000700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, balbi@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>

Quoting Tero Kristo (2014-01-17 10:11:06)
> On 01/17/2014 07:53 PM, Tony Lindgren wrote:
> > * Kevin Hilman <khilman@linaro.org> [140117 09:48]:
> >> Mike Turquette <mturquette@linaro.org> writes:
> >>
> >> [...]
> >>
> >>> I took Tony's advice and fast-forwarded clk-next to -rc7 and applied
> >>> Tero's series. This includes the AM3517 bits now. I've pushed this
> >>> branch to clk-next-omap (force update) on my Linaro mirror. Can you do a
> >>> final sanity test before I merge this into clk-next?
> 
> I think you accidentally merged wrong branch to clk-next-omap with the 
> latest refresh. This is one is missing the build-fixes now, when it 
> earlier had those in.
> 
> The correct branch to merge was 3.13-rc7-dt-clks-v13-build-fixes.
> 
> This also causes the build failure below for omap1.

You are right. I broke the OMAPs. I force updated clk-next-omap (and
clk-next) with the correct branch this time.

Regards,
Mike

> 
> -Tero
> 
> >>
> >> I merged clk-next-omap into next-20140117 and build/boot tested
> >> omap2plus_defconfig, multi_v7_defconfig and
> >> multi_v7_defconfig+CONFIG_LPAE=y and all passed a basic boot test for
> >> omap5uevm.
> >>
> >> I'll add OMAP5 to the automated boot testing starting with the next
> >> linux-next.
> >
> > OK that's good news. Looks like omap1_defconfig build has now started
> > failing though:
> >
> > vers/built-in.o: In function `omap5xxx_dt_clk_init':
> > :(.init.text+0x846c): undefined reference to `omap2_clk_disable_autoidle_all'
> > drivers/built-in.o: In function `am43xx_dt_clk_init':
> > :(.init.text+0x856c): undefined reference to `omap2_clk_disable_autoidle_all'
> > drivers/built-in.o:(.rodata+0xc3c4): undefined reference to `omap3_clkoutx2_recalc'
> > drivers/built-in.o:(.rodata+0xc40c): undefined reference to `omap3_noncore_dpll_enable'
> > drivers/built-in.o:(.rodata+0xc410): undefined reference to `omap3_noncore_dpll_disable'
> > drivers/built-in.o:(.rodata+0xc41c): undefined reference to `omap3_dpll_recalc'
> > drivers/built-in.o:(.rodata+0xc420): undefined reference to `omap2_dpll_round_rate'
> > drivers/built-in.o:(.rodata+0xc42c): undefined reference to `omap2_init_dpll_parent'
> > drivers/built-in.o:(.rodata+0xc430): undefined reference to `omap3_noncore_dpll_set_rate'
> > drivers/built-in.o:(.rodata+0xc470): undefined reference to `omap3_dpll_recalc'
> > drivers/built-in.o:(.rodata+0xc474): undefined reference to `omap2_dpll_round_rate'
> > drivers/built-in.o:(.rodata+0xc480): undefined reference to `omap2_init_dpll_parent'
> > drivers/built-in.o:(.rodata+0xc4a0): undefined reference to `omap3_noncore_dpll_enable'
> > drivers/built-in.o:(.rodata+0xc4a4): undefined reference to `omap3_noncore_dpll_disable'
> > drivers/built-in.o:(.rodata+0xc4b0): undefined reference to `omap3_dpll_recalc'
> > drivers/built-in.o:(.rodata+0xc4b4): undefined reference to `omap2_dpll_round_rate'
> > drivers/built-in.o:(.rodata+0xc4c0): undefined reference to `omap2_init_dpll_parent'
> > drivers/built-in.o:(.rodata+0xc4c4): undefined reference to `omap3_dpll4_set_rate'
> > drivers/built-in.o:(.rodata+0xc4e0): undefined reference to `omap3_noncore_dpll_enable'
> > drivers/built-in.o:(.rodata+0xc4e4): undefined reference to `omap3_noncore_dpll_disable'
> > drivers/built-in.o:(.rodata+0xc4f0): undefined reference to `omap3_dpll_recalc'
> > drivers/built-in.o:(.rodata+0xc4f4): undefined reference to `omap2_dpll_round_rate'
> > drivers/built-in.o:(.rodata+0xc500): undefined reference to `omap2_init_dpll_parent'
> > drivers/built-in.o:(.rodata+0xc504): undefined reference to `omap3_noncore_dpll_set_rate'
> > drivers/built-in.o:(.rodata+0xc530): undefined reference to `omap3_dpll_recalc'
> > drivers/built-in.o:(.rodata+0xc540): undefined reference to `omap2_init_dpll_parent'
> > drivers/built-in.o:(.rodata+0xc560): undefined reference to `omap3_noncore_dpll_enable'
> > drivers/built-in.o:(.rodata+0xc564): undefined reference to `omap3_noncore_dpll_disable'
> > drivers/built-in.o:(.rodata+0xc570): undefined reference to `omap4_dpll_regm4xen_recalc'
> > drivers/built-in.o:(.rodata+0xc574): undefined reference to `omap4_dpll_regm4xen_round_rate'
> > drivers/built-in.o:(.rodata+0xc580): undefined reference to `omap2_init_dpll_parent'
> > drivers/built-in.o:(.rodata+0xc584): undefined reference to `omap3_noncore_dpll_set_rate'
> > drivers/built-in.o:(.rodata+0xc5b0): undefined reference to `omap3_dpll_recalc'
> > drivers/built-in.o:(.rodata+0xc5b4): undefined reference to `omap2_dpll_round_rate'
> > drivers/built-in.o:(.rodata+0xc5c0): undefined reference to `omap2_init_dpll_parent'
> > drivers/built-in.o:(.rodata+0xc5c4): undefined reference to `omap3_noncore_dpll_set_rate'
> > drivers/built-in.o:(.rodata+0xc63c): undefined reference to `omap2_dflt_clk_enable'
> > drivers/built-in.o:(.rodata+0xc640): undefined reference to `omap2_dflt_clk_disable'
> > drivers/built-in.o:(.rodata+0xc644): undefined reference to `omap2_dflt_clk_is_enabled'
> > drivers/built-in.o:(.rodata+0xc728): undefined reference to `omap2_clkops_enable_clkdm'
> > drivers/built-in.o:(.rodata+0xc72c): undefined reference to `omap2_clkops_disable_clkdm'
> > drivers/built-in.o:(.rodata+0xc754): undefined reference to `omap2_init_clk_clkdm'
> > drivers/built-in.o:(.rodata+0xc784): undefined reference to `omap2_dflt_clk_disable'
> > drivers/built-in.o:(.rodata+0xc788): undefined reference to `omap2_dflt_clk_is_enabled'
> > drivers/built-in.o:(.rodata+0xc7ac): undefined reference to `omap2_init_clk_clkdm'
> > drivers/built-in.o:(.rodata+0xc7c0): undefined reference to `omap2_dflt_clk_enable'
> > drivers/built-in.o:(.rodata+0xc7c4): undefined reference to `omap2_dflt_clk_disable'
> > drivers/built-in.o:(.rodata+0xc7c8): undefined reference to `omap2_dflt_clk_is_enabled'
> > drivers/built-in.o:(.rodata+0xc7ec): undefined reference to `omap2_init_clk_clkdm'
> > drivers/built-in.o:(.rodata+0xc838): undefined reference to `__clk_mux_determine_rate'
> > drivers/built-in.o:(.rodata+0xc904): undefined reference to `omap2_dflt_clk_enable'
> > drivers/built-in.o:(.rodata+0xc908): undefined reference to `omap2_dflt_clk_disable'
> > drivers/built-in.o:(.rodata+0xc90c): undefined reference to `omap2_dflt_clk_is_enabled'
> > drivers/built-in.o:(.rodata+0xc930): undefined reference to `omap2_init_clk_clkdm'
> >
> > Regards,
> >
> > Tony
> >
> 
