From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/13 v10] omap 8250 based UART + DMA
Date: Wed, 5 Nov 2014 19:14:21 -0800
Message-ID: <20141106031421.GA22185@kroah.com>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 29, 2014 at 08:06:36PM +0200, Sebastian Andrzej Siewior wro=
te:
> The queue is getting smaller. The highlights of v9=E2=80=A6v10
> - the DMA stall Frans Klaver reported which popped up in yocto is gon=
e. It
>   also seems that the "ack the err-irq even if nothing happened" in E=
DMA
>   can be dropped.
> - the RX- and TX-DMA callbacks are now OMAP-only and no "bugs" flags =
are
>   introduced into the generic DMA code. This also means that there is
>   custom IRQ routine in case of DMA.

I've now applied the patches here that I could, if I have missed any,
please let me know and resend.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
