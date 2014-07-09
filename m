From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 3/4] tty: serial: 8250 core: add runtime pm
Date: Wed, 9 Jul 2014 04:17:05 -0700
Message-ID: <20140709111705.GR28884@atomide.com>
References: <1404491651-1388-1-git-send-email-bigeasy@linutronix.de>
 <1404491651-1388-3-git-send-email-bigeasy@linutronix.de>
 <20140707142056.46f61cf9@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140707142056.46f61cf9@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mika.westerberg@linux.intel.com
List-Id: linux-omap@vger.kernel.org

* One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> [140707 06:22]:
> On Fri,  4 Jul 2014 18:34:10 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > While comparing the OMAP-serial and the 8250 part of this I noticed that
> > the the latter does not use runtime-pm.
> 
> Yes it does, but 8250 parts (generally - omap presumably is special
> here ?) need to be powered on to transmit/receive not just for register
> access. The core uart layer implements a "pm" operation for this.

At least for omaps the UARTs need to be idled for the SoC to
hit off-idle where the SoC is powered off and rebooted during
idle.

So we can certainly enable this in a generic way, however, this
can only be done under the following conditions:

1. We can save and restore the serial register context and detect
   when context was lost in the serial driver. The context loss
   can be detected by looking at some registers that are only
   initialized during init.

2. There's a way for the serial RX pin to wake the SoC. On some
   omaps there's a separate pin specific wake-up interrupt that
   can be used for that.

3. The serial PM features must be only enabled if requested by
   the user via sysfs. Typically extra latency and loss of the
   first RX character occur which is not acceptable to most
   applications.

Regards,

Tony
