From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: dra7: Add dt node for the sycon pcie
Date: Mon, 12 Oct 2015 14:21:49 -0700
Message-ID: <20151012212149.GZ23801@atomide.com>
References: <1442323985-29939-1-git-send-email-kishon@ti.com>
 <1442323985-29939-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442323985-29939-2-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nsekhar@ti.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [150915 06:37]:
> Add new device tree node for the control module register space where
> PCIe registers are present.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 5d65db9..0769b5d 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -154,6 +154,11 @@
>  					compatible = "syscon";
>  					reg = <0x1c04 0x0020>;
>  				};
> +
> +				scm_conf_pcie: tisyscon@1c24 {
> +					compatible = "syscon";
> +					reg = <0x1c24 0x0024>;
> +				};
>  			};
>  
>  			cm_core_aon: cm_core_aon@5000 {


Why don't you just extend the existing scm_conf1 area? This is not all pcie
specific for scm_conf_pcie, at least for PLLEN_CONTROL, RMII_CLK_SETTING
and MUXSEL_32K_CLKIN.

Regards,

Tony
