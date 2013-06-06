From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
Date: Thu, 6 Jun 2013 10:50:39 +0200
Message-ID: <20130606085039.GL23653@game.jcrosoft.org>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
 <51633F26.7000400@gmail.com> <51634835.5010302@collabora.co.uk>
 <20130605232647.55C8B3E10E4@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130605232647.55C8B3E10E4@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Jon Hunter <jon-hunter@ti.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 00:26 Thu 06 Jun     , Grant Likely wrote:
> On Tue, 09 Apr 2013 00:44:05 +0200, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
> > On 04/09/2013 12:05 AM, Rob Herring wrote:
> > > On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
> > >> This means that drivers that need the IRQ type/level flags defined in
> > >> the DT won't be able to get it.
> > > 
> > > But the interrupt controllers that need the information should be able
> > > to get to it via irqd_get_trigger_type. What problem exactly are you
> > > trying to fix? What driver would use this?
> > >
> > 
> > Yes but this is not about the interrupt controller wanting this information but
> > a device driver that is using the IORESOURCE_IRQ struct resource that has the
> > information about the virtual IRQ associated with a GPIO-IRQ.
> > 
> > The driver doesn't know neither care if its IRQ line is connected to a line of
> > an real IRQ controller or to a GPIO controller that allows a GPIO line to be
> > used as an IRQ.
> > 
> > > My understanding of the IORESOURCE_IRQ_xxx (and DMA) bits are they are
> > > ISA specific and therefore should not be used on non-ISA buses.
> > > 
> > 
> > Many TI OMAP2+ SoC based boards have an SMSC LAN911x/912x controller
> > (drivers/net/ethernet/smsc/smsc911x.c) that is connected to the OMAP processor
> > through its General-Purpose Memory Controller (GPMC) and this LAN driver obtain
> > its IRQ and I/O address space from a struct resource IORESOURCE_IRQ and
> > IORESOURCE_MEM respectively, that is filled by the DeviceTree core.
> > 
> > It does this:
> > 
> > irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
> > 
> > Since of_irq_to_resource() doesn't fill the trigger/level flags on the
> > IORESOURCE_IRQ struct resource, irq_flags will always be 0 regarding the value
> > specified on the second cell of the "interrupts" DT property.

why do you need to known this in you driver this need to be handle in the irq
chip

I does use irq gpio without at all

Best Regards,
J.
