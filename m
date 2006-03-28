From: tony@atomide.com
Subject: Re: DMA support for smc91x
Date: Tue, 28 Mar 2006 05:50:28 -0800
Message-ID: <20060328135027.GE28751@atomide.com>
References: <20060324002336.GA13667@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060324002336.GA13667@orphique>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [060323 16:23]:
> Hi,
> 
> this mail contains dirty and for most people completely useless patch.
> Here is my motivation for it: I have OMAP based board using LAN91C111,
> its interrupt line is routed to GPIO pin. Other GPIO lines are used as
> interrupt sources for ISDN chips which needs to be services regulary
> (irq can be generated per 125us for each of four chips). All interrupts
> from GPIOs are serialized, so if smc91x needs 1.6ms to read 8 full size
> packets from memory, communication with ISDN chips gets screwed. Even
> decreasing MAX_IRQ_LOOPS to 1 doesn't help too much here, because single
> full size packet reading takes 200us. Now programing DMA takes only 6us
> and rest of CPU time is left for sometning usesfull :-). Patch is
> pre-alpha quality, there are some locking bugs - reading from eeprom
> while DMA is progress will result in undefined behaviour (but there
> is not eeprom support upstream, so who cares ;-)) - and I just want to
> ask if anyone else would need something it and provide some feedback.
> Then I may think a bit more, finish it and send it to proper mailing
> list.

That's cool :)

Tony
