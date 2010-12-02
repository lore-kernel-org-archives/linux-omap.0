From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2] AM35x: musb: fix compilation error
Date: Thu, 2 Dec 2010 10:22:11 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCE398D7@dbde02.ent.ti.com>
References: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
	 <20101122102230.GP2446@legolas.emea.dhcp.ti.com>
	 <20101130183010.GS17222@atomide.com>
	 <20101201084100.GC2796@legolas.emea.dhcp.ti.com>
	 <19F8576C6E063C45BE387C64729E739404BCE39717@dbde02.ent.ti.com>
 <1291231942.15533.32.camel@eowin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291231942.15533.32.camel@eowin>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> > We would need control register apis for accessing USB PHY control
> > , IPSS reset and interrupt clear register. This would require to
> > add three different function pointer and that would mostly be
> > custom to AM35x. Will that be acceptable from musb perspective ?
> 
> why don't you add a proper otg_transceiver driver for am35x ?
> Is it like omap4's internal phy ? A separate block ?

AM35x PHY is built inside the ip and we need to configure it through
PHY control register. 

Additionally we also need to access IPSS reset and Intr clear register
as well which would not fit inside otg_transceiver.

Ajay
> 
> --
> balbi

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
