From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/13 v10] omap 8250 based UART + DMA
Date: Thu, 2 Oct 2014 09:43:39 -0700
Message-ID: <20141002164339.GL3122@atomide.com>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140929 11:07]:
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

Looks good to me. For the patches that do not yet have my acks, please
feel free to add:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>

It's probably best that I queue the .dts changes separately though
to avoid pointless merge conflicts.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
