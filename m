From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3] clk: ti: omap36xx: Work around sprz319 advisory 2.1
Date: Thu, 8 Dec 2016 13:16:01 -0800
Message-ID: <20161208211601.GK5423@codeaurora.org>
References: <1480713278-6884-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480713278-6884-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-clk-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Richard Watts <rrw@kynesim.co.uk>, Tony Lindgren <tony@atomide.com>, Alexander Kinzer <a.kinzer@plusoptix.de>
List-Id: linux-omap@vger.kernel.org

On 12/02, Laurent Pinchart wrote:
> From: Richard Watts <rrw@kynesim.co.uk>
> 
> The OMAP36xx DPLL5, driving EHCI USB, can be subject to a long-term
> frequency drift. The frequency drift magnitude depends on the VCO update
> rate, which is inversely proportional to the PLL divider. The kernel
> DPLL configuration code results in a high value for the divider, leading
> to a long term drift high enough to cause USB transmission errors. In
> the worst case the USB PHY's ULPI interface can stop responding,
> breaking USB operation completely. This manifests itself on the
> Beagleboard xM by the LAN9514 reporting 'Cannot enable port 2. Maybe the
> cable is bad?' in the kernel log.
> 
> Errata sprz319 advisory 2.1 documents PLL values that minimize the
> drift. Use them automatically when DPLL5 is used for USB operation,
> which we detect based on the requested clock rate. The clock framework
> will still compute the PLL parameters and resulting rate as usual, but
> the PLL M and N values will then be overridden. This can result in the
> effective clock rate being slightly different than the rate cached by
> the clock framework, but won't cause any adverse effect to USB
> operation.
> 
> Signed-off-by: Richard Watts <rrw@kynesim.co.uk>
> [Upported from v3.2 to v4.9]
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
