From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCHv2 09/28] ARM: AM33xx: fix module_wait_ready
 without clkctrl register
Date: Tue, 28 Jun 2016 00:08:04 -0700
Message-ID: <20160628070803.GH28140@atomide.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-10-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465844702-12200-10-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160613 12:08]:
> If the module has no clkctrl register defined, module_wait_ready should
> not try to access this. This can potentially cause an illegal register
> access, and result in bad idle reporting also.

Acked-by: Tony Lindgren <tony@atomide.com>

Seems at least this one I could take separately. Probably best
that we merge the arch/arm/mach-omap2 changes first that can be
done until there's some conclusion to the ti_clk_get() comments
I made.

Regards,

Tony
