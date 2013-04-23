From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 01/11] usb: phy: Add APIs for runtime power management
Date: Tue, 23 Apr 2013 12:53:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1304231243040.1679-100000@iolanthe.rowland.org>
References: <CAFp+6iHWMqNQjKV_EQH-Zm6qKbuFwvPJZeswzNFVSSdH-VDB3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35433 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757044Ab3DWQxG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Apr 2013 12:53:06 -0400
In-Reply-To: <CAFp+6iHWMqNQjKV_EQH-Zm6qKbuFwvPJZeswzNFVSSdH-VDB3Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vivek Gautam <gautamvivek1987@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Vivek Gautam <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com

On Tue, 23 Apr 2013, Vivek Gautam wrote:

> >> Alright, so here's my understanding:
> >>
> >> I suggested letting e.g. DWC3 enable the PHY's runtime_pm; Alan said
> >> that it could be done before that so that DWC3 sees an enabled PHY
> >> during probe.
> >
> > Basically right.  Help me to understand the overall situation a little
> > better:
> >
> >         What code registers the PHY initially?
>            PHY is added to global list by PHY drivers (like
> phy-samsung-usb2.c/phy-omap-usb2.c)
>            by usb_add_phy() API

Then this routine should initialize the PHY.  The initialized state 
could be either active or suspended, your choice.  Suspended would be 
best, in case the PHY never gets used.

> >         What routine does the DWC3 driver call to register itself
> >         as a consumer of the PHY?
>            I think DWC3 doesn't registers itself as consumer of PHY,
> rather it gets that PHY from
>            the list using devm_usb_get_phy()/devm_usb_get_phy_by_phandle() API.
>            DWC3 can now call PHY's initialization sequence using usb_phy_init().
>            So, before DWC3 initializes the PHY, PHYs should be in active state.

Then usb_phy_init should make sure the PHY is in the active state.  If 
usb_add_phy() left the PHY suspended, then this routine should call 
pm_runtime_get_sync().

After DWC3 (or any other driver) has acquired the PHY, it can call
pm_runtime_put/get() however it likes, so long as the calls balance
properly.  If the driver isn't runtime-PM aware then it won't use any
of these calls, and the PHY will remain active the entire time.

> >         Likewise, what routine does it call to unregister itself?
>            Once DWC3's remove() is called PHYs are put.

Is there a routine analogous to usb_phy_init() that gets called when
PHY is released?  That routine would do the opposite of usb_phy_init(),
putting the PHY back into its initialized state.

Alan Stern

