From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Fri, 9 Mar 2018 06:52:27 -0800
Message-ID: <20180309145227.GP5799@atomide.com>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180309094417.GA5970@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180309094417.GA5970@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180309 09:45]:
> Hi!
> 
> > Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> > It is used on some Motorola Mapphone series of phones and tablets such
> > as Droid 4.
> ...
> > So it seems that MDM6600 is currently not yet idling even with it's
> > radio turned off, but that's something that is beyond the control of
> > this USB PHY driver. This patch does get us to the point where modem
> > data and GPS are usable with libqmi and ModemManager for example.
> > Voice calls need more audio driver work.
> 
> Thanks for the good work. Looks like I'll need to get droid
> 4... fortunately it is not available in czech republic so I don't get
> excuse to get another toy.
> 
> Oh.. no. It is available in Czech republic. Is Motorola Droid 4 XT894
> the right one? Hmm, and LTE modem is useless in Europe, while the GSM
> one does not work, right?

Yup xt894 is the model number for droid 4.

Regards,

Tony
