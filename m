From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: 4.16 OMAP serial transmit corruption?
Date: Wed, 18 Apr 2018 09:18:27 +0100
Message-ID: <20180418081827.GM10990@n2100.armlinux.org.uk>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416154545.GA5671@atomide.com>
 <413b774b-d19f-3221-44d5-7992d3b8757f@ti.com>
 <20180417173134.GD5671@atomide.com>
 <20180417221029.GL10990@n2100.armlinux.org.uk>
 <20180418005748.GE5671@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180418005748.GE5671@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 17, 2018 at 05:57:48PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [180417 22:12]:
> > On Tue, Apr 17, 2018 at 10:31:35AM -0700, Tony Lindgren wrote:
> > > * Vignesh R <vigneshr@ti.com> [180417 09:21]:
> > > > On Monday 16 April 2018 09:15 PM, Tony Lindgren wrote:
> > > > > Also, I'm seeing an issue where the UARTs won't idle on init
> > > > > with 8250_omap driver if connected to the wl12xx bluetooth port
> > > > > unless I write some data to the port first. It does not seem
> > > > > to be related to the rts/cts lines being wired as I've tested
> > > > > muxing them out of the way.
> > > > 
> > > > If this instance of UART is using DMA then it might be due an errata
> > > > worked around in AM33/AM43/DRA7:
> > > > https://patchwork.kernel.org/patch/6784331/
> > > 
> > > It sure sounds similar but UART_ERRATA_CLOCK_DISABLE does not
> > > seem to help with the reset. Also disabling DMA does not seem
> > > to help. So far the only way to clear it seems to be to write
> > > a character (TX) on the device. Then things work just fine
> > > even without UART_ERRATA_CLOCK_DISABLE set. I'll try to debug
> > > this more at some point.
> > 
> > Classic case of thread hijack.  So, Tony's idle problem gets more
> > attention on _my_ thread than _my_ issue about TX corruption, yea,
> > that's fair...  Come on guys, what about my problem, which is the
> > subject of this thread?
> 
> Just trying to brainstorm what all can go wrong still :) OK so
> it's not DMA then.
> 
> > I don't have CONFIG_SERIAL_8250_DMA set, so DMA can't be the issue.
> 
> Is this happening also with v4.16 or with v4.17-rc1?

4.16

> So you just edit something in vi and and on exit it happens?
> Not happening here for me..

Or run less, eg, dmesg | less or less /some/file.  It doesn't happen
with cat though.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
