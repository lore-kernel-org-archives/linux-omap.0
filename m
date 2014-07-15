From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RESEND PATCH 0/8] arm: dts: dra7: Add PCIe data and PCIe PHY
 data
Date: Tue, 15 Jul 2014 00:18:59 -0700
Message-ID: <20140715071859.GL20068@atomide.com>
References: <1405334543-25509-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405334543-25509-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [140714 03:44]:
> [1] is split into separate series in order for individual subsystem
> Maintainers to pick up the patches. This series handles the PCIe
> dt data for DRA7.
> 
> This series has better commit logs than the previous one modified as
> suggested by Tero.
> 
> [1] -> https://lkml.org/lkml/2014/5/29/258
> 
> Keerthy (2):
>   ARM: dts: dra7xx-clocks: Add divider table to optfclk_pciephy_div
>     clock
>   ARM: dts: dra7xx-clocks: Change the parent of apll_pcie_in_clk_mux to
>     dpll_pcie_ref_m2ldo_ck
> 
> Kishon Vijay Abraham I (6):
>   ARM: dts: dra7xx-clocks: Add missing 32KHz clocks used for PHY
>   ARM: dts: dra7xx-clocks: rename pcie clocks to accommodate second PHY
>     instance
>   ARM: dts: dra7xx-clocks: Add missing clocks for second PCIe PHY
>     instance
>   ARM: dts: dra7: Add dt data for PCIe PHY control module
>   ARM: dts: dra7: Add dt data for PCIe PHY
>   ARM: dts: dra7: Add dt data for PCIe controller
> 
>  arch/arm/boot/dts/dra7.dtsi          |  127 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/dra7xx-clocks.dtsi |   39 ++++++++++-
>  2 files changed, 163 insertions(+), 3 deletions(-)

Applying this series into omap-for-v3.17/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
