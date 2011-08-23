From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/5] OMAP2xxx: HWMOD: fix DSS opt clocks
Date: Tue, 23 Aug 2011 00:54:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108230054250.28226@utopia.booyaka.com>
References: <20110821053355.20198.23847.stgit@dusk> <20110821054227.20198.80273.stgit@dusk> <20110823065255.GN4996@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45569 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab1HWGyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Aug 2011 02:54:53 -0400
In-Reply-To: <20110823065255.GN4996@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tomi,

On Tue, 23 Aug 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [110821 08:11]:
> > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > Set HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core to allow DSS reset
> > properly.
> 
> Can you please add what this fixes so this can be justified as a fix?
>  
> > Add missing ick opt-clock for rfbi. Rfbi uses the ick to calculate
> > timings.
> 
> Here too.
>  
> > Fix the venc iclk and fclk.
> 
> And here.

Could you please update the patch changelogs per Tony's request?

thanks,

- Paul
