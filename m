From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] Device Power: introduce power controller
Date: Thu, 6 Dec 2012 20:20:04 +0530
Message-ID: <CAJe_Zhe7f1_esKw3EaNkONcKihv4r-nftr67LRH8mcN=oY6T_Q@mail.gmail.com>
References: <1354460467-28006-1-git-send-email-tom.leiming@gmail.com>
	<1354460467-28006-2-git-send-email-tom.leiming@gmail.com>
	<50BB7BA9.4090902@linaro.org>
	<CACVXFVNfGZRE4y0+LpBixiMab2=QhOKCcRG_QEz-u7ZwuPnMvQ@mail.gmail.com>
	<50BF7B30.9050904@ti.com>
	<CACVXFVOiu5+M3A14Q-U2FiHYrBjAswp4Jv+Aybs_kV9DiWNHZw@mail.gmail.com>
	<CAJe_ZhcUV7mYaNSEw1kLe8-Ym6RcVEab-1-ZZMT20xsWAb=szQ@mail.gmail.com>
	<CACVXFVMKYAANsNJKBZ90ThaJ7KNOTzpyvARGnNcHsVVczxyO4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVMKYAANsNJKBZ90ThaJ7KNOTzpyvARGnNcHsVVczxyO4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 6 December 2012 18:48, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Dec 6, 2012 at 11:46 AM, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>> The patch can make usb port deal with the 'power controller' only, and make it
>>> avoid to deal with regulators/clocks/... directly.
>>>
>> I am curious too, except for clocks and voltage supplies (regulators),
>> what other external resources does a chip need ?
>
> For example, one indicator LED which doesn't connect to the same power
> domain might need to be triggered after the power switch state is changed.
>
Hmm.. I am not sure if we could call an indicator LED a resource that
a chip needs to be functional. Isn't how mmc core manages the
indicator led, a better way?

cheers.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
