From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
Date: Sun, 02 Oct 2011 20:00:31 +0200
Message-ID: <1757336.Qk72n3s00p@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-16-git-send-email-arnd@arndb.de>
	<20111002161447.GC12323@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111002161447.GC12323@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sunday 02 October 2011 17:14:47 Russell King - ARM Linux wrote:
> On Sun, Oct 02, 2011 at 04:45:45PM +0200, Arnd Bergmann wrote:
> > The logic to allow only one DMA driver in MUSB is currently
> > flawed, because it also allows picking no DMA driver at all
> > and also not selecting PIO mode.
> > 
> > Using a choice statement makes this foolproof for now and
> > also simplifies the Makefile.
> > 
> > Unfortunately, we will have to revisit this when we start
> > supporting multiple ARM platforms in a single kernel binary,
> > because at that point we will actually need to select
> > multiple DMA drivers and pick the right one at run-time.
> 
> I thought there was some work going on to convert this to use the
> dmaengine stuff?

That would certainly be the best solution here, I wasn't aware
that it has already been discussed.

Unfortunately, even with the dma parts out of the way there is
a lot that needs to be done to make musb, ehci or ohci
really cross-platform. Right now, you can only have one
platform driver glue for each of those drivers, and they
should eventually be converted to a large library module for
the core, with independent platform driver front-end, similar
to the recent conversion of the sdhci driver by Shawn Guo,
and the way that a lot of the other common drivers work.

	Arnd
