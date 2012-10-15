From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [balbi-usb:merge-result-for-greg 59/99]
 webcam.c:(.text+0x14afec): undefined reference to `config_ep_by_speed'
Date: Mon, 15 Oct 2012 09:29:14 -0700
Message-ID: <20121015162914.GB32049@kroah.com>
References: <20121012163902.GA19120@localhost>
 <507BC000.10004@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <507BC000.10004-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 15, 2012 at 09:49:20AM +0200, Sebastian Andrzej Siewior wrote:
> On 10/12/2012 06:39 PM, Fengguang Wu wrote:
> >Hi Sebastian,
> 
> Hi Fengguang,
> 
> >FYI, kernel build failed on
> >
> >tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git merge-result-for-greg
> >head:   23953bde3e4d6aa8780dc054f6ad9882ac63f4f4
> >commit: 721e2e91945bc2520d57d795dfe1b502ecec567c [59/99] usb: gadget: libcomposite: move composite.c into libcomposite
> >config: i386-randconfig-b199 (attached as .config)
> >
> >All error/warnings:
> >
> >drivers/built-in.o: In function `uvc_function_set_alt':
> 
> Yes. I accidentally broke this and this still fails in 3.7-rc1. Greg
> has a patch for this in his tree ("usb: gadget: Make webcam gadget
> select USB_LIBCOMPOSITE") which fixes this.

Yes, now queued up in my tree.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
