From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] ARM: dts: AM572x-IDK Initial Support
Date: Mon, 28 Mar 2016 16:10:15 -0500
Message-ID: <20160328211015.GA28249@rob-hp-laptop>
References: <1459182909-23502-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459182909-23502-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 28, 2016 at 11:35:09AM -0500, Nishanth Menon wrote:
> From: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
> 
> The AM572x-IDK board is a board based on TI's AM5728 SOC
> which has a dual core 1.5GHz A15 processor. This board is a
> development platform for the Industrial market with:
> - 2GB of DDR3L
> - Dual 1Gbps Ethernet
> - HDMI,
> - PRU-ICSS
> - uSD
> - 16GB eMMC
> - CAN
> - RS-485
> - PCIe
> - USB3.0
> - Video Input Port
> - Industrial IO port and expansion connector
> 
> The link to the data sheet and TRM can be found here:
> 
> http://www.ti.com/product/AM5728
> 
> This patch creates a common dtsi file that will provide a common board
> dtsi file to define the nodes that are common to AM57xx (including the
> upcoming AM5718) IDK boards.
> 
> Initial support is only for basic peripherals
> 
> Signed-off-by: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
> based on v4.6-rc1
> 
> Changes since V1:
> 	- Renamed the led nodes
> 	- Dropped unused src_clk_x1 node (will introduce when needed).
> 
> Test: http://pastebin.ubuntu.com/15540747/
> 
> V1: https://patchwork.kernel.org/patch/8665181/
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/am572x-idk.dts                   |  85 ++++++
>  arch/arm/boot/dts/am57xx-idk-common.dtsi           | 302 +++++++++++++++++++++
>  4 files changed, 391 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am572x-idk.dts
>  create mode 100644 arch/arm/boot/dts/am57xx-idk-common.dtsi

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
