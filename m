From: <ext-ari.kauppi@nokia.com>
Subject: RE: [PATCH 2/2 v2] OMAP3:clk - introduce DPLL4 jtype support
Date: Sat, 31 Oct 2009 10:40:29 +0100
Message-ID: <3226CB891F0AC447A7A37ED6259427E63B8A7BC579@NOK-EUMSG-05.mgdnok.nokia.com>
References: <[PATCH 2/2] OMAP3:clk: introduce DPLL4 jtype support>
 <1256068968-16564-1-git-send-email-nm@ti.com>,<alpine.DEB.2.00.0910282032550.19865@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38470 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757621AbZJaJpP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Oct 2009 05:45:15 -0400
In-Reply-To: <alpine.DEB.2.00.0910282032550.19865@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com, r-woodruff2@ti.com
Cc: linux-omap@vger.kernel.org, vikram.pandita@ti.com, m-sonasath@ti.com, saaguirre@ti.com, paul@pwsan.com

Hi,

Some more comments at the end of the mail. Relevant parts of the patch included.

> @@ -707,6 +742,13 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
>       v &= ~(dd->mult_mask | dd->div1_mask);
>       v |= m << __ffs(dd->mult_mask);
>       v |= (n - 1) << __ffs(dd->div1_mask);
> +     if (dd->jtype) {
> +             u8 dco, sd_div;
> +             lookup_dco_sddiv(clk, &dco, &sd_div, m, n);
> +             v &= ~(dd->dco_sel_mask | dd->sd_div_mask);
> +             v |=  dco << __ffs(dd->dco_sel_mask);
> +             v |=  sd_div << __ffs(dd->sd_div_mask);
> +     }

> @@ -516,9 +516,13 @@
>
>  /* CM_CLKSEL2_PLL */
>  #define OMAP3430_PERIPH_DPLL_MULT_SHIFT                      8
> -#define OMAP3430_PERIPH_DPLL_MULT_MASK                       (0x7ff << 8)
> +#define OMAP3430_PERIPH_DPLL_MULT_MASK                       (0xfff << 8)
>  #define OMAP3430_PERIPH_DPLL_DIV_SHIFT                       0
>  #define OMAP3430_PERIPH_DPLL_DIV_MASK                        (0x7f << 0)
> +#define OMAP3630_PERIPH_DPLL_DCO_SEL_SHIFT           21
> +#define OMAP3630_PERIPH_DPLL_DCO_SEL_MASK            (0x7 << 21)
> +#define OMAP3630_PERIPH_DPLL_SD_DIV_SHIFT            24
> +#define OMAP3630_PERIPH_DPLL_SD_DIV_MASK             (0xff << 24)
>
> @@ -60,6 +60,9 @@ struct dpll_data {
>       void __iomem            *idlest_reg;
>       u32                     autoidle_mask;
>       u32                     freqsel_mask;
> +     u32                     dco_sel_mask;
> +     u32                     sd_div_mask;
> +     u8                      jtype;
>       u32                     idlest_mask;
>       u8                      auto_recal_bit;
>       u8                      recal_en_bit;

Are the dco_sel_mask and sd_div_mask needed in the struct or is the jtype flag enough info?
Could you use OMAP3630_PERIPH_DPLL_DCO_SEL_MASK and
OMAP3630_PERIPH_DPLL_SD_DIV_MASK directly in omap3_noncore_dpll_program instead of
dd->dco_sel_mask and sd_div_mask?

--
Ari