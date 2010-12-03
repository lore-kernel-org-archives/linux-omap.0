From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Fri, 3 Dec 2010 19:08:53 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCE39E0D@dbde02.ent.ti.com>
References: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
 <20101122102230.GP2446@legolas.emea.dhcp.ti.com>
 <20101130183010.GS17222@atomide.com>
 <20101201084100.GC2796@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE39717@dbde02.ent.ti.com>
 <1291231942.15533.32.camel@eowin>
 <19F8576C6E063C45BE387C64729E739404BCE398D7@dbde02.ent.ti.com>
 <20101202082904.GH5429@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404BCE39A7E@dbde02.ent.ti.com>
 <20101203124317.GB2633@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101203124317.GB2633-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> >We already have generic APIs so I think we can pass function pointers to
> >musb driver via "struct omap_musb_board_data",
> >
> > struct omap_musb_board_data {
> >+	void	(*phy_on) (void)
> >+	void 	(*phy_off) (void)
> >+	void  (*intr_clr) (void)
> > }
> >
> >Reset part can be done in board file itself same as Ethernet driver is
> doing.
> >
> >Does this look fine?
> 
> so those would be "turn phy on", "turn phy off" and "clear interrupt"
> apis ?
> 
> How about:
> int (*set_phy_power)(unsigned on);
Looks good.

> void (*clear_phy_irq)(void);
This is actually musb ip interrupt clear so I will make it like,

void (*clear_irq) (void);

> 
> You'd need one less API for that. BTW, could you do it on top of my
> musb-hw branch ? Then I can push together with those for merge window.
Not yet, I will send once completed.

Thanks,
Ajay
> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
