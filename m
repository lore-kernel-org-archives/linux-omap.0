From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Thu, 8 Mar 2018 08:06:44 -0800
Message-ID: <20180308160644.GJ5799@atomide.com>
References: <20180307145640.93867-1-tony@atomide.com>
 <bff8014e-a0b6-8b7b-5de7-2a176e293933@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bff8014e-a0b6-8b7b-5de7-2a176e293933@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [180308 08:23]:
> On Wednesday 07 March 2018 08:26 PM, Tony Lindgren wrote:
> > +config PHY_MAPPHONE_MDM6600
> > +	tristate "Motorola Mapphone MDM6600 modem USB PHY driver"
> > +	depends on OF && USB_SUPPORT
> > +	select GENERIC_PHY
> > +	select USB_PHY
> 
> given that OTG is removed, USB_PHY won't be required anymore. Sorry for not
> stating this explicitly before.

Oh OK I did not know that.

> > +	ddata->dev = &pdev->dev;
> > +	ddata->phy.dev = ddata->dev;
> > +	ddata->phy.label = "phy_mdm6600";
> > +	ddata->phy.type = USB_PHY_TYPE_USB2;
> 
> All of this can be removed since usb_phy is not required.

> > +	usb_add_phy_dev(&ddata->phy);
> 
> This should also be removed.

OK cool, will remove and post v4 hopefully tonight at some
point.

Regards,

Tony
