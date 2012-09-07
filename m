From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH RESEND] arm/dts: AM33XX: Add SPI device tree data
Date: Fri, 7 Sep 2012 08:59:36 -0400
Message-ID: <20120907125936.GH27758@beef>
References: <1346914815-860-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35831 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab2IGM6k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 08:58:40 -0400
Content-Disposition: inline
In-Reply-To: <1346914815-860-1-git-send-email-avinashphilip@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: linux@arm.linux.org.uk, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gururaja.hebbar@ti.com

On Thu, Sep 06, 2012 at 12:30:15PM +0530, Philip, Avinash wrote:
> Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> as the driver) is reused from OMAP4.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> ---
> Resenting patch because ARM & OMAP mailing list was not copied.
> 
> :100644 100644 bb31bff... 6b469bd... M	arch/arm/boot/dts/am33xx.dtsi
>  arch/arm/boot/dts/am33xx.dtsi |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index bb31bff..6b469bd 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -210,5 +210,30 @@
>  			interrupt-parent = <&intc>;
>  			interrupts = <91>;
>  		};
> +
> +		spi0: spi@48030000 {
> +			compatible = "ti,omap4-mcspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x4830000 0x400>;

Please fix this typo, should be 0x48030000.

With the typo fixed, it's working on bone for me:

Tested-by: Matt Porter <mporter@ti.com>

-Matt
