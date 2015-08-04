From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: dra7: Add syscon-pllreset syscon to
 SATA PHY
Date: Tue, 4 Aug 2015 11:19:09 +0300
Message-ID: <55C0757D.1090306@ti.com>
References: <1437140844-6032-1-git-send-email-rogerq@ti.com> <1437140844-6032-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437140844-6032-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony,

On 17/07/15 16:47, Roger Quadros wrote:
> This register is required to be passed to the SATA PHY driver
> to workaround errata i783 (SATA Lockup After SATA DPLL Unlock/Relock).
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Can you please Ack or pick this for -fixes.
Kishon has already picked patch 1 in this series. Thanks.

cheers,
-roger

> ---
>  arch/arm/boot/dts/dra7.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 8f1e25b..4a0718c 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1140,6 +1140,7 @@
>  				ctrl-module = <&omap_control_sata>;
>  				clocks = <&sys_clkin1>, <&sata_ref_clk>;
>  				clock-names = "sysclk", "refclk";
> +				syscon-pllreset = <&scm_conf 0x3fc>;
>  				#phy-cells = <0>;
>  			};
>  
> 
