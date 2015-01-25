From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/4] tty: Remove external interface for tty_set_termios()
Date: Sun, 25 Jan 2015 12:36:32 -0800
Message-ID: <6C672878-BEFC-4B8D-AC26-1320723ACFCB@holtmann.org>
References: <1422215094-3216-1-git-send-email-peter@hurleysoftware.com> <1422215094-3216-5-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:38639 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbAYUgj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jan 2015 15:36:39 -0500
In-Reply-To: <1422215094-3216-5-git-send-email-peter@hurleysoftware.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org

Hi Peter,

> tty_set_termios() is an internal helper intended for file scope use.
> 
> UART drivers which are capable of driving the RTS pin must
> properly handle the tiocmset() method, regardless of termios settings.
> A failure to do so is a UART driver bug and should be fixed there.
> Do not use this interface to workaround UART driver bugs.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: <linux-bluetooth@vger.kernel.org>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
> drivers/bluetooth/hci_ath.c | 15 ++-------------
> drivers/tty/tty_ioctl.c     |  3 +--
> include/linux/tty.h         |  1 -
> 3 files changed, 3 insertions(+), 16 deletions(-)

I think the less complication is if this goes through the TTY tree.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

