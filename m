From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Tue, 30 Aug 2011 18:26:42 +0100
Message-ID: <20110830172642.GE3464@e102144-lin.cambridge.arm.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<1314722311.2344.64.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1314722311.2344.64.camel@deneb.redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Salter <msalter@redhat.com>
Cc: Russell King <linux@arm.linux.org.uk>, "greg@kroah.com" <greg@kroah.com>, "ming.lei@canonical.com" <ming.lei@canonical.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 30, 2011 at 05:38:30PM +0100, Mark Salter wrote:
> On Wed, 2011-08-31 at 00:03 +0800, ming.lei@canonical.com wrote:
> > +/*
> > + * Writing to dma coherent memory on ARM may be delayed via L2
> > + * writing buffer, so introduce the helper which can flush L2 writing
> > + * buffer into memory immediately, especially used to flush ehci
> > + * descriptor to memory.
> > + * */
> > +#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
> > +static inline void ehci_sync_mem()
> > +{
> > +       mb();
> > +}
> > +#else
> > +static inline void ehci_sync_mem()
> > +{
> > +}
> > +#endif
> > +
> 
> I'm wondering if this doesn't really belong in the DMA API for any
> future architectures that can't avoid prolonged write buffering to DMA
> coherent memory. IIUC, ARM mitigates this for most drivers by including
> an implicit write buffer flush in the mmio write routines. This takes
> care of the drivers which write to a mmio device register after writing
> something to shared DMA memory. IIUC, this doesn't help ehci because the
> host controller is polling to see what the cpu writes to the shared
> memory. Other hardware which polls shared memory like that will likely
> have the same problem and could use buffer drain helpers as well.

Right. In this case the buffering is happening at L2 which becomes
noticeable when measuring performance. We also buffer stores at the
CPU (regardless of memory type) but because these tend to become visible
fairly quickly, there isn't a comparable performance problem.

Given that I would expect other architectures to buffer writes at the CPU,
would it not be worth having an API for flushing to L3 (devices)? It seems
like this would be a useful addition to the coherent DMA API on platforms
that handle coherency with non-cacheable memory attributes.

Will
