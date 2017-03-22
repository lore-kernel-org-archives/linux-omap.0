From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] phy: cpcap-usb: Add CPCAP PMIC USB support
Date: Wed, 22 Mar 2017 14:59:36 -0700
Message-ID: <20170322215935.GG10760@atomide.com>
References: <20170317035152.18307-1-tony@atomide.com>
 <20170322021828.wkbx3es6dpuur42y@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170322021828.wkbx3es6dpuur42y@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170321 19:20]:
> Hi,
> 
> On Thu, Mar 16, 2017 at 08:51:52PM -0700, Tony Lindgren wrote:
> > Some Motorola phones like droid 4 use a custom CPCAP PMIC that has a
> > multiplexing USB PHY.
> > 
> > This USB PHY can operate at least in four modes using pin multiplexing
> > and two control GPIOS:
> > 
> > - Pass through companion PHY for the SoC USB PHY
> > - ULPI PHY for the SoC
> > - Pass through USB for the modem
> > - UART debug console for the SoC
> > 
> > This patch adds support for droid 4 USB PHY and debug UART modes,
> > support for other modes can be added later on as needed.
> > 
> > Both peripheral and host mode are working for the USB. The
> > host mode depends on the cpcap-charger driver for VBUS.
> > 
> > VBUS and ID pin detection are done using cpcap-adc IIO ADC
> > driver.
> 
> I tested UART, USB slave (cdc-ether) & USB host (keyboard & touchpad
> from Atrix lapdock) mode with Droid 4:
> 
> Tested-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks for testing. I'll repost v2 shortly with a minor change to
use iio_read_channel_processed() instead of iio_read_channel_scale()
as the ADC values are processed in the driver and not scaled by
the IIO framework.

Regards,

Tony


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
