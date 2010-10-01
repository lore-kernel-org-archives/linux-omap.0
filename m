From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/3 v5] AM35x: Add musb support
Date: Fri, 1 Oct 2010 11:49:40 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404A9D8AFEB@dbde02.ent.ti.com>
References: <1285823949-27694-1-git-send-email-ajay.gupta@ti.com>
 <20101001060037.GC2925@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101001060037.GC2925-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> On Thu, Sep 30, 2010 at 12:19:07AM -0500, Gupta, Ajay Kumar wrote:
> >AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
> >It has USB phy built inside the IP itself.
> >
> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> besides the one small question below:
> 
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> 
> (note that I don't have that board to fully test this patch)
> 
> >+static struct omap_musb_board_data musb_board_data = {
> >+	.interface_type         = MUSB_INTERFACE_ULPI,
> >+	.mode                   = MUSB_OTG,
> >+	.power                  = 500,

> can this board really source 500mA ??
Yes, it supports upto 500mA same as OMAP3EVM (Rev-G).

-Ajay
> 
> --
> balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
