From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/4] OMAP3: PM: export chip IDCODE, Production ID and
 Die ID
Date: Mon, 26 Apr 2010 14:05:56 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5092B5E@dbde02.ent.ti.com>
References: <1272270293-18568-1-git-send-email-eduardo.valentin@nokia.com>
 <1272270293-18568-5-git-send-email-eduardo.valentin@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5092B58@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59239 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab0DZIgG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 04:36:06 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5092B58@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "\\\"De-Schrijver Peter (Nokia-D/Helsinki)\\\"" <Peter.De-Schrijver@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>

> > +	/* Append OMAP3 IDCODE, Production ID and Die ID to system_soc_info */
> > +	sz = strlen(system_soc_info);
> > +	snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
> > +			"\n\tIDCODE\t: %08x\n\tPr. ID\t: %08x %08x %08x %08x\n"
> > +			"\tDie ID\t: %08x %08x %08x %08x\n",
> > +			read_tap_reg(OMAP_TAP_IDCODE),
> > +			read_tap_reg(OMAP_TAP_PROD_ID_0),
> > +			read_tap_reg(OMAP_TAP_PROD_ID_1),
> > +			read_tap_reg(OMAP_TAP_PROD_ID_2),
> > +			read_tap_reg(OMAP_TAP_PROD_ID_3),
> > +			read_tap_reg(OMAP_TAP_DIE_ID_0),
> > +			read_tap_reg(OMAP_TAP_DIE_ID_1),
> > +			read_tap_reg(OMAP_TAP_DIE_ID_2),
> > +			read_tap_reg(OMAP_TAP_DIE_ID_3));
> >  }
> Just a query here.
> Since we have already code to decode all above information
> And convert it into a meaningful data  like , OMAP3430 ES2.0 , OMAP3630 ES1.0
> , OMAP4430 ES1.0 etc.
> 
> Can we export that itself. Ofcourse with above data also some one can refer TRM
> and do the decoding.
> 
Ignore the previous comment since looks like you are already doing that.
Regards,
Santosh
