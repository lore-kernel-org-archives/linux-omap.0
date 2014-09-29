From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 02/16] tty: serial: 8250_core: add run time pm
Date: Mon, 29 Sep 2014 15:39:18 +0200
Message-ID: <20140929133918.GE13142@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-3-git-send-email-bigeasy@linutronix.de>
 <20140929094620.GE13952@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51562 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbaI2NjZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2014 09:39:25 -0400
Content-Disposition: inline
In-Reply-To: <20140929094620.GE13952@ci00147.xsens-tech.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: linux-serial@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org

* Frans Klaver | 2014-09-29 11:46:20 [+0200]:

>On Wed, Sep 10, 2014 at 09:29:57PM +0200, Sebastian Andrzej Siewior wrote:
>> +/*
>> + * This two wrapper ensure, that enable_runtime_pm_tx() can be called more than
>
>These two wrappers ensure that enable_runtime_pm_tx() ...
fixed

>> @@ -1469,7 +1531,12 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>>  
>>  	DEBUG_INTR("THRE...");
>>  
>> -	if (uart_circ_empty(xmit))
>> +	/*
>> +	 * With RPM enabled, we have to wait once the FIFO is empty before the
>
>s,once,until,? Or do I not understand the sentence correctly?
No, you understand it correct. "until" is the better word here.

Sebastian
