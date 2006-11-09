From: Tony Lindgren <tony@atomide.com>
Subject: Re: patchs commits
Date: Thu, 9 Nov 2006 22:51:57 +0200
Message-ID: <20061109205157.GF16172@atomide.com>
References: <20061109202835.GD16172@atomide.com>
	<002201c7043f$d030ac50$818310ac@mis.cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <002201c7043f$d030ac50$818310ac@mis.cypress.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Hingkwan Huen <hkh@cypress.com>
Cc: 'OMAP' <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Hingkwan Huen <hkh@cypress.com> [061109 22:44]:
> Hello Tony,
> 
> How about OMAP2? Is there a way that I can find out the supported list of
> features for OMAP2, well, OMAP2420 H4 in particular?

The core stuff should be pretty well in sync for basic stuff such
as irq, timers, gpio, dma etc. But at least power management is still
not very functional. There should be some patches coming for PM, but
it may take a little while longer.

For the drivers, serial, NOR, i2c, and smc91x should work in mainline tree. 
Framebuffer should work in linux-omap tree. MMC is probably currently
broken for Menelaus, but there are some patches coming for that.

Hope that helps,

Tony
