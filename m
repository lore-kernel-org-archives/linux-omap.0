From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] clk: ti: change clock init to use generic of_clk_init
Date: Fri, 19 Sep 2014 16:33:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409191632170.22526@utopia.booyaka.com>
References: <1408628959-32442-1-git-send-email-t-kristo@ti.com> <20140918171725.GL14505@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58662 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbaISQdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2014 12:33:13 -0400
In-Reply-To: <20140918171725.GL14505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Stefan Assmann <sassmann@kpanic.de>

On Thu, 18 Sep 2014, Tony Lindgren wrote:

> * Tero Kristo <t-kristo@ti.com> [140821 06:52]:
> > Previously, the TI clock driver initialized all the clocks hierarchically
> > under each separate clock provider node. Now, each clock that requires
> > IO access will instead check their parent node to find out which IO range
> > to use.
> > 
> > This patch allows the TI clock driver to use a few new features provided
> > by the generic of_clk_init, and also allows registration of clock nodes
> > outside the clock hierarchy (for example, any external clocks.)
> 
> Paul, any comments on this one?

Not at this point.


- Paul
