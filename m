From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 5/5] tty: serial: Add 8250-core based omap driver
Date: Thu, 17 Jul 2014 17:11:58 +0200
Message-ID: <53C7E7BE.7030403@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de> <1405521903-5877-6-git-send-email-bigeasy@linutronix.de> <20140717145430.GF10459@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36813 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932975AbaGQPMF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2014 11:12:05 -0400
In-Reply-To: <20140717145430.GF10459@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 07/17/2014 04:54 PM, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Jul 16, 2014 at 04:45:03PM +0200, Sebastian Andrzej Siewior wrote:
>> +static int omap_8250_startup(struct uart_port *port)
>> +{
>> +	struct uart_8250_port *up =
>> +		container_of(port, struct uart_8250_port, port);
>> +	struct omap8250_priv *priv = port->private_data;
>> +
>> +	int ret;
>> +
>> +	if (priv->wakeirq) {
>> +		ret = request_irq(priv->wakeirq, omap_wake_irq,
>> +				port->irqflags, "wakeup irq", port);
>> +		if (ret)
>> +			return ret;
>> +		disable_irq(priv->wakeirq);
>> +	}
>> +
>> +	ret = serial8250_do_startup(port);
>> +	if (ret)
>> +		goto err;
>> +
>> +	pm_runtime_get_sync(port->dev);
> 
> should this pm_runtime_get_sync() be placed above
> serial8250_do_startup() call ?

I don't think it matters since serial8250_do_startup() has its own
pm_runtime_get_sync().

->startup(), ->shutdown() are called via omap callbacks so we could
spare in the 8250-core if we do it in the omap code before invoking the
function. The same goes for serial8250_set_termios() which is not used
by omap but has those runtime-pm stuff, too.
It would be wrong if someone would use the serial8250_do_startup()
without his own runtime-pm get but it is omap only which does this
things.
So it is not used by anyone else (right now) and if you want to keep it
to a minimum I could remove them from those places.

Sebastian
