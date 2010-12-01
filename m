From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: RE: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Wed, 01 Dec 2010 21:32:22 +0200
Message-ID: <1291231942.15533.32.camel@eowin>
References: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
	 <20101122102230.GP2446@legolas.emea.dhcp.ti.com>
	 <20101130183010.GS17222@atomide.com>
	 <20101201084100.GC2796@legolas.emea.dhcp.ti.com>
	 <19F8576C6E063C45BE387C64729E739404BCE39717@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BCE39717-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-12-01 at 17:38 +0530, Gupta, Ajay Kumar wrote:
> > >> Tony ? Do you ack the usage of that header ?
> > >
> > >NAK. Drivers should not mess with the control registers directly.
> > >
> > >Instead, the following should be done in the platform init code:
> > >
> > >$ grep -r omap_ctrl_read drivers/usb
> > >drivers/usb/musb/am35x.c:       devconf2 =
> > omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> > >drivers/usb/musb/am35x.c:       while
> > (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
> > >drivers/usb/musb/am35x.c:       devconf2 =
> > omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> > >drivers/usb/musb/am35x.c:               lvl_intr =
> > omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
> > >drivers/usb/musb/am35x.c:       u32 devconf2 =
> > omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> > >drivers/usb/musb/am35x.c:       sw_reset =
> > omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
> > >drivers/usb/musb/am35x.c:       lvl_intr =
> > omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
> > >
> > >You can pass a function pointer like board_set_power or simila in
> > >platform_data.
> 
> We would need control register apis for accessing USB PHY control
> , IPSS reset and interrupt clear register. This would require to
> add three different function pointer and that would mostly be
> custom to AM35x. Will that be acceptable from musb perspective ?

why don't you add a proper otg_transceiver driver for am35x ?
Is it like omap4's internal phy ? A separate block ?

-- 
balbi

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
