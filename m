From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH V4 13/16] irqchip: crossbar: Introduce
 ti,max-crossbar-sources to identify valid crossbar mapping
Date: Mon, 30 Jun 2014 15:30:09 -0400
Message-ID: <20140630193009.GB23978@titan.lakedaemon.net>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
 <1403766634-18543-14-git-send-email-r.sricharan@ti.com>
 <20140627120035.GB23978@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48072 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757149AbaF3TaV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 15:30:21 -0400
Content-Disposition: inline
In-Reply-To: <20140627120035.GB23978@titan.lakedaemon.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: nm@ti.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, joe@perches.com, tglx@linutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jun 27, 2014 at 08:00:35AM -0400, Jason Cooper wrote:
> On Thu, Jun 26, 2014 at 12:40:31PM +0530, Sricharan R wrote:
> > From: Nishanth Menon <nm@ti.com>
> > 
> > Currently we attempt to map any crossbar value to an IRQ, however,
> > this is not correct from hardware perspective. There is a max crossbar
> > event number upto which hardware supports. So describe the same in
> > device tree using 'ti,max-crossbar-sources' property and use it to
> > validate requests.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Sricharan R <r.sricharan@ti.com>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  .../devicetree/bindings/arm/omap/crossbar.txt      |    2 ++
> >  drivers/irqchip/irq-crossbar.c                     |   21 ++++++++++++++++++--
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> > index 5f45c78..6923531 100644
> > --- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> > +++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
> > @@ -10,6 +10,7 @@ Required properties:
> >  - compatible : Should be "ti,irq-crossbar"
> >  - reg: Base address and the size of the crossbar registers.
> >  - ti,max-irqs: Total number of irqs available at the interrupt controller.
> > +- ti,max-crossbar-sources: Maximum number of crossbar sources that can be routed.
> >  - ti,reg-size: Size of a individual register in bytes. Every individual
> >  	    register is assumed to be of same size. Valid sizes are 1, 2, 4.
> >  - ti,irqs-reserved: List of the reserved irq lines that are not muxed using
> > @@ -30,6 +31,7 @@ Examples:
> >  			compatible = "ti,irq-crossbar";
> >  			reg = <0x4a002a48 0x130>;
> >  			ti,max-irqs = <160>;
> > +			ti,max-crossbar-sources = <MAX_SOURCES>;
> 
> As mentioned in my reply to #15, I can change this to 400 when I apply
> it, or you can send a new version of #15 using the macro and explaining
> it's definition.
> 
> Thinking about it more, it's probably best just to use numbers in the
> docs.

I just did s/MAX_SOURCES/400/ when I applied this.  We shouldn't be
polluting the binding docs with implementation details.

thx,

Jason.
