From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] OMAP2xxx: HWMOD: fix DSS opt clocks
Date: Tue, 23 Aug 2011 09:54:31 +0300
Message-ID: <20110823065430.GO4996@atomide.com>
References: <20110821053355.20198.23847.stgit@dusk>
 <20110821054227.20198.80273.stgit@dusk>
 <20110823065255.GN4996@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:38852 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751027Ab1HWGyc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Aug 2011 02:54:32 -0400
Content-Disposition: inline
In-Reply-To: <20110823065255.GN4996@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Tony Lindgren <tony@atomide.com> [110823 09:20]:
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

Looks like the comments for the whole series should be improved
so it's clear to everybody what issues these fix and what caused
the breakage.

Tony
