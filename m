From: "Lennart Sorensen" <lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
Subject: Re: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
Date: Tue, 4 Nov 2014 14:00:01 -0500
Message-ID: <20141104190001.GE24112@csclub.uwaterloo.ca>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
 <1412014009-13315-12-git-send-email-bigeasy@linutronix.de>
 <20141104170233.GB24112@csclub.uwaterloo.ca>
 <5459079D.7080703@linutronix.de>
 <20141104172117.GC24112@csclub.uwaterloo.ca>
 <CABxcv=kT+M70Xoyf_z4eQQyM0Oo9S5Y0YeX2R6PbAqxK-JTLLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABxcv=kT+M70Xoyf_z4eQQyM0Oo9S5Y0YeX2R6PbAqxK-JTLLg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 04, 2014 at 07:32:07PM +0100, Javier Martinez Canillas wrote:
> Hello,
> 
> On Tue, Nov 4, 2014 at 6:21 PM, Lennart Sorensen
> <lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org> wrote:
> >> Mind sharing the manual with me? Mine does not mention DMA channels for
> >> UART7-10. If you are able to test 7+8 (and it works) could you please
> >> make patch which with for the remaining four devices?
> >
> > Well the file I have is called AM572x_ES1.1_NDA_TRM_vT.pdf, so I am not
> > sure who I am allowed to share that file with.  Might be simpler to just
> > ask TI for the latest version.
> >
> > How I hate NDAs.
> >
> 
> I saw today an announcement about a public AM572x Silicon Revision 1.1
> TRM [0] that has just made available by TI. I'm not familiar with this
> SoC so I don't know if that has the information you want but I thought
> it was worth to mention in case it did.
> 
> Best regards,
> Javier
> 
> [0]: http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf

That's the right one.

Page 3622 has the dma channels for uart 7 through 10, but it still needs
the updated crossbar dma driver to work.

-- 
Len Sorensen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
