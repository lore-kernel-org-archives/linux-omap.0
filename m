From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v8 00/18] 8250-core based serial driver for OMAP + DMA
Date: Tue, 09 Sep 2014 21:41:20 +0200
Message-ID: <540F57E0.8030404@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de> <20140908144616.GA22315@ci00147.xsens-tech.local> <20140908151501.GA22584@linutronix.de> <20140908183353.GB4686@ci00147.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140908183353.GB4686@ci00147.xsens-tech.local>
Sender: linux-serial-owner@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: linux-serial@vger.kernel.org, tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/08/2014 08:33 PM, Frans Klaver wrote:
> Thanks. I'll give it a spin on Wednesday.

Could you please pull the upcoming v9 first?

 git://git.breakpoint.cc/bigeasy/linux.git uart_v9_pre1

This solves a few of my am335x related issues.

The problem that the uart freezes on beagle board xm is still there.
>From what I can say is that the DMA transfer is started but not
completed and I can't reproduce it on dra7xx

> Thanks,
> Frans
> 

Sebastian
