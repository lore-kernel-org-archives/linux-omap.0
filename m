From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: PROBLEM: am3517 usb-ohci not working
Date: Fri, 7 Oct 2016 06:45:33 -0700
Message-ID: <20161007134532.2c37bo4apnvuigkv@atomide.com>
References: <CALX2uoP-RN6SmEDOVcaBpJv+4kD2dY_iqxGjZu-5JFxdRAVfjA@mail.gmail.com>
 <20161005141051.ywtf6ebakhhvrmst@atomide.com>
 <CALX2uoMnxQ00jiEbMEg4eOi8U0oxtQz1qip8RqcDF8Px2eKq0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALX2uoMnxQ00jiEbMEg4eOi8U0oxtQz1qip8RqcDF8Px2eKq0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?xYF1a2FzeiBQdcWCa2E=?= <lukasz-u2dlg1C4t1k@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Łukasz Pułka <lukasz-u2dlg1C4t1k@public.gmane.org> [161007 03:14]:
> > Sounds like you're pretty close, in addition to the
> > pin muxing and PHY configuration, check also that you
> > have proper VBUS coming to the ports.
> 
> Thank you. It was hardware problem
> Finally I received the schematics of the PHY connection  from the board vendor.
> Suspend pin of PHY was pulled up and connected to gpio the expander.
> After forcing suspend pin to "0", USB HS works like a charm.

OK good to hear.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
