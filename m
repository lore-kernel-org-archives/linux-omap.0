From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
Date: Sun, 2 Oct 2011 17:14:47 +0100
Message-ID: <20111002161447.GC12323@n2100.arm.linux.org.uk>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-16-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1317566760-25681-16-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sun, Oct 02, 2011 at 04:45:45PM +0200, Arnd Bergmann wrote:
> The logic to allow only one DMA driver in MUSB is currently
> flawed, because it also allows picking no DMA driver at all
> and also not selecting PIO mode.
> 
> Using a choice statement makes this foolproof for now and
> also simplifies the Makefile.
> 
> Unfortunately, we will have to revisit this when we start
> supporting multiple ARM platforms in a single kernel binary,
> because at that point we will actually need to select
> multiple DMA drivers and pick the right one at run-time.

I thought there was some work going on to convert this to use the
dmaengine stuff?

But in any case, a stop-gap fix is needed for randconfig.
