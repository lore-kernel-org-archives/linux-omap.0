From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCHv2 06/28] ARM: OMAP2+: hwmod: fetch main_clk based
 on hwmod name
Date: Tue, 28 Jun 2016 00:03:54 -0700
Message-ID: <20160628070354.GE28140@atomide.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465844702-12200-7-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160613 12:07]:
> With the transition to hwmod module clocks, all hwmods will have
> their main clocks named <hwmod_name>_mod_ck. Use this info to
> fetch main_clk, and use it if found.
> 
> Also, if a main_clk is found based on the hwmod name, disable
> the direct PRCM modulemode access from hwmod.

Makes sense, otherwise unknown number of things will break before
we have the clock phandles available in the dts files for these:

Acked-by: Tony Lindgren <tony@atomide.com>

Or let me know if you want me to queue this separately.

Regards,

Tony
