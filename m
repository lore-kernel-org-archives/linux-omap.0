From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] clk: ti: change clock init to use generic of_clk_init
Date: Wed, 27 Aug 2014 18:15:15 +0300
Message-ID: <53FDF603.6040003@ti.com>
References: <1408628959-32442-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50098 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934891AbaH0PQB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Aug 2014 11:16:01 -0400
In-Reply-To: <1408628959-32442-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Stefan Assmann <sassmann@kpanic.de>

On 08/21/2014 04:49 PM, Tero Kristo wrote:
> Previously, the TI clock driver initialized all the clocks hierarchically
> under each separate clock provider node. Now, each clock that requires
> IO access will instead check their parent node to find out which IO range
> to use.
>
> This patch allows the TI clock driver to use a few new features provided
> by the generic of_clk_init, and also allows registration of clock nodes
> outside the clock hierarchy (for example, any external clocks.)
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Stefan Assmann <sassmann@kpanic.de>

Tested-by: Jyri Sarha <jsarha@ti.com>

