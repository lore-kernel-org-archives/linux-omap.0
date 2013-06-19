From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv2 10/11] ARM: dts: omap4 clock data
Date: Wed, 19 Jun 2013 08:56:30 -0500
Message-ID: <20130619135629.GA2236@kahuna>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
 <1371647942-4811-11-git-send-email-t-kristo@ti.com>
 <20130619133022.GA30364@kahuna>
 <51C1B707.5090603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56253 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756427Ab3FSN46 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jun 2013 09:56:58 -0400
Content-Disposition: inline
In-Reply-To: <51C1B707.5090603@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, mturquette@linaro.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Eduardo Valentin <eduardo.valentin@ti.com>

On 16:49-20130619, Tero Kristo wrote:
> On 06/19/2013 04:30 PM, Nishanth Menon wrote:
> >On 16:19-20130619, Tero Kristo wrote:
> >[...]
> >>+
> >>+/*
> >>+ * clocks specific to omap4460
> >>+ */
> >>+/*
> >>+ * clocks specific to omap4430
> >>+ */
> >>+/*
> >>+ * clocks common to omap44xx
> >>+ */
> >could be dropped?
> 
> Same.
> 
> >
> >btw, are we differentiating 4430 and 4460?A
> >Example:
> >bandgap_fclk in 4430
> >Vs
> >div_ts_ck, bandgap_ts_fclk in 4460?
> 
> Both nodes are available for both SoCs as of now. Driver should
> differentiate which clock node to use though. Added Eduardo for
> commenting this part, maybe we should add a couple of entries to the
> list in cclock44xx_data.c...?
How about this:
we do have 443x.dtsi and 4460.dtsi -> add the corresponding clock nodes
there?

ideally, driver should just do devm_clk_get and should not worry about
what SoC revision it is running on.

-- 
Regards,
Nishanth Menon
