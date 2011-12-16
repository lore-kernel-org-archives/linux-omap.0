From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: UART cleanup and runtime PM conversion for
 v3.3
Date: Fri, 16 Dec 2011 10:24:16 -0800
Message-ID: <20111216182416.GD32251@atomide.com>
References: <878vmeodsx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878vmeodsx.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Govindraj Raja <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [111214 16:22]:
> Tony,
> 
> Please pull the OMAP UART cleanup and conversion to runtime PM.  I had
> to rebase it onto your soc branch due to the serial.c changes there.
> 
> This includes changes to drivers/tty/serial/omap-serial.c and those
> changes have Acks from Greg KH and Alan Cox and I got the OK from them
> to merge this all together via the OMAP tree.
> 
> Thanks to Govindraj for his persistence with this series.
> 
> Boot tested on 2420/n810, 4430/Blaze, 4430/Panda
> Additional PM testing on 3430/n900, 3530/Overo, 3630/Zoom3.
> 
> NOTE: while normal UART behavior works fine with this series, including
>       suspend/resume, in order for wakeups from runtime PM to work, this
>       series depends on the PRCM IRQ chaining series from Tero and the
>       the new hwmod init state from Rajendra[1].  However, since runtime
>       PM is disabled by default for the UARTs, they will behave normally
>       even without those dependencies.
> 
> Kevin
> 
> [1] http://marc.info/?l=linux-omap&m=132187766930901&w=2

Thanks pulling this into uart branch.

Regards,

Tony
