From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
Date: Mon, 12 Dec 2016 17:37:48 -0800
Message-ID: <20161213013748.GS4920@atomide.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <20161028005341.GR26139@codeaurora.org>
 <2cfa10a9-9ea0-23e4-30de-9aece13e47e3@ti.com>
 <20161028233750.GQ16026@codeaurora.org>
 <7371ef35-5d95-bf78-4c97-c61091a1fa4b@ti.com>
 <148156710975.37646.2957511113527634913@resonance>
 <20161213004914.GM5423@codeaurora.org>
 <20161213013133.GR4920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161213013133.GR4920@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [161212 17:33]:
> 
> So we just need the clockdomain clock nodes, then each clock output is
> just offset from that clockdomain. And we can have readable defines
> for the offsets. That's all there should be to it.

And we actually have already have the clock-output-names property so
no need to define anything for the clockdomain clock outputs I guess.

Regards,

Tony
