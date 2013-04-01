From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: dpll: enable bypass clock only when attempting
 dpll bypass
Date: Mon, 1 Apr 2013 10:27:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304010211430.28273@utopia.booyaka.com>
References: <1364468381-10560-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39214 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757483Ab3DAK1w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 06:27:52 -0400
In-Reply-To: <1364468381-10560-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com

On Thu, 28 Mar 2013, Rajendra Nayak wrote:

> omap3_noncore_dpll_set_rate() attempts an enable of bypass clk as well
> as ref clk for every .set_rate attempt on a noncore DPLL, regardless of
> whether the .set_rate results in the DPLL being locked or put in bypass.
> Early at boot, while some of these DPLLs are programmed and locked
> (using .set_rate for the DPLL), this causes an ordering issue.
> 
> For instance, on OMAP5, the USB DPLL derives its bypass clk from ABE DPLL.
> If a .set_rate of USB DPLL which programmes the M,N and locks it is called
> before the one for ABE, the enable of USB bypass clk (derived from ABE DPLL)
> then attempts to lock the ABE DPLL and fails as the M,N values for ABE
> are yet to be programmed.
> 
> To get rid of this ordering needs, enable bypass clk for a DPLL as part
> of its .set_rate only when its being put in bypass, and only enable the
> ref clk when its locked.
> 
> Reported-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for 3.10.  


- Paul
