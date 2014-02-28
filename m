From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/12] ARM: OMAP2 DT clock conversion
Date: Fri, 28 Feb 2014 10:33:14 -0800
Message-ID: <20140228183313.GD15399@atomide.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
 <5310B271.5040708@ti.com>
 <20140228180112.GC15399@atomide.com>
 <5310D2FE.5090209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53568 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaB1Sd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 13:33:27 -0500
Content-Disposition: inline
In-Reply-To: <5310D2FE.5090209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [140228 10:21]:
> 
> Hmm, some clock node is broken, might be missing a name or parent
> name for some reason. Can you try to boot with DEBUG enabled so you
> get pr_debug:s out and see which clock is being initialized during
> the crash?

...
[    0.000000] ti_dt_clk_init_provider: ti_dt_clk_init_provider: initializing: core_d18_ck
[    0.000000] ti_dt_clk_init_provider: ti_dt_clk_init_provider: initializing: vlynq_mux_fck
[    0.000000] ti_dt_clk_init_provider: ti_dt_clk_init_provider: initializing: vlynq_fck
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
...

We really should be registering the clocks lazily as needed BTW. That
leaves out the dependency to DEBUG_LL for seeing any kind of decent
error messages during the booting.

Regards,

Tony
