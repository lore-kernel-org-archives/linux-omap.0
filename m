From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCHv2 03/28] ARM: OMAP2+: omap_device: create clock
 alias purely from DT data
Date: Tue, 28 Jun 2016 00:00:12 -0700
Message-ID: <20160628070011.GD28140@atomide.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465844702-12200-4-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160613 12:07]:
> This avoids the need to add most of the clock aliases under
> drivers/clk/ti/clk-xyz.c files.

This is a nice improvment, probably best to queu this along
with the rest of the series via the clock tree:

Acked-by: Tony Lindgren <tony@atomide.com>

Or please let me know if you want me to pick this separately.

Regards,

Tony
