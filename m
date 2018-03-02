From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCHv2] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Fri, 2 Mar 2018 13:33:42 +0530
Message-ID: <b39478ec-35ba-d288-bb03-28dda5544e80@ti.com>
References: <20180301035057.37584-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180301035057.37584-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Thursday 01 March 2018 09:20 AM, Tony Lindgren wrote:
> Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> It is used on some Motorola Mapphone series of phones and tablets such
> as Droid 4.

Generally PHY configuration is done for the PHYs that is connected to the USB
controllers in the SoC. In that sense it differs from the usual case by
programming the PHY in the device.
> 
> The MDM6600 is hardwired to the first OHCI port in the Droid 4 case, and
> is controlled by several GPIOs. The USB PHY is integrated into the MDM6600
> device it seems. We know this as we get L3 errors from omap-usb-host if
> trying to use the PHY before MDM6600 is configured.

Do you know what phy is connected to the OHCI port. Previously we've seen for
having USB devices on the board itself, phy less configurations was used.
> 
> The GPIOs controlling MDM6600 are used to power device on and off, to
> configure the USB start-up mode (normal mode versus USB flashing), and
> they also tell the state of the MDM6600 device.
> 
> The two start-up mode GPIOs are dual-purposed and used for out of band
> (OOB) wake-up for USB and TS 27.010 serial mux. But we need to configure
> the USB start-up mode first to get MDM6600 booted in the right mode to
> be usable in the first place.
> 
> Note that the Motorola Mapphone Linux kernel tree has a "radio-ctrl"
> driver for modems. But it really does not control the radio at all, it
> just controls the modem power and start-up mode for USB. So I came to
> the conclusion that we're better off having this done in the USB PHY
> driver. For adding support for USB flashing mode, we can later on add
> a kernel module option for flash_mode=1 or something similar.
> 
> Also note that currently there is no PM runtime support for the OHCI
> on omap variant SoCs. So for low(er) power idle states, currenty both
> ohci-platform and phy-mapphone-mdm6600 must be unloaded or unbound.
> 
> For reference here is what I measured for total power consumption on
> an idle Droid 4 with and without USB related MDM6600 modules:
> 
> idle lcd off	phy-mapphone-mdm6600	ohci-platform
> 153mW		284mW			344mW
> 
> So it seems that MDM6600 is currently not yet idling even with it's
> radio turned off, but that's something that is beyond the control of
> this USB PHY driver. This patch does get us to the point where modem
> data and GPS are usable with libqmi and ModemManager for example.
> Voice calls need more audio driver work.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> - Fixed up issues noticed by Rob and Sebastian
> - Implemented wake irq handler (for debug use only for now)
> - Improved error handling based on more testing
> 
> ---
>  .../bindings/phy/phy-mapphone-mdm6600.txt          |  30 ++
>  drivers/phy/motorola/Kconfig                       |   9 +
>  drivers/phy/motorola/Makefile                      |   1 +
>  drivers/phy/motorola/phy-mapphone-mdm6600.c        | 556 +++++++++++++++++++++
>  4 files changed, 596 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
>  create mode 100644 drivers/phy/motorola/phy-mapphone-mdm6600.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt b/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
> @@ -0,0 +1,30 @@
> +Device tree binding documentation for Motorola Mapphone MDM6600 USB PHY
> +
> +Required properties:
> +- compatible		Must be "motorola,mapphone-mdm6600"
> +- enable-gpios		GPIO to enable the USB PHY
> +- power-gpios		GPIO to power on the device
> +- reset-gpios		GPIO to reset the device
> +- motorola,mode-gpios	Two GPIOs to configure MDM6600 USB start-up mode for
> +			normal mode versus USB flashing mode
> +- motorola,cmd-gpios	Three GPIOs to control the power state of the MDM6600
> +- motorola,status-gpios	Three GPIOs to read the power state of the MDM6600
> +
> +Example:
> +
> +usb-phy {
> +	compatible = "motorola,mapphone-mdm6600";
> +	enable-gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;
> +	power-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
> +	reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
> +	motorola,mode-gpios = <&gpio5 20 GPIO_ACTIVE_HIGH>,
> +			      <&gpio5 21 GPIO_ACTIVE_HIGH>;
> +	motorola,cmd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>,
> +			     <&gpio4 8 GPIO_ACTIVE_HIGH>,
> +			     <&gpio5 14 GPIO_ACTIVE_HIGH>;
> +	motorola,status-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>,
> +				<&gpio2 21 GPIO_ACTIVE_HIGH>,
> +				<&gpio2 23 GPIO_ACTIVE_HIGH>;
> +	#phy-cells = <0>;
> +};
> +
> diff --git a/drivers/phy/motorola/Kconfig b/drivers/phy/motorola/Kconfig
> --- a/drivers/phy/motorola/Kconfig
> +++ b/drivers/phy/motorola/Kconfig
> @@ -10,3 +10,12 @@ config PHY_CPCAP_USB
>  	help
>  	  Enable this for USB to work on Motorola phones and tablets
>  	  such as Droid 4.
> +
> +config PHY_MAPPHONE_MDM6600
> +	tristate "Motorola Mapphone MDM6600 modem USB PHY driver"
> +	depends on OF && USB_SUPPORT
> +	select GENERIC_PHY
> +	select USB_PHY
> +	help
> +	  Enable this for MDM6600 USB modem to work on Motorola phones
> +	  and tablets such as Droid 4.
> diff --git a/drivers/phy/motorola/Makefile b/drivers/phy/motorola/Makefile
> --- a/drivers/phy/motorola/Makefile
> +++ b/drivers/phy/motorola/Makefile
> @@ -3,3 +3,4 @@
>  #
>  
>  obj-$(CONFIG_PHY_CPCAP_USB)		+= phy-cpcap-usb.o
> +obj-$(CONFIG_PHY_MAPPHONE_MDM6600)	+= phy-mapphone-mdm6600.o
> diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
.
.
<snip>
.
.
> +
> +static int phy_mdm6600_probe(struct platform_device *pdev)
> +{
> +	struct phy_mdm6600 *ddata;
> +	struct usb_otg *otg;

Since it is connected to a OHCI, not sure if we really need to add usb_otg here.

Thanks
Kishon
