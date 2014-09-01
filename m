From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 06/15] tty: serial: 8250_dma: handle error on TX submit
Date: Mon, 01 Sep 2014 16:38:45 +0200
Message-ID: <540484F5.5080705@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de> <1408124563-31541-7-git-send-email-bigeasy@linutronix.de> <20140818135737.GB32400@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59480 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbaIAOiz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2014 10:38:55 -0400
In-Reply-To: <20140818135737.GB32400@xps8300>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 08/18/2014 03:57 PM, Heikki Krogerus wrote:
> On Fri, Aug 15, 2014 at 07:42:34PM +0200, Sebastian Andrzej Siewior wrote:
>> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>> index b161eee..02e82dc 100644
>> --- a/include/linux/serial_8250.h
>> +++ b/include/linux/serial_8250.h
>> @@ -85,6 +85,7 @@ struct uart_8250_port {
>>  	unsigned char		mcr_force;	/* mask of forced bits */
>>  	unsigned char		cur_iotype;	/* Running I/O type */
>>  	unsigned char		rpm_tx_active;
>> +	unsigned char		dma_tx_err;
> 
> Why not make this member of uart_8250_dma instead?

Why not indeed. Fixed.

Sebastian
