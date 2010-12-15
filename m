From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/5] OMAP4: hwmod & clock data: Fix GPIO opt_clks and
 ocp_if iclk
Date: Tue, 14 Dec 2010 18:10:35 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012141810030.15971@utopia.booyaka.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com> <1291937615-18571-6-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43922 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760433Ab0LOBKg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 20:10:36 -0500
In-Reply-To: <1291937615-18571-6-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Fri, 10 Dec 2010, Benoit Cousson wrote:

> Fix opt clocks name in clock framework and hwmod.
> 
> Add the missing iclk in the ocp_if structure.
> 
> Add the HWMOD_CONTROL_OPT_CLKS_IN_RESET flag to ensure
> the the GPIO optional clock is enable during reset.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Tested-by: Charulatha V <charu@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

This one I just tweaked the commit message slightly on.  Revised message 
is below.


- Paul


    OMAP4: hwmod & clock data: Fix GPIO opt_clks and ocp_if iclk
    
    Fix opt clocks name in clock framework and hwmod.
    
    Add the missing iclk in the ocp_if structure.
    
    Add the HWMOD_CONTROL_OPT_CLKS_IN_RESET flag to ensure
    that the GPIO optional clock is enabled during reset, since
    it must be enabled for the IP block to reset successfully.
    
    Signed-off-by: Benoit Cousson <b-cousson@ti.com>
    Tested-by: Charulatha V <charu@ti.com>
    [paul@pwsan.com: fix the commit message]
    Signed-off-by: Paul Walmsley <paul@pwsan.com>
    Cc: Rajendra Nayak <rnayak@ti.com>

