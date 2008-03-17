From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH]  New DPLL clock framework.
Date: Mon, 17 Mar 2008 15:28:39 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0803171456150.31844@utopia.booyaka.com>
References: <1205436909-13213-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36203 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbYCQV2k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 17:28:40 -0400
In-Reply-To: <1205436909-13213-1-git-send-email-roman.tereshonkov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Cc: linux-omap@vger.kernel.org

On Thu, 13 Mar 2008, Roman Tereshonkov wrote:

> 	These changes is the result of the discussion with Paul Walmsley.
> 	His ideas are included into this patch.
> 
> 	Remove DPLL output divider handling from DPLLs and CLKOUTX2 clocks,
> 	and place it into specific DPLL output divider clocks (e.g., dpll3_m2_clk).
> 	omap2_get_dpll_rate() now returns the correct DPLL rate, as represented
> 	by the DPLL's CLKOUT output. Also add MPU and IVA2 subsystem clocks, along
> 	with high-frequency bypass support.
> 
> 	Add support for DPLLs function in locked and bypass clock modes.
> 
> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>

Looks good to me Roman, thanks.

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
