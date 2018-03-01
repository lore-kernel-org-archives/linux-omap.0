From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on
 Droid 4
Date: Wed, 28 Feb 2018 19:46:10 -0800
Message-ID: <20180301034610.GC62820@atomide.com>
References: <20180217210723.7013-1-tony@atomide.com>
 <20180219204029.xrftbbxvdfxlf7jh@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180219204029.xrftbbxvdfxlf7jh@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [180219 20:41]:
> On Sat, Feb 17, 2018 at 01:07:23PM -0800, Tony Lindgren wrote:
> > The GPIOs controlling MDM6600 are used to power MDM660 on and off, to
> 
> MDM660 a typo?

Thanks fixing.

> > +Required properties:
> > +- compatible	Must be "motorola,mapphone-mdm6600"
> > +- enable-gpios	GPIO to enable the USB PHY
> > +- power-gpios	GPIO to power on the device
> > +- reset-gpios	GPIO to reset the device
> 
> The are pretty standard, but...
> 
> > +- mode-gpios	Two GPIOs to configure MDM6600 USB start-up mode for
> > +		normal mode versus USB flashing mode
> > +- status-gpios	Three GPIOs to read the power state of the MDM6600
> > +- cmd-gpios	Three GPIOs to control the power state of the MDM6600
> 
> These 3 should have vendor a prefix.

OK

> > +
> > +Example:
> > +
> > +fsusb1_phy: fsusb1_phy {
> 
> usb-phy {

Thanks will send out an updated version shortly.

Regards,

Tony
