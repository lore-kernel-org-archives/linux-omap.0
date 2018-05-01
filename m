From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 09/16] bus: ti-sysc: Add handling for clkctrl opt clocks
Date: Tue, 1 May 2018 08:39:06 -0500
Message-ID: <20180501133906.GA18650@rob-hp-laptop>
References: <20180423174549.57412-1-tony@atomide.com>
 <20180423174549.57412-10-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180423174549.57412-10-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 23, 2018 at 10:45:42AM -0700, Tony Lindgren wrote:
> There can be up to eight optional device functional gate gate clocks for
> each clkctrl instance in clkctrl register bits 8 to 15. Some of them are
> only needed for module level reset while others may always be needed
> during use. Let's add support for those and update the binding doc
> accordingly.
> 
> Note that the optional clkctrl mux and divider clocks starting at bit 20
> can be directly mapped to the child devices, and ti-sysc does not need to
> manage those.
> 
> And as GPIOs need the optional clocks for reset, we can now add it with
> SYSC_QUIRK_OPT_CLKS_IN_RESET.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/bus/ti-sysc.txt       |   6 +-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/bus/ti-sysc.c                         | 140 ++++++++++++++----
>  2 files changed, 120 insertions(+), 26 deletions(-)
