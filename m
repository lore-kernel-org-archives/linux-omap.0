From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv2] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Mon, 5 Mar 2018 19:53:54 -0600
Message-ID: <20180306015354.wegugxvz25tkptxk@rob-hp-laptop>
References: <20180301035057.37584-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180301035057.37584-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 28, 2018 at 07:50:57PM -0800, Tony Lindgren wrote:
> Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> It is used on some Motorola Mapphone series of phones and tablets such
> as Droid 4.
> 
> The MDM6600 is hardwired to the first OHCI port in the Droid 4 case, and
> is controlled by several GPIOs. The USB PHY is integrated into the MDM6600
> device it seems. We know this as we get L3 errors from omap-usb-host if
> trying to use the PHY before MDM6600 is configured.
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

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/phy/motorola/Kconfig                       |   9 +
>  drivers/phy/motorola/Makefile                      |   1 +
>  drivers/phy/motorola/phy-mapphone-mdm6600.c        | 556 +++++++++++++++++++++
>  4 files changed, 596 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
>  create mode 100644 drivers/phy/motorola/phy-mapphone-mdm6600.c
