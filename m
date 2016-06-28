From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCHv2 07/28] ARM: OMAP2+: timer: change order of hwmod
 data handling
Date: Tue, 28 Jun 2016 00:04:58 -0700
Message-ID: <20160628070457.GF28140@atomide.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-8-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465844702-12200-8-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160613 12:07]:
> With the introduction of hwmod module clocks, the name of the hwmod
> main clk may not be available before hwmod setup, as hwmod setup
> may lookup the main clock dynamically based on the hwmod name.
> Thus, change the order of hwmod setup and main clock handling for
> the timer code, to make sure the main clock is going to be
> available.

Acked-by: Tony Lindgren <tony@atomidme.com>

Also for this one, please let me know if this can be picked
separately.

Tony
