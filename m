From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Wed, 1 Dec 2010 17:38:28 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCE39717@dbde02.ent.ti.com>
References: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
 <20101122102230.GP2446@legolas.emea.dhcp.ti.com>
 <20101130183010.GS17222@atomide.com>
 <20101201084100.GC2796@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101201084100.GC2796-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> >> Tony ? Do you ack the usage of that header ?
> >
> >NAK. Drivers should not mess with the control registers directly.
> >
> >Instead, the following should be done in the platform init code:
> >
> >$ grep -r omap_ctrl_read drivers/usb
> >drivers/usb/musb/am35x.c:       devconf2 =
> omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> >drivers/usb/musb/am35x.c:       while
> (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
> >drivers/usb/musb/am35x.c:       devconf2 =
> omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> >drivers/usb/musb/am35x.c:               lvl_intr =
> omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
> >drivers/usb/musb/am35x.c:       u32 devconf2 =
> omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> >drivers/usb/musb/am35x.c:       sw_reset =
> omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
> >drivers/usb/musb/am35x.c:       lvl_intr =
> omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
> >
> >You can pass a function pointer like board_set_power or simila in
> >platform_data.

We would need control register apis for accessing USB PHY control
, IPSS reset and interrupt clear register. This would require to
add three different function pointer and that would mostly be
custom to AM35x. Will that be acceptable from musb perspective ?

-Ajay
> 
> That was my feeling too. Anand, care to update ?!?

> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
