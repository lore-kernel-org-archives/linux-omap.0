From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv3] phy: cpcap-usb: Add CPCAP PMIC USB support
Date: Mon, 8 May 2017 10:32:17 -0700
Message-ID: <20170508173216.GI3489@atomide.com>
References: <20170410041958.21269-1-tony@atomide.com>
 <9bfee59a-faba-3f48-1234-2a5496b3fc14@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9bfee59a-faba-3f48-1234-2a5496b3fc14-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [170507 23:23]:
> Hi Tony,
> 
> On Monday 10 April 2017 09:49 AM, Tony Lindgren wrote:
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
> I thought of using EXTCON differently from what was used below. Actually I
> thought EXTCON shuld be used in cpcap-adc driver for notifying VBUS or ID
> events to phy-cpcap driver which performs the various setting based on VBUS or
> ID. (See drivers/usb/dwc3/dwc3-omap.c which receives VBUS/ID notifications fo
> sample). That would have simply replaced the iio* calls with EXTCON calls in
> phy-cpcap-usb driver (in addition to adding extcon API's in cpcap-adc driver).

OK sorry yeah I misunderstood what you wanted then. I actually started
running into issues with extcon as it assumes that the extcon provider
can't be removed if there are consumers. So yeah let's scrap this usage
as it adds a bogus dependency between the charger driver and PHY driver.

> Usage of EXTCON like below is not of much use here since MUSB doesn't really
> wait for notification of ID or VBUS events (This is unlike dwc3-omap. since we
> invoke musb_mailbox functin directly).

OK

> If adding EXTCON in cpcap-adc isn't simple then we should stick to your patch
> version 2 since extcon support in this version is not useful IMO.

OK. I'll check and will post v3. My gut feeling is that IIO is better
for VBUS and ID as we want the values too.

For example ID pin can have multiple values, and it seems that many PHYs
can detect 102/200/440K pull-up on the ID pin for "carkit" mode etc. I'm
not yet sure if there are multiple ID pull-up values to be considered in
this case, but there is at least one pull-up value for detecting
"factory mode" where the device is supposed to be powered on USB only
even if there is no battery.

Also the VBUS in this case is the direct voltage from the battery as
far as I can tell so the voltage value should be considered.

> > +Example:
> > +cpcap_usb2_phy: phy {
> > +	compatible = "motorola,mapphone-cpcap-usb-phy";
...
> > +};
> 
> I would have preferred this to be a separate patch but since Rob has Acked it,
> it is fine.

OK

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
