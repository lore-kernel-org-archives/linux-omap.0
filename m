From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch v3 03/10] ARM: OMAP: DRA7xx: Make CAM clock domain SWSUP
 only
Date: Tue, 12 Nov 2019 07:31:04 -0800
Message-ID: <20191112153104.GG5610@atomide.com>
References: <20191112142753.22976-1-bparrot@ti.com>
 <20191112142753.22976-4-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112142753.22976-4-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [191112 14:25]:
> Both CAL and VIP rely on this clock domain. But CAL DPHY require
> LVDSRX_96M_GFCLK to be active. When this domain is set to HWSUP the
> LVDSRX_96M_GFCLK is on;y active when VIP1 clock is also active.  If only
> CAL on DRA72x (which uses the VIP2 clkctrl) probes the CAM domain is
> enabled but the LVDSRX_96M_GFCLK is left gated. Since LVDSRX_96M_GFCLK
> is sourcing the input clock to the DPHY then actual frame capture cannot
> start as the phy are inactive.
> 
> So we either have to also enabled VIP1 even if we don't intend on using
> it or we need to set the CAM domain to use SWSUP only.
> 
> This patch implements the latter.

Best that Tero picks up this one too if OK:

Acked-by: Tony Lindgren <tony@atomide.com>
