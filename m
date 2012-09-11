From: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [balbi-usb:master 33/36] drivers/usb/gadget/serial.c:89:22:
 sparse: cast truncates bits from constant value (24000000 becomes 0)
Date: Tue, 11 Sep 2012 18:55:00 +0800
Message-ID: <20120911105500.GA1244@localhost>
References: <20120910164015.GA16252@localhost>
 <504E1DCB.3000003@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <504E1DCB.3000003-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 10, 2012 at 07:05:15PM +0200, Sebastian Andrzej Siewior wrote:
> On 09/10/2012 06:40 PM, Fengguang Wu wrote:
> >tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git master
> >head:   d9c88901337158c9f253a7de58a10b5125d61d26
> >commit: 7a7322b0a5d984025dd4faea9098b8fef07f8d8f [33/36] usb: gadget: remove usb_gadget_controller_number()
> >
> >All sparse warnings:
> 
> Once again, thank you.

You are welcome!

> >   drivers/usb/gadget/f_acm.c:287:9: sparse: advancing past deep designator
> >   drivers/usb/gadget/f_obex.c:60:9: sparse: advancing past deep designator
> >   drivers/usb/gadget/f_serial.c:134:9: sparse: advancing past deep designator
> >   drivers/usb/gadget/serial.c:66:9: sparse: advancing past deep designator
> 
> I don't get these. The purpose is an all NULL terminating entry. Could
> this be a sparse bug or is the [] / {} switch not really good C code?

http://marc.info/?l=linux-sparse&m=130673652023059&w=4

According to Dan's explanations, I'll filter out these warnings in future.

> >+ drivers/usb/gadget/serial.c:89:22: sparse: cast truncates bits from constant value (24000000 becomes 0)
> 
> I've sent a patch for this.

Thank you!

Fengguang
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
