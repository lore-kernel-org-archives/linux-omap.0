From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 2/2 v2] OMAP3:clk - introduce DPLL4 jtype support
Date: Sat, 31 Oct 2009 05:06:52 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B6CDD14@dlee02.ent.ti.com>
References: <[PATCH 2/2] OMAP3:clk: introduce DPLL4 jtype support>
 <1256068968-16564-1-git-send-email-nm@ti.com>,<alpine.DEB.2.00.0910282032550.19865@utopia.booyaka.com>
 <3226CB891F0AC447A7A37ED6259427E63B8A7BC579@NOK-EUMSG-05.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50656 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757469AbZJaKGy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Oct 2009 06:06:54 -0400
In-Reply-To: <3226CB891F0AC447A7A37ED6259427E63B8A7BC579@NOK-EUMSG-05.mgdnok.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext-ari.kauppi@nokia.com" <ext-ari.kauppi@nokia.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Sonasath, Moiz" <m-sonasath@ti.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "paul@pwsan.com" <paul@pwsan.com>


> From: ext-ari.kauppi@nokia.com [mailto:ext-ari.kauppi@nokia.com]
> Sent: Saturday, October 31, 2009 4:40 AM

> > @@ -60,6 +60,9 @@ struct dpll_data {
> >       void __iomem            *idlest_reg;
> >       u32                     autoidle_mask;
> >       u32                     freqsel_mask;
> > +     u32                     dco_sel_mask;
> > +     u32                     sd_div_mask;
> > +     u8                      jtype;
> >       u32                     idlest_mask;
> >       u8                      auto_recal_bit;
> >       u8                      recal_en_bit;
>
> Are the dco_sel_mask and sd_div_mask needed in the struct or is the jtype flag
> enough info?
> Could you use OMAP3630_PERIPH_DPLL_DCO_SEL_MASK and
> OMAP3630_PERIPH_DPLL_SD_DIV_MASK directly in omap3_noncore_dpll_program
> instead of
> dd->dco_sel_mask and sd_div_mask?

Could be done that way, seems a little better also to save structure space. To make quick patch I just followed style/spirit of existing coding.

It will be a couple weeks before I'm near a 3630 again to test any change.  I'm ok if anyone is able to adjust.

Regards
Richard W.

