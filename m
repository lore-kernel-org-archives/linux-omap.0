From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: OMAP4430 SDP with KS8851: very slow networking
Date: Thu, 6 Dec 2018 18:08:07 +0000
Message-ID: <20181206180806.GV6920@n2100.armlinux.org.uk>
References: <20181206132256.GT30658@n2100.armlinux.org.uk>
 <20181206163154.GK6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181206163154.GK6707@atomide.com>
Sender: netdev-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 06, 2018 at 08:31:54AM -0800, Tony Lindgren wrote:
> Hi,
> 
> * Russell King - ARM Linux <linux@armlinux.org.uk> [181206 13:23]:
> > It looks very much like a receive problem - in that the board is not
> > always aware of a packet having been received until it attempts to
> > transmit (eg, in the case of TFTP, when it re-sends the ACK after a
> > receive timeout, it _then_ notices that there's a packet waiting.)
> > 
> > I'm not quite sure when this cropped up as I no longer regularly
> > update and run my nightly boot tests, but I think 4.18 was fine.
> 
> Sounds like it's some gpio or PM related issue. If it's not caused
> by commit b764a5863fd8 ("gpio: omap: Remove custom PM calls and
> use cpu_pm instead"), then maybe the changes to probe devices
> with ti-sysc interconnect target module driver caused it. Below
> is a revert for mcspi that would help in that case.

In the interests of keeping the mailing list record up to date, with
the following:

850d434ea37b ("gpio: omap: Remove set but not used variable 'dev'")
c4791bc6e3a6 ("gpio: omap: drop omap_gpio_list")
467480738d0b ("gpio: omap: get rid of the conditional PM runtime calls")
5284521a290e ("gpio: omap: Get rid of pm_runtime_irq_safe()")
b764a5863fd8 ("gpio: omap: Remove custom PM calls and use cpu_pm instead")

reverted, the problem is still there.  Revert:

ec0daae685b2 ("gpio: omap: Add level wakeup handling for omap4 based SoCs")

on top, and networking returns to normal.  So it appears to be this
last commit causing the issue.

With that and b764a5863fd8 applied, it still misbehaves.  Then, poking
at the OMAP4_GPIO_IRQWAKEN0 register, changing it from 0 to 4 with
devmem2 restores normal behaviour - ping times are normal and NFS is
happy.

# devmem2 0x48055044 w 4

(slightly more complex for me as its via NFS and needs different C
libraries from the ones on the rootfs.)

Given that this GPIO device is not runtime suspended, and is
permanently active (which is what I think we expect, given that it
has an IRQ claimed against it) does the hardware still attempt to
idle the GPIO block - if so, could that be why we need to program
the wakeup register, so the GPIO block signals that it's active?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
