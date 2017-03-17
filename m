From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 6/9] ARM: OMAP2+: timer: add support for fetching fck
 handle from DT
Date: Fri, 17 Mar 2017 08:41:57 -0700
Message-ID: <20170317154156.GV20572@atomide.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489741781-12816-7-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170317 02:12]:
> The mux clock handle shall be provided via "fck" DT handle. This avoids
> the need to lookup the main clock via hwmod core, which will not work
> with the clkctrl clock support anymore; the main clock is not going to
> be a mux.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
