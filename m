From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: musb host mode suspend mode
Date: Sat, 7 Dec 2013 18:22:30 +0100
Message-ID: <CAOf5uwnJwE54wdwhJj90rJ0Lqv_ENrGL2vcdUtruw4zb0R+e+w@mail.gmail.com>
References: <CAOf5uwn0gqLNWMks6Cw_9szC-Mpq6n+G3x9tqU8QpYOJoOKhfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:49361 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab3LGRWc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Dec 2013 12:22:32 -0500
Received: by mail-wi0-f180.google.com with SMTP id hn9so2114943wib.7
        for <linux-omap@vger.kernel.org>; Sat, 07 Dec 2013 09:22:31 -0800 (PST)
In-Reply-To: <CAOf5uwn0gqLNWMks6Cw_9szC-Mpq6n+G3x9tqU8QpYOJoOKhfA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi

On Wed, Nov 27, 2013 at 4:26 PM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi Felipe,
>
> I'm trying to understand how dpll_usb and vbus should work in suspend mode.
> What I have in my kernel 3.0.31 from ti is that if I suspend the device with id
> pin ground and no device connected I have:
>
> - vbus 5v
> - dpll_usb locked problem so l3domain can not suspend
>
> If I have the id pin floating (device mode) and no device connected I
> can suspend
> without problem. I'm not care about remote wakeup and I would like to understand
> what is the reason of having no complete suspend in host mode. Can you give
> some insight?

I get a bit further and if I do something like that so basically force
device mode I can suspend.

+       if (val) {
+               twl->force_device = false;
+               twl6030_writeb(twl, TWL_MODULE_USB, 0x14, USB_ID_CTRL_SET);
+               twl6030_usb_irq(twl->irq2, twl);
+               twl6030_usbotg_irq(twl->irq1, twl);
+       } else {
+               twl->force_device = true;
+               twl6030_writeb(twl, TWL_MODULE_USB, 0x14, USB_ID_CTRL_CLR);
+               twl6030_usb_irq(twl->irq2, twl);
+               twl6030_usbotg_irq(twl->irq1, twl);
+       }

So my problem is let the device connect host mode (remote wakeup
disable) and let the system suspend in the correct way.

Michael

>
> Michael
