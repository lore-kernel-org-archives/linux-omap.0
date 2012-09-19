From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Wed, 19 Sep 2012 10:40:40 -0400
Message-ID: <20120919144040.GC16522@beef>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
 <20120919140705.GB16522@beef>
 <201209191424.56086.arnd@arndb.de>
 <5059D874.6040107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:47152 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab2ISOjE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 10:39:04 -0400
Received: by ggdk6 with SMTP id k6so267131ggd.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 07:39:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5059D874.6040107@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jon Hunter <jon-hunter@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>

On Wed, Sep 19, 2012 at 09:36:36AM -0500, Rob Herring wrote:
> On 09/19/2012 09:24 AM, Arnd Bergmann wrote:
> > On Wednesday 19 September 2012, Matt Porter wrote:
> >>> +Optional properties:
> >>> +- #dma-channels:     Number of DMA channels supported by the controller.
> >>> +- #dma-requests:     Number of DMA requests signals supported by the
> >>> +                     controller.
> >>
> >> Shouldn't these two optional properties drop the prefix #?  By
> >> convention adopted from the various original OF/ePAPR/etc specs, the
> >> only properties I would expect to see with this prefix are the
> >> "*-cells" cell sizes. A quick search indicates this is the case
> >> throughout all the current bindings.
> > 
> > I always assumed that the # prefix is used to indicate that we are counting
> > things instead of listing them.
> 
> Lots of properties count things, but don't have a #. nr_gpios or spi
> chipselect counts for example. I'd say drop the #.

Ok, I can drop another trivial patch since I hear Jon is on vacation.

Yeah, I grepped all the bindings and it's only ever encountered on cell
sizes. There's not even one example of it used as above.

-Matt
