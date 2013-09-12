From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 6/7] arm/dts: added dt properties to adapt to the new
 phy framwork
Date: Thu, 12 Sep 2013 16:28:41 +0300
Message-ID: <5231C189.2040406@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
 <1378136591-7463-7-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1378136591-7463-7-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, george.cherian@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, s.nawrocki@samsung.com, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, linux-usb@vger.kernel.org, balbi@ti.com, bcousson@baylibre.com, galak@codeaurora.org, grant.likely@linaro.org, rob@landley.net, linux-arm-kernel@lists.infradead.org, ian.campbell@citrix.com
List-Id: linux-omap@vger.kernel.org

Hi,

Need some commit log.

cheers,
-roger

On 09/02/2013 06:43 PM, Kishon Vijay Abraham I wrote:
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 94abef5..9fe71ff 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -651,7 +651,8 @@
>  				compatible = "snps,dwc3";
>  				reg = <0x4a030000 0x10000>;
>  				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> -				usb-phy = <&usb2_phy>, <&usb3_phy>;
> +				phys = <&usb2_phy>, <&usb3_phy>;
> +				phy-names = "usb2-phy", "usb3-phy";
>  				tx-fifo-resize;
>  			};
>  		};
> @@ -667,6 +668,7 @@
>  				compatible = "ti,omap-usb2";
>  				reg = <0x4a084000 0x7c>;
>  				ctrl-module = <&omap_control_usb2phy>;
> +				#phy-cells = <0>;
>  			};
>  
>  			usb3_phy: usb3phy@4a084400 {
> @@ -676,6 +678,7 @@
>  				      <0x4a084c00 0x40>;
>  				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
>  				ctrl-module = <&omap_control_usb3phy>;
> +				#phy-cells = <0>;
>  			};
>  		};
>  
> 
