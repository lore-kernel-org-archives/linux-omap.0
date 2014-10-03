From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 00/13 v10] omap 8250 based UART + DMA
Date: Fri, 03 Oct 2014 09:08:08 -0400
Message-ID: <542E9FB8.3080201@hurleysoftware.com>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

On 09/29/2014 02:06 PM, Sebastian Andrzej Siewior wrote:
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

=46or the series:

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
