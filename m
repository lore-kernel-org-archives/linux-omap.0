From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP4430 SDP with KS8851: very slow networking
Date: Thu, 6 Dec 2018 14:14:47 -0800
Message-ID: <20181206221447.GM6707@atomide.com>
References: <20181206132256.GT30658@n2100.armlinux.org.uk>
 <20181206163154.GK6707@atomide.com>
 <20181206180806.GV6920@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181206180806.GV6920@n2100.armlinux.org.uk>
Sender: netdev-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [181206 18:08]:
> reverted, the problem is still there.  Revert:
> 
> ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4 based SoCs")
> 
> on top, and networking returns to normal.  So it appears to be this
> last commit causing the issue.
> 
> With that and b764a5863fd8 applied, it still misbehaves.  Then, poking
> at the OMAP4_GPIO_IRQWAKEN0 register, changing it from 0 to 4 with
> devmem2 restores normal behaviour - ping times are normal and NFS is
> happy.
> 
> # devmem2 0x48055044 w 4

OK thanks.

> Given that this GPIO device is not runtime suspended, and is
> permanently active (which is what I think we expect, given that it
> has an IRQ claimed against it) does the hardware still attempt to
> idle the GPIO block - if so, could that be why we need to program
> the wakeup register, so the GPIO block signals that it's active?

Yes we now idle non-irq GPIOs only from CPU_CLUSTER_PM_ENTER
as the selected cpuidle state triggers the domain transitions
with WFI. And that's why runtime_suspended_time does not increase
for a GPIO instance with IRQs.

I can reproduce the long ping latencies on duovero smsc connected
to gpio_44, I'll try to debug it more.

Regards,

Tony
