From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [patch] dwc3: add a kfree() on error to dwc3_testmode_open()
Date: Fri, 26 Aug 2011 12:32:40 +0200
Message-ID: <20110826103240.GA6060@linutronix.de>
References: <20110826092113.GO5975@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110826092113.GO5975-z0WHZYlhLlzP0Z7Jsv878P8+0UxHXcjY@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, "open list:DESIGNWARE USB3 D..." <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:DESIGNWARE USB3 D..." <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Dan Carpenter | 2011-08-26 12:21:13 [+0300]:

>Btw.  This function returns -EBUSY on success.  Was that really what
>you want?

At that time yes. The idea was to enable the self-test mode of the core
and let it do transfers forth and back and see if it works. There is
also no off switch. I wasn't aware that this piece of code is going to
merged but now I think we need an off switch.
Thanks for spotting this.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
