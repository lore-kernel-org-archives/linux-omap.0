From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] usb: musb: omap2430: use *syscon* framework API to write
 to mailbox register
Date: Fri, 21 Aug 2015 00:00:01 -0700
Message-ID: <20150821070000.GJ4215@atomide.com>
References: <1438697169-32359-1-git-send-email-kishon@ti.com>
 <20150805080113.GV16878@atomide.com>
 <55C21885.6000902@ti.com>
 <20150806084716.GB4215@atomide.com>
 <55D57528.1080207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55D57528.1080207@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [150819 23:38]:
> Hi,
> 
> On Thursday 06 August 2015 02:17 PM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [150805 07:10]:
> >> On Wednesday 05 August 2015 01:31 PM, Tony Lindgren wrote:
> >>>
> >>> We don't have syscon-otghs and to me it seems we need a PHY driver
> >>> as I pointed out at:
> >>
> >> If *syscon-otghs* is not present, then it'll fall-back to using the *ctrl-module*.
> > 
> > OK great.
> > 
> >>>
> >>> https://lkml.org/lkml/2015/6/24/231
> >>
> >> Maybe I should have explained this in the previous thread. The *otghs* register
> >> that we are trying to access here does _not_ belong to the PHY. It acts as
> >> mailbox register from MUSB glue (TI integration layer) to MUSB core. That's why
> >> it's programmed in the TI glue layer (omap2430.c).
> >>
> >> Even when we were using the older API [omap_control_usb_set_mode()], we first
> >> call omap_musb_mailbox from the PHY drivers (phy-twl4030-usb.c,
> >> phy-twl6030-usb.c) and then omap_musb_mailbox in the TI glue writes to the
> >> control module instead of PHY drivers directly calling omap_control_usb_set_mode().
> > 
> > Hmm looking at "Table 18-204. CONTROL_USBOTGHS_CONTROL" it seems to mention
> > "transceiver" for quite a few bitfields :) Probably what that register does
> > is control a PHY over ULPI.
> 
> OMAP4 uses UTMI PHY and it uses CONTROL_USBOTGHS_CONTROL too.

So can't we make the phy-omap-usb2.c driver the onlly user of this
register then and get rid of the mailbox stuff? I think the phy
framework can handle everything now?

> > So from Linux kernel point of view we're best off treating it as a PHY.
> > It seems it should have a minimal PHY driver similar to what we have for
> > dm816x control module in drivers/phy/phy-dm816x-usb.c.
> 
> hmm.. IMHO CONTROL_USBOTGHS_CONTROL register belongs to the TI MUSB glue and
> should be programmed in omap2430.c. It's better to get the opinion of Felipe
> here. Felipe?
> > 
> > For reference, here is the register bitfields pasted from 4460 TRM:
> > 
> > Table 18-204. CONTROL_USBOTGHS_CONTROL, p3972
> > Physical Address 0x4A00 233C
> > 
> > BIT	NAME		DESCIPTION
> > 8	DISCHRGVBUS	... OTG transceiver does (not) discharge VBUS ...
> > 7	CHRGVBUS	... OTG transceiver does (not) charge VBUS ...
> > 6	IDPULLUP	... OTG transceiver does (not) drive VBUS ...
> > 4	IDDIG		... OTG transceiver does (not) apply a pullup to ID ...
> > 3	SESSEND		... VBUS voltage is above/below VB_SESS_END ...	
> > 2	VBUSVALID	... VBUS is above the threshold ...
> > 1	BVALID		... VBUS voltage is above/below VB_SESS_VLD ...
> > 0	AVALID		... BUS voltage is above/below VA_SESS_VLD ...
> > 
> > So how about just adding ONTROL_USBOTGHS_CONTROL support to the existing
> > drivers/phy/phy-omap-usb2.c instead? It seems that it should allow us
> > to completely get rid of the custom mailbox stuff for MUSB 2430 support?
> 
> Not in phy-omap-usb2.c. It's the UTMI PHY driver and is not used by OMAP3 based
> boards (uses twl4030 ULPI PHY). CONTROL_USBOTGHS_CONTROL has to be programmed
> for OMAP3 also.

Hmm I don't think omap3 uses that register? There's no ti,control-phy
anything in the omap3 dts files?  And no USBOTGHS_CONTROL in the TRM?
Or am I missing something here?

Regards,

Tony
