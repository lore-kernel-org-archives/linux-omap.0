From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/16 v9] omap 8250 based uart + DMA
Date: Fri, 12 Sep 2014 15:43:25 -0700
Message-ID: <20140912224324.GK18849@atomide.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140910 12:30]:
> the diff of v8=E2=80=A6v9 is small:
> - rebased on top's of Greg's tty-next branch
> - fixed #10 where we might have THRE interrupt enabled for longer tha=
n
>   needed
> - re-did register setup in #10. Before this "less file" could freeze =
the
>   am335x-evm.

=46YI, looks like merging in your uart_v9 branch for testing
with my hwmod changes now fails to produce RX characters on omap3.

The device wakes up just fine to the wake-up interrupt, and then
serial8250_handle_irq() gets called, but I'm not seeing anything
in the console getting printed out. It's like all the RX characters
are getting lost instead of just the first one. The RX characters
work fine when the system is running.

So it seems there's been some kind of regression since v8?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
