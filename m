From: =?UTF-8?B?xYF1a2FzeiBQdcWCa2E=?= <lukasz-u2dlg1C4t1k@public.gmane.org>
Subject: Re: PROBLEM: am3517 usb-ohci not working
Date: Fri, 7 Oct 2016 12:13:40 +0200
Message-ID: <CALX2uoMnxQ00jiEbMEg4eOi8U0oxtQz1qip8RqcDF8Px2eKq0w@mail.gmail.com>
References: <CALX2uoP-RN6SmEDOVcaBpJv+4kD2dY_iqxGjZu-5JFxdRAVfjA@mail.gmail.com>
 <20161005141051.ywtf6ebakhhvrmst@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161005141051.ywtf6ebakhhvrmst-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> Sounds like you're pretty close, in addition to the
> pin muxing and PHY configuration, check also that you
> have proper VBUS coming to the ports.

Thank you. It was hardware problem
Finally I received the schematics of the PHY connection  from the board vendor.
Suspend pin of PHY was pulled up and connected to gpio the expander.
After forcing suspend pin to "0", USB HS works like a charm.

Luke
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
