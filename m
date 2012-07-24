From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 24 Jul 2012 18:55:37 +0000
Message-ID: <201207241855.37568.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201207240719.03601.arnd@arndb.de> <500EC7A5.6020907@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57545 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab2GXTZc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 15:25:32 -0400
In-Reply-To: <500EC7A5.6020907@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>

On Tuesday 24 July 2012, Stephen Warren wrote:
> It seems that given there are two values for dma-names, there really are
> two channels; it's just that one channel is bi-directional, and the
> second has two alternatives.
> 
> Still, I guess you could also view this as three separate channels
> instead. In which case, the text below makes sense.
> 
> > 3. A device with three channels, one of which has two alternatives:
> > 
> >         dmas = <&dma0 1 4   /* first channel,  data read */
> >                 &dma0 2 6   /* second channel, data write */
> >                 &dma1 1 0   /* third channel,  error read */
> >                 &dma2 1 0>; /* third channel,  ernative error read */
> >         dma-names = "data", "data", "error", "error";
> > 

A bidirectional channel would have only one request line, not two,
and we would write that as

	dmas = <&dma0 3 4>; /* one channel on dmarq 4, read-write */


	Arnd
