From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 18 May 2012 21:43:54 +0000
Message-ID: <201205182143.55140.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201205182050.00095.arnd@arndb.de> <4FB6BA29.6070400@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53589 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759599Ab2ERVoR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 May 2012 17:44:17 -0400
In-Reply-To: <4FB6BA29.6070400@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Friday 18 May 2012, Stephen Warren wrote:
> > The driver can still request the dma line by name "tx" and the subsystem
> > would pick one out of those with the same name.
> > 
> > For the majority of cases, we would only need a single dma request line
> 
> Hmm. Many devices have multiple different FIFOs, and hence multiple DMA
> request signals (e.g. Tegra I2S has separate RX and TX FIFO, Tegra
> S/PDIF has 2 FIFOs in each direction). That would require the driver to
> always use get_by_name() to differentiate between 2/4 options for the
> same DMA req or 2/4 different DMA requests. Most other bindings allow
> use of get_by_id() or get_by_name() interchangeably.

Ok, good point. So we could make the common case that they are numbered
but not named and require all drivers to use named properties when
there is the possibility that the device might be connected to multiple
controllers, but that seems tricky because a driver can start being
used on a platform that has only one controller and have no dma-name
property in the device tree but then get used on a different soc
that actually has multiple controllers.
So if we do that, we might want to make the dma-names property mandatory
for every device, and document what the names are.

Another option would be to encode the direction in the property in
a generic way and provide an API that lets you ask specifically
for a read, write or readwrite channel out of the ones that are
available, rather than assuming there is only one kind. Consequently,
any device that uses more than one read channel or more than one
write channel would still have to use names to identify them.

	Arnd
