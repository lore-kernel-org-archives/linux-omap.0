From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: 8250_omap: provide complete custom startup &
 shutdown callbacks
Date: Tue, 26 May 2015 10:06:48 -0400
Message-ID: <55647DF8.4030209@hurleysoftware.com>
References: <20150520200735.GA7790@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34536 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbEZOGw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2015 10:06:52 -0400
Received: by qgez61 with SMTP id z61so62239725qge.1
        for <linux-omap@vger.kernel.org>; Tue, 26 May 2015 07:06:51 -0700 (PDT)
In-Reply-To: <20150520200735.GA7790@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-omap@vger.kernel.org, nsekhar@ti.com, tony@atomide.comm, nm@ti.com, linux-serial@vger.kernel.org

On 05/20/2015 04:07 PM, Sebastian Andrzej Siewior wrote:
> The currently in-use port->startup and port->shutdown are "okay". The
> startup part for instance does the tiny omap extra part and invokes
> serial8250_do_startup() for the remaining pieces. The workflow in
> serial8250_do_startup() is okay except for the part where UART_RX is
> read without a check if there is something to read. I tried to
> workaround it in commit 0aa525d11859 ("tty: serial: 8250_core: read only
> RX if there is something in the FIFO") but then reverted it later in
> commit ca8bb4aefb9 ("serial: 8250: Revert "tty: serial: 8250_core: read
> only RX if there is something in the FIFO"").
> 
> This is the second attempt to get it to work on older OMAPs without
> breaking other chips this time
> Peter Hurley suggested to pull in the few needed lines from
> serial8250_do_startup() and drop everything else that is not required
> including making it simpler like using just request_irq() instead the
> chain handler like it is doing now.
> So lets try that.

Thanks, Sebastian.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

