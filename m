From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 00/30] ARM: OMAP2+: hwmod module clock type support
Date: Tue, 12 Apr 2016 09:58:19 -0500
Message-ID: <20160412145819.GA25032@rob-hp-laptop>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 11, 2016 at 11:18:51AM +0300, Tero Kristo wrote:
> Hi,
> 
> This series transfers the hwmod clkctrl handling from the hwmod core
> under clock driver, the data is also transferred from hwmod data to
> devicetree. Done for most of the OMAP2+ platforms, except OMAP2 / OMAP3,
> where work is still under progress.

Some high level questions.

Why a DT node per clock? We've pretty much decided that is a bad idea 
in the complex cases. TI chips certainly fall in the complex case.

You are changing compatible strings and possibly breaking compatibility. 
Don't do that or justify why.

Rob
