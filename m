From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: How to handle named resources with DT?
Date: Sat, 27 Aug 2011 20:13:59 +0200
Message-ID: <5595208.OB5dBohxQP@wuerfel>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<201108261741.29850.arnd@arndb.de>
	<20110827143736.GA10182@yookeroo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110827143736.GA10182@yookeroo.fritz.box>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Cousson,
	Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sunday 28 August 2011 00:37:36 David Gibson wrote:
> On Fri, Aug 26, 2011 at 05:41:29PM +0200, Arnd Bergmann wrote:
> > On Friday 26 August 2011, Arnd Bergmann wrote:
> > > On Friday 26 August 2011, David Gibson wrote:
> > > > If you open code it this way then yes, it's silly.  But what about
> > > > something like this:
> > > > 
> > > > static struct of_device_id foodevice_of_match[] __devinitdata = {
> > > >         { .compatible = "foocorp,foodevice1234",
> > > >           .resource_names = {"base_regs", "extra_regs", }, },
> > > >         { .compatible = "foocorp,foodevice1239",
> > > >           .resource_names = {"base_regs", "extra_regs", "more_regs", }, }, 
> > > >         { },
> > > > };
> > > 
> > > Hmm, I hadn't thought of that. This looks quite nice indeed. No objections
> > > to this from my side.
> > > 
> > 
> > Ah well, one objection on second thought:
> > 
> > This assumes that there is just one type of resource, but named resources
> > may be used for iomem, ioport and irq resources. If you have multiple
> > IRQs and multiple IOMEM resources, I don't see how the index in the 
> > resource_names array can be used for both of them.
> 
> Details, shmetails, so you have both 'reg_names' and 'interrupt_names'.

Right, and I guess we can simply ignore DMA and ioport resources because they
are extremely rare, right?

One more detail: IIRC struct of_device_id is exported to module_init_tools
for purposes of autoloading, so changing the structure breaks user space.

	Arnd
