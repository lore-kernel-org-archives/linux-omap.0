From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] usb: phy: phy-generic: No need to call
 gpiod_direction_output() twice
Date: Tue, 3 Feb 2015 19:14:59 -0200
Message-ID: <CAOMZO5A=_3hbvYkcTVHws6HuOUuNa-p=j-tn+RaEzGOH0JMkKA@mail.gmail.com>
References: <1422653236-7142-1-git-send-email-festevam@gmail.com>
	<20150130215939.GC30049@saruman.tx.rr.com>
	<CAOMZO5A=J7HF+AR8aB2CA+we7knoas-vDtLMbh3gVNvgb1aEAg@mail.gmail.com>
	<CAOMZO5DeyqtjDq0a4_qX2SPbaDZunQbSJimrH23gju1mmdA7vQ@mail.gmail.com>
	<20150201173750.GA16306@saruman.tx.rr.com>
	<CAOMZO5AOevmZLKNSRygeWEGzQp-MLkp8pg8Jr536Y-xXPPTKZw@mail.gmail.com>
	<20150203205217.GA27736@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150203205217.GA27736-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 3, 2015 at 6:52 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:

> it doesn't make a difference though, right ?
> gpiod_direction_output(NULL, 1) won't do anything.

Yes, I will send a v3 without the NULL check.

gpiod_set_value returns immediately if desc is NULL:

void gpiod_set_value(struct gpio_desc *desc, int value)
{
    if (!desc)
        return;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
