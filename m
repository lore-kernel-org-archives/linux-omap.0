From: Vinod Koul <vkoul@infradead.org>
Subject: Re: [RFC] dmaengine: Moving TI SDMA driver to dmaengine - design plan
Date: Tue, 12 Jul 2011 21:30:18 +0530
Message-ID: <1310486418.14637.1.camel@psiaudioba-mobl1>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CD17@dbde02.ent.ti.com>
	<20110708100410.GA4957@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110708100410.GA4957@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: vinod.koul@intel.com, "Raju, Sundaram" <sundaram@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Dan <dan.j.williams@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2011-07-08 at 11:04 +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 08, 2011 at 01:52:17PM +0530, Raju, Sundaram wrote:
> > I am planning to move TI SDMA driver in OMAP tree
> > into the dmaengine framework.
> > 
> > The first immediate issue of concern I noticed is the
> > huge number of client drivers that use the existing SDMA driver.
> > More than 15 client drivers are using the current SDMA driver.
> > 
> > Moving the SDMA driver along with all of these client drivers at a
> > single stretch seems a humungous task. 
> > I noticed a model in the existing DMA drivers in dmaengine
> > framework that will over come this issue. 
> 
> It _is_ sane to build a dmaengine driver on top of the existing SoC
> private API, then convert the drivers to DMA engine, and then cleanup
> the resulting DMA engine driver.
> 
> What we must make sure though is that the DMA engine slave API (which
> isn't well documented) is correctly implemented before drivers are
> converted over to use the DMA engine support code, otherwise we may
> end up with lots of drivers that require re-fixing several times over.
Russel,

Remember we have addressed the documentation part, is there something
else you feel is still missing?

-- 
~Vinod Koul
Intel Corp.
