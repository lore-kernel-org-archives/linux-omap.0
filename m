From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]  New DPLL clock framework.
Date: Tue, 18 Mar 2008 13:50:29 +0200
Message-ID: <20080318115028.GD7843@atomide.com>
References: <1205436909-13213-1-git-send-email-roman.tereshonkov@nokia.com> <alpine.DEB.1.00.0803171456150.31844@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57090 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbYCRMuO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2008 08:50:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0803171456150.31844@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@booyaka.com> [080317 23:31]:
> On Thu, 13 Mar 2008, Roman Tereshonkov wrote:
> 
> > 	These changes is the result of the discussion with Paul Walmsley.
> > 	His ideas are included into this patch.
> > 
> > 	Remove DPLL output divider handling from DPLLs and CLKOUTX2 clocks,
> > 	and place it into specific DPLL output divider clocks (e.g., dpll3_m2_clk).
> > 	omap2_get_dpll_rate() now returns the correct DPLL rate, as represented
> > 	by the DPLL's CLKOUT output. Also add MPU and IVA2 subsystem clocks, along
> > 	with high-frequency bypass support.
> > 
> > 	Add support for DPLLs function in locked and bypass clock modes.
> > 
> > Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> 
> Looks good to me Roman, thanks.
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Pushing today.

Tony
