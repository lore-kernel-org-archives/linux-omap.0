From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 09/11] bluetooth: hci_ldisc: fix deadlock condition
Date: Thu, 20 Mar 2014 12:40:40 -0700
Message-ID: <95DFF994-1668-4F93-943B-06805FD5B20B@holtmann.org>
References: <1395343807-21618-1-git-send-email-balbi@ti.com> <1395343807-21618-9-git-send-email-balbi@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395343807-21618-9-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, m-karicheri2@ti.com, b32955@freescale.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

> LDISCs shouldn't call tty->ops->write() from within
> ->write_wakeup().
> 
> ->write_wakeup() is called with port lock taken and
> IRQs disabled, tty->ops->write() will try to acquire
> the same port lock and we will deadlock.
> 
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> Reported-by: Huang Shijie <b32955@freescale.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 24 +++++++++++++++++++-----
> drivers/bluetooth/hci_uart.h  |  1 +
> 2 files changed, 20 insertions(+), 5 deletions(-)

I hope these are not causing any conflicts with bluetooth-next / linux-next. If not, then I can let Greg take it through tty-next tree.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel
