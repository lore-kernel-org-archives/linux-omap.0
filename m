From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 4/4] ARM: dts: dra7: add OCP2SCP3 and SATA nodes
Date: Wed, 7 May 2014 11:14:48 +0300
Message-ID: <5369EB78.7080105@ti.com>
References: <1398274237-24510-1-git-send-email-rogerq@ti.com> <1398274575-24818-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398274575-24818-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, R Sricharan <r.sricharan-l0cyMroinI0@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony,

On 04/23/2014 08:36 PM, Roger Quadros wrote:
> From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> 
> Add nodes for OCP2SCP3 bus, SATA controller and SATA PHY.
> 
> [Roger Q] Clean up.
> 
> CC: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 1c0f8e1..084f42e 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -789,6 +789,45 @@
>  			dma-names = "tx0", "rx0";
>  			status = "disabled";
>  		};
> +
> +		omap_control_sata: control-phy@4a002374 {
> +			compatible = "ti,control-phy-pipe3";
> +			reg = <0x4a002374 0x4>;
> +			reg-names = "power";
> +			clocks = <&sys_clkin1>;
> +			clock-names = "sysclk";
> +		};
> +
> +		/* OCP2SCP3 */
> +		ocp2scp@4a090000 {
> +			compatible = "ti,omap-ocp2scp";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			reg = <0x4a090000 0x20>;
> +			ti,hwmods = "ocp2scp3";
> +			sata_phy: phy@4A096000 {
> +				compatible = "ti,phy-pipe3-sata";
> +				reg = <0x4A096000 0x80>, /* phy_rx */
> +				      <0x4A096400 0x64>, /* phy_tx */
> +				      <0x4A096800 0x40>; /* pll_ctrl */
> +				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
> +				ctrl-module = <&omap_control_sata>;
> +				clocks = <&sys_clkin1>;
> +				clock-names = "sysclk";
> +				#phy-cells = <0>;
> +			};
> +		};
> +
> +		sata: sata@4a141100 {
> +			compatible = "snps,dwc-ahci";
> +			reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
> +			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;

This will need to be changed like so if the IRQ crossbar changes [1] go in 

+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;

cheers,
-roger

[1] - http://article.gmane.org/gmane.linux.documentation/23293

> +			phys = <&sata_phy>;
> +			phy-names = "sata-phy";
> +			clocks = <&sata_ref_clk>;
> +			ti,hwmods = "sata";
> +		};
>  	};
>  };
>  
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
