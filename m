From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 02/13] phy: omap-control: Update DT binding information
Date: Thu, 6 Mar 2014 21:10:27 +0530
Message-ID: <531896EB.1050409@ti.com>
References: <1394116729-28811-1-git-send-email-rogerq@ti.com>
 <1394116729-28811-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394116729-28811-3-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com, balbi@ti.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, balajitk@ti.com, linux-ide@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Felipe,

On Thursday 06 March 2014 08:08 PM, Roger Quadros wrote:
> Move omap-control binding information to the right location.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   Documentation/devicetree/bindings/phy/ti-phy.txt   | 25 ++++++++++++++++++++++

This patch is dependent on

"Documentation: dt bindings: move ..usb/usb-phy.txt to
  ..phy/ti-phy.txt"

which got merged in your tree. So can you take this patch also?
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Regards
Kishon

>   Documentation/devicetree/bindings/usb/omap-usb.txt | 24 ---------------------
>   2 files changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index f671163..5c5b1b0 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -1,5 +1,30 @@
>   TI PHY: DT DOCUMENTATION FOR PHYs in TI PLATFORMs
>
> +OMAP CONTROL PHY
> +
> +Required properties:
> + - compatible: Should be one of
> + "ti,control-phy-otghs" - if it has otghs_control mailbox register as on OMAP4.
> + "ti,control-phy-usb2" - if it has Power down bit in control_dev_conf register
> +                        e.g. USB2_PHY on OMAP5.
> + "ti,control-phy-pipe3" - if it has DPLL and individual Rx & Tx power control
> +                        e.g. USB3 PHY and SATA PHY on OMAP5.
> + "ti,control-phy-dra7usb2" - if it has power down register like USB2 PHY on
> +                        DRA7 platform.
> + "ti,control-phy-am437usb2" - if it has power down register like USB2 PHY on
> +                        AM437 platform.
> + - reg : Address and length of the register set for the device. It contains
> +   the address of "otghs_control" for control-phy-otghs or "power" register
> +   for other types.
> + - reg-names: should be "otghs_control" control-phy-otghs and "power" for
> +   other types.
> +
> +omap_control_usb: omap-control-usb@4a002300 {
> +        compatible = "ti,control-phy-otghs";
> +        reg = <0x4a00233c 0x4>;
> +        reg-names = "otghs_control";
> +};
> +
>   OMAP USB2 PHY
>
>   Required properties:
> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
> index c495135..38b2fae 100644
> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> @@ -76,27 +76,3 @@ omap_dwc3 {
>   	ranges;
>   };
>
> -OMAP CONTROL USB
> -
> -Required properties:
> - - compatible: Should be one of
> - "ti,control-phy-otghs" - if it has otghs_control mailbox register as on OMAP4.
> - "ti,control-phy-usb2" - if it has Power down bit in control_dev_conf register
> -			e.g. USB2_PHY on OMAP5.
> - "ti,control-phy-pipe3" - if it has DPLL and individual Rx & Tx power control
> -			e.g. USB3 PHY and SATA PHY on OMAP5.
> - "ti,control-phy-dra7usb2" - if it has power down register like USB2 PHY on
> -			DRA7 platform.
> - "ti,control-phy-am437usb2" - if it has power down register like USB2 PHY on
> -			AM437 platform.
> - - reg : Address and length of the register set for the device. It contains
> -   the address of "otghs_control" for control-phy-otghs or "power" register
> -   for other types.
> - - reg-names: should be "otghs_control" control-phy-otghs and "power" for
> -   other types.
> -
> -omap_control_usb: omap-control-usb@4a002300 {
> -	compatible = "ti,control-phy-otghs";
> -	reg = <0x4a00233c 0x4>;
> -	reg-names = "otghs_control";
> -};
>
