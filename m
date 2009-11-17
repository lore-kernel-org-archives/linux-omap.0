From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: 8250: add UPF_NO_EMPTY_FIFO_READ flag
Date: Tue, 17 Nov 2009 21:25:47 +0000
Message-ID: <20091117212547.0a81fa46@lxorguk.ukuu.org.uk>
References: <1258492615-15963-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1258492615-15963-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-serial-owner@vger.kernel.org
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 17 Nov 2009 15:16:55 -0600
Vikram Pandita <vikram.pandita@ti.com> wrote:

> OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
> Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.

Nothing wrong with the requirement but I think it would keep 8250.c a lot
cleaner if you implemented that in the serial_in method for the
OMAP3630/4430. It would also mean anyone adding a UART_RX or any cases
you miss don't break in future

This is especially true now as you can pass a private
serial_in/serial_out method in the port register function.

Care to submit an alternate patch doing it that way, or see any reason
for not ?

Alan
