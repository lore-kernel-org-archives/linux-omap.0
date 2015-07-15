From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip: omap-intc: improve IRQ handler
Date: Wed, 15 Jul 2015 14:36:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507151435480.18576@nanos>
References: <1420224433-27001-1-git-send-email-balbi@ti.com>
 <20150119213458.GK18552@atomide.com> <20150715064923.GA17550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150715064923.GA17550@atomide.com>
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
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On Wed, 15 Jul 2015, Tony Lindgren wrote:
> Felipe,
> 
> * Tony Lindgren <tony@atomide.com> [150119 13:41]:
> > * Felipe Balbi <balbi@ti.com> [150102 10:50]:
> > > as it turns out the current IRQ number will
> > > *always* be available from SIR register which
> > > renders the reads of PENDING registers as plain
> > > unnecessary overhead.
> > > 
> > > In order to catch any situation where SIR reads
> > > as zero, we're adding a WARN() to turn it into
> > > a very verbose error and users actually report
> > > it.
> > > 
> > > With this patch average running time of
> > > omap_intc_handle_irq() reduced from about 28.5us
> > > to 19.8us as measured by the kernel function
> > > profiler.
> > > 
> > > Tested with BeagleBoneBlack Rev A5C.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > 
> > Jason, looks like this is not showing up in Linux next. The
> > same for the changes I did for dm81xx.
> 
> Can you please resend this to Jason? Looks like this
> is still not merged.

Please send it to me asap and please cc lkml on irqchip patches.

Thanks,

	tglx
