From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/18] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Mon, 8 Sep 2014 09:41:48 -0700
Message-ID: <20140908164147.GG3238@atomide.com>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
 <1409943773-7874-12-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49573 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbaIHQly (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 12:41:54 -0400
Content-Disposition: inline
In-Reply-To: <1409943773-7874-12-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140905 12:28]:
> This problem has not been seen on DRA7 or beaglebone (OMAP3). I am not
> sure if this is UART-IP core specific or DMA engine.

Maybe check this comment for future reference too because
beaglebone and bealeboard do different things for PM.. Do
you mean Beaglebone or beagleboard? Or both?

Regards,

Tony
