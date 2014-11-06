From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 00/13 v10] omap 8250 based UART + DMA
Date: Thu, 06 Nov 2014 11:27:21 +0100
Message-ID: <545B4D09.6070102@linutronix.de>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de> <20141106031421.GA22185@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20141106031421.GA22185@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, tony@atomide.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On 11/06/2014 04:14 AM, Greg KH wrote:
> I've now applied the patches here that I could, if I have missed any,
> please let me know and resend.

Thank you Greg. I pulled your tty-testing and it seems to work on
am335x-evm/dra7-evm.

Tony, if you could please take the two .dts files then the series would
be complete (that one dma patch was applied by Vinod during the merge
window).

> 
> thanks,
> 
> greg k-h
> 
Sebastian
