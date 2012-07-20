From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 20 Jul 2012 15:11:25 +0530
Message-ID: <1342777285.1726.444.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	 <201206271520.49276.arnd@arndb.de> <1342161907.1726.26.camel@vkoul-udesk3>
	 <201207171924.33756.arnd@arndb.de> <1342756850.1726.74.camel@vkoul-udesk3>
	 <87y5meu7dv.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39457 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791Ab2GTJlV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 05:41:21 -0400
In-Reply-To: <87y5meu7dv.fsf@free.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Fri, 2012-07-20 at 11:08 +0200, Robert Jarzmik wrote:
> Vinod Koul <vinod.koul@linux.intel.com> writes:
> 
> >> 4. A dma controller requiring complex configuration:
> >> 
> >>        dma: dmaengine@48000000 {
> >>                compatible = "foo,foo-sdma"
> >>                reg = <0x48000000 0x1000>;
> >>                interrupts = <4>;
> >>                #dma-cells = <6>; /* phandle, flag, request, channel,
> >> 					 input-width, output-width */
> > Why would we want the widths to be here?
> > Assuming a DMA from System memory to a peripheral, source width should
> > be system memory width and destination the peripheral width. IMO these
> > should not be in dma property even if we need these
> Hi Vinod,
> 
> I know at least one peripheral which accepts 2 widths, 8bit and 16bit, namely the
> M-Systems DiskOnChip G3 NAND chip.
> This device has to configured to choose either 8bit data bus access or 16bit
> data bus access.
That would be configured by the client (peripheral) driver and passed to
dmaengine driver using the slave config. The point is that it has
nothing to do with dma.

> 
> I'm just wondering if that usecase will fit in without the width information
> embedded, and how will the driver choose the width to use ?
It you need, this should be the client property and passed as argument
to dma, not a dma property :)


-- 
~Vinod

