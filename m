From: Ezequiel Garcia <elezegarcia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: musb: dsps: make it work with two instances
Date: Sat, 6 Jul 2013 18:39:50 -0300
Message-ID: <CALF0-+Vo64Znw_iY0gOx5hGJ9mgw7OXFQ5HqBrTW4udW-Z=N+g@mail.gmail.com>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373031178-8871-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, george.cherian-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On Fri, Jul 5, 2013 at 10:32 AM, Sebastian Andrzej Siewior
<bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> This enables the two musb instances on am335x to work.

I like a lot the idea of splitting the DT representation of the two
USB instances. The DT binding
looks much better this way.

After some minor DT tweaking on the current patchset,
I've managed to detect an USB mass storage device in the
second instance (host / usb1) using a Beaglebone black board.

However, after I unplug the device, it's not recognized
when I replug it. Maybe you can take a look at this;
i'll do some more testings and see what I can come up with.

Also, FWIW, I think that having a separate USB phy for am35xx would be
much better.

Nice job!
-- 
    Ezequiel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
