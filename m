From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] clk: ti: omap3+: dpll: use non-locking version of
 clk_get_rate
Date: Mon, 22 Feb 2016 08:52:53 -0800
Message-ID: <20160222165252.GF13417@atomide.com>
References: <1455966777-30576-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455966777-30576-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160220 03:12]:
> As the code in this file is being executed within irq context in some
> cases, we must avoid the clk_get_rate which uses mutex internally.
> Switch the code to use clk_hw_get_rate instead which is non-locking.
> 
> This fixes an issue where PM runtime will hang the system if enabled
> with a serial console before a suspend-resume cycle.

Can you please add the "Fixes: " line here?

And when applying, please tag this one Cc stable.

Other than that, please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
