From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v4 REPOST 4/5] highbank: Unconditionally require l2x0 L2
 cache controller support
Date: Wed, 14 Dec 2011 13:55:13 +0000
Message-ID: <20111214135513.GC2568@linaro.org>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-5-git-send-email-dave.martin@linaro.org>
 <4EE8A69C.40304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45960 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab1LNNzU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 08:55:20 -0500
Content-Disposition: inline
In-Reply-To: <4EE8A69C.40304@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, Anton Vorontsov <avorontsov@mvista.com>, Barry Song <baohua.song@csr.com>, Catalin Marinas <catalin.marinas@arm.com>, Colin Cross <ccross@google.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Pawel Moll <pawel.moll@arm.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>

On Wed, Dec 14, 2011 at 07:37:32AM -0600, Rob Herring wrote:
> 
> On 12/14/2011 05:39 AM, Dave Martin wrote:
> > If running in the Normal World on a TrustZone-enabled SoC, Linux
> > does not have complete control over the L2 cache controller
> > configuration.  The kernel cannot work reliably on such platforms
> > without the l2x0 cache support code built in.
> > 
> > This patch unconditionally enables l2x0 support for the Highbank
> > SoC.
> > 
> > Thanks to Rob Herring for this suggestion. [1]
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > 
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html
> 
> Doesn't this need to be above the SOB? Otherwise:

You may be right ... certainly I see no reason _not_ to change it.
So I'll change it.

> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Thanks

---Dave
