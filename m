From: Tony Lindgren <tony@atomide.com>
Subject: Re: clk: ti: clkctrl clock support
Date: Mon, 13 Feb 2017 08:55:22 -0800
Message-ID: <20170213165521.GG21809@atomide.com>
References: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170213 05:24]:
> Hi,
> 
> This series is a derivative of the hwmod clock support framework
> (https://www.spinics.net/lists/arm-kernel/msg536742.html.) This
> adds support for clkctrl main and optional clocks, which can be
> linked initially with hwmod framework, and later with the
> interconnect driver functionality. The implementation is based
> on the DT bindings patch from Tony:
> https://patchwork.kernel.org/patch/9533605/

Probably best to merge that binding patch along with this series,
so feel free to pick it.

Regards,

Tony
