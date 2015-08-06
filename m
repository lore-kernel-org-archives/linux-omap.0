From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: omap2430: use *syscon* framework API to write
 to mailbox register
Date: Thu, 6 Aug 2015 01:47:16 -0700
Message-ID: <20150806084716.GB4215@atomide.com>
References: <1438697169-32359-1-git-send-email-kishon@ti.com>
 <20150805080113.GV16878@atomide.com>
 <55C21885.6000902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C21885.6000902-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [150805 07:10]:
> On Wednesday 05 August 2015 01:31 PM, Tony Lindgren wrote:
> > 
> > We don't have syscon-otghs and to me it seems we need a PHY driver
> > as I pointed out at:
> 
> If *syscon-otghs* is not present, then it'll fall-back to using the *ctrl-module*.

OK great.

> > 
> > https://lkml.org/lkml/2015/6/24/231
> 
> Maybe I should have explained this in the previous thread. The *otghs* register
> that we are trying to access here does _not_ belong to the PHY. It acts as
> mailbox register from MUSB glue (TI integration layer) to MUSB core. That's why
> it's programmed in the TI glue layer (omap2430.c).
> 
> Even when we were using the older API [omap_control_usb_set_mode()], we first
> call omap_musb_mailbox from the PHY drivers (phy-twl4030-usb.c,
> phy-twl6030-usb.c) and then omap_musb_mailbox in the TI glue writes to the
> control module instead of PHY drivers directly calling omap_control_usb_set_mode().

Hmm looking at "Table 18-204. CONTROL_USBOTGHS_CONTROL" it seems to mention
"transceiver" for quite a few bitfields :) Probably what that register does
is control a PHY over ULPI.

So from Linux kernel point of view we're best off treating it as a PHY.
It seems it should have a minimal PHY driver similar to what we have for
dm816x control module in drivers/phy/phy-dm816x-usb.c.

For reference, here is the register bitfields pasted from 4460 TRM:

Table 18-204. CONTROL_USBOTGHS_CONTROL, p3972
Physical Address 0x4A00 233C

BIT	NAME		DESCIPTION
8	DISCHRGVBUS	... OTG transceiver does (not) discharge VBUS ...
7	CHRGVBUS	... OTG transceiver does (not) charge VBUS ...
6	IDPULLUP	... OTG transceiver does (not) drive VBUS ...
4	IDDIG		... OTG transceiver does (not) apply a pullup to ID ...
3	SESSEND		... VBUS voltage is above/below VB_SESS_END ...	
2	VBUSVALID	... VBUS is above the threshold ...
1	BVALID		... VBUS voltage is above/below VB_SESS_VLD ...
0	AVALID		... BUS voltage is above/below VA_SESS_VLD ...

So how about just adding ONTROL_USBOTGHS_CONTROL support to the existing
drivers/phy/phy-omap-usb2.c instead? It seems that it should allow us
to completely get rid of the custom mailbox stuff for MUSB 2430 support?

> > So let's sort that issue first. It also seems this just completely
> > breaks the MUSB support?
> 
> Why do you think so? If *syscon-otghs* is not present in dt, then it'll
> fall-back to using the *ctrl-module* and everything should work seamlessly.

OK that's good to hear. IMO drivers/phy/phy-omap4.c or similar should
manage the syscon-otghs syscon register, not MUSB driver.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
