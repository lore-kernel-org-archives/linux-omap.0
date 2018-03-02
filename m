From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Fri, 2 Mar 2018 06:03:31 -0800
Message-ID: <20180302140331.GK62820@atomide.com>
References: <20180301035057.37584-1-tony@atomide.com>
 <b39478ec-35ba-d288-bb03-28dda5544e80@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b39478ec-35ba-d288-bb03-28dda5544e80@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [180302 08:04]:
> Hi Tony,
> 
> On Thursday 01 March 2018 09:20 AM, Tony Lindgren wrote:
> > Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> > It is used on some Motorola Mapphone series of phones and tablets such
> > as Droid 4.
> 
> Generally PHY configuration is done for the PHYs that is connected to the USB
> controllers in the SoC. In that sense it differs from the usual case by
> programming the PHY in the device.

Yup in this case it's the MDM6600 that provides the PHY for the SoC :)

> > The MDM6600 is hardwired to the first OHCI port in the Droid 4 case, and
> > is controlled by several GPIOs. The USB PHY is integrated into the MDM6600
> > device it seems. We know this as we get L3 errors from omap-usb-host if
> > trying to use the PHY before MDM6600 is configured.
> 
> Do you know what phy is connected to the OHCI port. Previously we've seen for
> having USB devices on the board itself, phy less configurations was used.

We have MDM6600 on *HCI port 1 providing "ohci-phy-4pin-dpdm"
PHY for the SoC, so not TLL. Then there's another modem W3GLTE on
port 2 that is using "ehci-tll".

> > --- /dev/null
> > +++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> .
> .
> <snip>
> .
> .
> > +
> > +static int phy_mdm6600_probe(struct platform_device *pdev)
> > +{
> > +	struct phy_mdm6600 *ddata;
> > +	struct usb_otg *otg;
> 
> Since it is connected to a OHCI, not sure if we really need to add usb_otg here.

OK yeah that's copy paste leftover from my earlier PHY driver I used
to start with. Will drop thanks.

Regards,

Tony
