From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v8 00/18] 8250-core based serial driver for OMAP + DMA
Date: Tue, 09 Sep 2014 09:33:42 +0200
Message-ID: <540EAD56.8090304@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de> <20140908174020.GI3238@atomide.com> <20140908175510.GK3238@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50124 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322AbaIIHdr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2014 03:33:47 -0400
In-Reply-To: <20140908175510.GK3238@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 09/08/2014 07:55 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140908 10:41]:
>> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140905 12:03]:
>>> This is my complete queue fo the omap serial driver based on the 8250 core
>>> code. I played with it on beagle bone, am335x-evm and dra7xx including DMA.
>>> The runtime-pm pieces look now bug-compatible with the omap-serial driver.
>>> Besides the runtime-om improvement I also fixed a few corner cases for the
>>> TX-DMA problem. The DMA fixes (in edma and omap-dma) were dropped and the
>>> problem has been in 8250-dma via patch #13.
>>>
>>> The whole queue is available at
>>>   git://git.breakpoint.cc/bigeasy/linux.git uart_v8
>>
>> Gave the above branch a quick try, but it again does not idle for
>> my omap3 test cases. It seems that now the cm_idlest1_core sdma
>> bit is blocking deeper idle states. Is that the correct branch
>> to use?
> 
> Never mind. User error. I forgot to apply my own patch for force
> idling the UARTs for the omap hwmod. And the sdma bit clears if
> I do sleep 5 before attempting to read the sysfs entry..

Okay. There is also this "uart_v8_hacks" branch where I splitted out
the hacks I had like the pstore one or the force idle for instance.

> Regards,
> 
> Tony

Sebastian
