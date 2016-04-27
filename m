From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] DRA7: Fix clock data for gmac_gmii_ref_clk_div
Date: Wed, 27 Apr 2016 10:16:58 -0700
Message-ID: <20160427171658.GA5995@atomide.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
 <1461693269-19436-2-git-send-email-Linux.HWI@garmin.com>
 <5720A09F.2060701@ti.com>
 <20160427163640.GZ5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160427163640.GZ5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: "J.D. Schroeder" <Linux.HWI-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "J.D. Schroeder" <jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160427 09:39]:
> * Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [160427 04:22]:
> > On 26/04/16 20:54, J.D. Schroeder wrote:
> > >From: "J.D. Schroeder" <jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
> > >
> > >This commit fixes the clock data inside the DRA7xx clocks device tree
> > >structure for the gmac_gmii_ref_clk_div clock. This clock is actually
> > >the GMAC_MAIN_CLK and has nothing to do with the register at address
> > >0x4a0093d0. If CLKSEL_REF bit 24 inside of CM_GMAC_GMAC_CLKCTRL, is
> > >set to 1 in order to use the GMAC_RMII_CLK instead of the
> > >GMAC_RMII_HS_CLK, the kernel generates a clock divider warning:
> > >     WARNING: CPU: 0 PID: 0 at drivers/clk/clk-divider.c:129 clk_divider_recalc_rate+0xa8/0xe0()
> > >     gmac_gmii_ref_clk_div: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set
> > >
> > >By properly configuring the gmac_gmii_ref_clk_div (GMAC_MAIN_CLK) to
> > >have the parent of dpll_gmac_m2_ck always divided by 2 the warning is
> > >resolved and the clock tree is fixed up.
> > >
> > >Additionally, a new clock called rmii_50mhz_clk_mux is defined that
> > >does utilize CM_GMAC_GMAC_CLKCTRL[24] CLKSEL_REF to configure the
> > >source clock for the RMII_50MHZ_CLK.
> > >
> > >Signed-off-by: J.D. Schroeder <jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
> > >Reviewed-by: Trenton Andres <trenton.andres-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
> > 
> > Looks like something weird happened with the clock data conversion tool with
> > this specific clock. Seems to be the only buggy instance in our clock data
> > across SoCs. Good catch.
> > 
> > Acked-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> 
> Applying into omap-for-v4.6/fixes thanks.

Actually then we end up creating self-inflicted merge conflict
here with next. So let's wait a bit on this one as it's harmless.

J.D. can you please rebase this against current Linux next?

Note the recent unit name and unit address fixes for warnings
with make W=1 dtbs.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
