From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 0/9] clk: ti: add support for clkctrl clocks
Date: Fri, 17 Mar 2017 08:25:37 -0700
Message-ID: <20170317152536.GT20572@atomide.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170317 02:12]:
> Any additional testing on omap4 welcome as this series basically
> tweaks every possible peripheral clock on the SoC.

Without the last patch in this series, booting fails for me:

[    5.074890] l4_per_cm:clk:0120:0: failed to disable
[    5.085113] l4_per_cm:clk:0128:0: failed to disable

Care to check that booting keeps working for each patch in the
series to avoid breaking git bisect for booting?

Regards,

Tony
