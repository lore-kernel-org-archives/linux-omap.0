From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: How to handle named resources with DT?
Date: Mon, 29 Aug 2011 19:18:53 +0200
Message-ID: <201108291918.53745.arnd@arndb.de>
References: <20110809205723.GE11568@ponder.secretlab.ca> <5595208.OB5dBohxQP@wuerfel> <20110828083934.GA4254@yookeroo.fritz.box>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61650 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464Ab1H2RTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 13:19:07 -0400
In-Reply-To: <20110828083934.GA4254@yookeroo.fritz.box>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sunday 28 August 2011, David Gibson wrote:
> > Right, and I guess we can simply ignore DMA and ioport resources because they
> > are extremely rare, right?
> 
> Well, remember it's where resources can appear in the DT node that
> matters, not what the types are in the platform device.  ioports will
> typically appear suitably encoded in 'reg', so that's covered.  I've
> never been very clear on what exactly DMA resources cover, but yeah,
> you might need something for dma-reg or other device tree properties.

DMA resources are only meaningful with the legacy ISA dma API, all
other uses are basically ad-hoc and I think we can ignore them or
replace them with proper bindings when converting the drivers to
device-tree based probing.

	Arnd
