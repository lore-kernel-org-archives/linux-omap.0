From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCHv3] phy: cpcap-usb: Add CPCAP PMIC USB support
Date: Mon, 8 May 2017 11:50:01 +0530
Message-ID: <9bfee59a-faba-3f48-1234-2a5496b3fc14@ti.com>
References: <20170410041958.21269-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170410041958.21269-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Monday 10 April 2017 09:49 AM, Tony Lindgren wrote:
> Some Motorola phones like droid 4 use a custom CPCAP PMIC that has a
> multiplexing USB PHY.
> 
> This USB PHY can operate at least in four modes using pin multiplexing
> and two control GPIOS:
> 
> - Pass through companion PHY for the SoC USB PHY
> - ULPI PHY for the SoC
> - Pass through USB for the modem
> - UART debug console for the SoC
> 
> This patch adds support for droid 4 USB PHY and debug UART modes,
> support for other modes can be added later on as needed.
> 
> Both peripheral and host mode are working for the USB. The
> host mode depends on the cpcap-charger driver for VBUS.
> 
> VBUS and ID pin detection are done using cpcap-adc IIO ADC
> driver.

I thought of using EXTCON differently from what was used below. Actually I
thought EXTCON shuld be used in cpcap-adc driver for notifying VBUS or ID
events to phy-cpcap driver which performs the various setting based on VBUS or
ID. (See drivers/usb/dwc3/dwc3-omap.c which receives VBUS/ID notifications fo
sample). That would have simply replaced the iio* calls with EXTCON calls in
phy-cpcap-usb driver (in addition to adding extcon API's in cpcap-adc driver).

Usage of EXTCON like below is not of much use here since MUSB doesn't really
wait for notification of ID or VBUS events (This is unlike dwc3-omap. since we
invoke musb_mailbox functin directly).

If adding EXTCON in cpcap-adc isn't simple then we should stick to your patch
version 2 since extcon support in this version is not useful IMO.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Tested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v2:
> - Added extcon support as requested by Kishon
> 
> - Added Rob's ack
> 
> - Folded in Kconfig randconfig build fix to add depends on IIO
> 
> Changes since v1:
> - Use iio_read_channel_processed() instead of iio_read_channel_scaled()
>   as changed in the v2 of the ADC driver
> 
> - Kept Tested-by from Sebastian Reichel <sre@kernel.org> as the change
>   from v1 is trivial
> 
> ---
>  .../devicetree/bindings/phy/phy-cpcap-usb.txt      |  40 ++
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-cpcap-usb.c                        | 734 +++++++++++++++++++++
>  4 files changed, 783 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cpcap-usb.txt
>  create mode 100644 drivers/phy/phy-cpcap-usb.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cpcap-usb.txt b/Documentation/devicetree/bindings/phy/phy-cpcap-usb.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-cpcap-usb.txt
> @@ -0,0 +1,40 @@
> +Motorola CPCAP PMIC USB PHY binding
> +
> +Required properties:
> +compatible: Shall be either "motorola,cpcap-usb-phy" or
> +	    "motorola,mapphone-cpcap-usb-phy"
> +#phy-cells: Shall be 0
> +interrupts: CPCAP PMIC interrupts used by the USB PHY
> +interrupt-names: Interrupt names
> +io-channels: IIO ADC channels used by the USB PHY
> +io-channel-names: IIO ADC channel names
> +vusb-supply: Regulator for the PHY
> +
> +Optional properties:
> +pinctrl: Optional alternate pin modes for the PHY
> +pinctrl-names: Names for optional pin modes
> +mode-gpios: Optional GPIOs for configuring alternate modes
> +
> +Example:
> +cpcap_usb2_phy: phy {
> +	compatible = "motorola,mapphone-cpcap-usb-phy";
> +	pinctrl-0 = <&usb_gpio_mux_sel1 &usb_gpio_mux_sel2>;
> +	pinctrl-1 = <&usb_ulpi_pins>;
> +	pinctrl-2 = <&usb_utmi_pins>;
> +	pinctrl-3 = <&uart3_pins>;
> +	pinctrl-names = "default", "ulpi", "utmi", "uart";
> +	#phy-cells = <0>;
> +	interrupts-extended = <
> +		&cpcap 15 0 &cpcap 14 0 &cpcap 28 0 &cpcap 19 0
> +		&cpcap 18 0 &cpcap 17 0 &cpcap 16 0 &cpcap 49 0
> +		&cpcap 48 1
> +	>;
> +	interrupt-names =
> +		"id_ground", "id_float", "se0conn", "vbusvld",
> +		"sessvld", "sessend", "se1", "dm", "dp";
> +	mode-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH
> +		      &gpio1 0 GPIO_ACTIVE_HIGH>;
> +	io-channels = <&cpcap_adc 2>, <&cpcap_adc 7>;
> +	io-channel-names = "vbus", "id";
> +	vusb-supply = <&vusb>;
> +};

I would have preferred this to be a separate patch but since Rob has Acked it,
it is fine.

Thanks
Kishon
