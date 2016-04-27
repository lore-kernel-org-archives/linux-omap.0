From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] DRA7: Fix clock data for gmac_gmii_ref_clk_div
Date: Wed, 27 Apr 2016 09:36:41 -0700
Message-ID: <20160427163640.GZ5995@atomide.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
 <1461693269-19436-2-git-send-email-Linux.HWI@garmin.com>
 <5720A09F.2060701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5720A09F.2060701@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "J.D. Schroeder" <Linux.HWI@garmin.com>, linux-kernel@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160427 04:22]:
> On 26/04/16 20:54, J.D. Schroeder wrote:
> >From: "J.D. Schroeder" <jay.schroeder@garmin.com>
> >
> >This commit fixes the clock data inside the DRA7xx clocks device tree
> >structure for the gmac_gmii_ref_clk_div clock. This clock is actually
> >the GMAC_MAIN_CLK and has nothing to do with the register at address
> >0x4a0093d0. If CLKSEL_REF bit 24 inside of CM_GMAC_GMAC_CLKCTRL, is
> >set to 1 in order to use the GMAC_RMII_CLK instead of the
> >GMAC_RMII_HS_CLK, the kernel generates a clock divider warning:
> >     WARNING: CPU: 0 PID: 0 at drivers/clk/clk-divider.c:129 clk_divider_recalc_rate+0xa8/0xe0()
> >     gmac_gmii_ref_clk_div: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set
> >
> >By properly configuring the gmac_gmii_ref_clk_div (GMAC_MAIN_CLK) to
> >have the parent of dpll_gmac_m2_ck always divided by 2 the warning is
> >resolved and the clock tree is fixed up.
> >
> >Additionally, a new clock called rmii_50mhz_clk_mux is defined that
> >does utilize CM_GMAC_GMAC_CLKCTRL[24] CLKSEL_REF to configure the
> >source clock for the RMII_50MHZ_CLK.
> >
> >Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
> >Reviewed-by: Trenton Andres <trenton.andres@garmin.com>
> 
> Looks like something weird happened with the clock data conversion tool with
> this specific clock. Seems to be the only buggy instance in our clock data
> across SoCs. Good catch.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Applying into omap-for-v4.6/fixes thanks.

Tony
