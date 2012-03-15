From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Thu, 15 Mar 2012 09:26:52 +0000
Message-ID: <20120315092652.GA16389@n2100.arm.linux.org.uk>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <201203150922.06379.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201203150922.06379.arnd@arndb.de>
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
Cc: Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Thierry Reding <thierry.reding@avionic-design.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 15, 2012 at 09:22:06AM +0000, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Nicolas Ferre wrote:
> > Add some basic helpers to retrieve a DMA controller device_node and the
> > DMA request specifications. By making DMA controllers register a generic
> > translation function, we allow the management of any type of DMA requests
> > specification.
> > The void * output of an of_dma_xlate() function that will be implemented
> > by the DMA controller can carry any type of "dma-request" argument.
> > 
> > The DMA client will search its associated DMA controller in the list and
> > call the registered of_dam_xlate() function to retrieve the request values.
> > 
> > One simple xlate function is provided for the "single number" type of
> > request binding.
> > 
> > This implementation is independent from dmaengine so it can also be used
> > by legacy drivers.
> > 
> > For legacy reason another API will export the DMA request number into a
> > Linux resource of type IORESOURCE_DMA.
> 
> This looks very good. I missed the first version of this patch, but was
> thinking of very similar bindings.

There's one issue which is concerning me - when we switch OMAP to use
DMA engine, it won't use numeric stuff anymore but the DMA engine way
of requesting a channel (match function + data).

How does that fit into this scheme?
