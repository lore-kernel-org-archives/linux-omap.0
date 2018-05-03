From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: 8250: omap: Fix idling of clocks for unused uarts
Date: Thu, 3 May 2018 07:31:41 -0700
Message-ID: <20180503143141.GR98604@atomide.com>
References: <20180502171500.60462-1-tony@atomide.com>
 <58bcba76-d63b-212e-4baf-d40a28c549d3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58bcba76-d63b-212e-4baf-d40a28c549d3@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [180503 10:20]:
> 
> 
> On Wednesday 02 May 2018 10:45 PM, Tony Lindgren wrote:
> > I noticed that unused UARTs won't necessarily idle properly always
> > unless at least one byte tx transfer is done first.
> > 
> > After some debugging I narrowed down the problem to the scr register
> > dma configuration bits that need to be set before softreset for the
> > clocks to idle. Unless we do this, the module clkctrl idlest bits
> > may be set to 1 instead of 3 meaning the clock will never idle and
> > is blocking deeper idle states for the whole domain.
> > 
> > This might be related to the configuration done by the bootloader
> > or kexec booting where certain configurations cause the 8250 or
> > the clkctrl clock to jam in a way where setting of the scr bits
> > and reset is needed to clear it. I've tried diffing the 8250
> > registers for the various modes, but did not see anything specific.
> > So far I've only seen this on omap4 but I'm suspecting this might
> > also happen on the other clkctrl using SoCs considering they
> > already have a quirk enabled for UART_ERRATA_CLOCK_DISABLE.
> > 
> 
> That's interesting! We do have AM437x suspend/resume working without
> this workaround (UARTs on AM437x does not use DMA) and UART IPs clkctrl
> do go to idle state. Seems like a OMAP4 specific issue.

Yeah seems to be omap4 specific. I did not see this yesterday
on my am437x-idk or beagle-x15 after clearing status = "disabled"
for all ports and idling them.

> Comment in omap8250_update_scr() warns not to set these two bits in a
> single register write because this may lead to malfunction. I would
> recommend to split this into two writes.

OK I'll split the write into two parts.

Regards,

Tony
