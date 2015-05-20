From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv2 02/27] clk: ti: move generic OMAP DPLL implementation
 under drivers/clk
Date: Wed, 20 May 2015 11:23:19 -0700
Message-ID: <20150520182319.GD4815@codeaurora.org>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
 <1431334493-24455-3-git-send-email-t-kristo@ti.com>
 <20150520012053.GC31054@codeaurora.org>
 <555CC7CA.2090104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37185 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbbETSXV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2015 14:23:21 -0400
Content-Disposition: inline
In-Reply-To: <555CC7CA.2090104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 05/20, Tero Kristo wrote:
> On 05/20/2015 04:20 AM, Stephen Boyd wrote:
> >On 05/11, Tero Kristo wrote:
> >>With the legacy clock data now gone, we can start moving OMAP clock
> >>type implementations under clock driver. Start this with moving the
> >>generic OMAP DPLL clock type under TI clock driver.
> >>
> >>Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >>---
> >
> >How much of the code is the same from the original copy? Can you
> >generate these patches with -M -C so that we can see?
> 
> Looks like for the move patches the range is from 85%...95% exact
> copy. Shall I repost the patches in this format?

Sure, a resend would be nice to actually see what changed. If
that's too much mail, maybe you can share the diffstat for the
whole series with -M -C so we can see what's moved instead.

> Good hint for the
> -M -C btw, I wonder why those are not default options for
> git-format-patch.
> 

I think it isn't the default because 'patch' the program didn't
always support the diff format that git generates with the -M and
-C options. FWIW, I have

	[diff] 
		renames = copy

in my .gitconfig for this purpose.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
