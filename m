From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] clk: ti: Drop legacy clk-3xxx-legacy code
Date: Thu, 21 Dec 2017 07:49:41 -0800
Message-ID: <20171221154941.GU3875@atomide.com>
References: <20171214152753.678-1-tony@atomide.com>
 <1c5b0cf2-7b7d-36b6-2cb9-deca282ba3b3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1c5b0cf2-7b7d-36b6-2cb9-deca282ba3b3@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [171220 12:46]:
> On 14/12/17 17:27, Tony Lindgren wrote:
> > We have now had omap3 booting in device tree only mode for a while
> > and all this code is unused.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> > 
> > Looks like the patch was too big for the lists as it removes
> > drivers/clk/ti/clk-3xxx-legacy.c. Here's a resend with patch
> > edited to leave out changes to drivers/clk/ti/clk-3xxx-legacy.c
> > for mailing list review.
> > 
> > I'll send a pull request for this if it looks OK otherwise.
> 
> Seems fine to me, I also verified it doesn't conflict anything in the build
> against the clkctrl changes.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

OK thanks will send a pull request for this to Mike and Stephen
in a separate email.

Regards,

Tony
