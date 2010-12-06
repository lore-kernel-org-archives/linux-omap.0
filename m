From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2] musb: am35x: fix compile error due to control apis
Date: Mon, 6 Dec 2010 18:01:33 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BCE3A1EC@dbde02.ent.ti.com>
References: <1291623211-959-1-git-send-email-ajay.gupta@ti.com>
 <4CFCBCF1.9010902@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CFCBCF1.9010902-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> > As the control.h have been moved to new location and it's
> > uses are not allowed to drivers directly so moving the phy
> > control, interrupt clear and reset functionality to board
> > files.
> 
>     I'm not fond of the whole approach. I'm not sure why accesses to the
> control registers are such a no-no, taking into account that one needs to
> access such regisyter to clear the interrupt...

I think Tony is the right person to answer this :)

> 
> > Signed-off-by: Ajay Kumar Gupta<ajay.gupta-l0cyMroinI0@public.gmane.org>
> [...]
> 
> > diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-
> musb.c

[...]

> > +	regval&= ~AM35XX_USBOTGSS_SW_RST;
> > +	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
> > +
> > +	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
> 
>     Why read it and ignore the result?

This is due to recommendation for OMAPs as discussed at below
Link,
http://markmail.org/message/s3lp7xlyq7zxnjtc#query:+page:1+mid:kfia4ld4xgzek6kq+state:results

Thanks,
Ajay
> 
> WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
