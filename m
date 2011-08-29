From: Paul Walmsley <paul@pwsan.com>
Subject: Re: How to handle named resources with DT?
Date: Sun, 28 Aug 2011 19:57:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108281952400.18667@utopia.booyaka.com>
References: <20110809205723.GE11568@ponder.secretlab.ca> <201108261741.29850.arnd@arndb.de> <20110827143736.GA10182@yookeroo.fritz.box> <5595208.OB5dBohxQP@wuerfel> <20110828083934.GA4254@yookeroo.fritz.box>
 <alpine.DEB.2.00.1108281100150.23968@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46017 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab1H2B5g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Aug 2011 21:57:36 -0400
In-Reply-To: <alpine.DEB.2.00.1108281100150.23968@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

one case that I forgot to mention:

On Sun, 28 Aug 2011, Paul Walmsley wrote:

> Several upstream device drivers get their DMA request line IDs from the 
> device data format[14][15][16].  But more drivers should be doing this 
> than currently are[17]:
> 
> - the device driver author may have hardcoded the DMA request line ID, 
>   assuming it would never change
> 
> - DMA could be broken on the device due to hardware bugs, so it is unused
> 
> - the driver author may just never have gotten around to implementing DMA, 
>   or was reassigned to another project, or couldn't figure it out
> 
> - the device may have its own internal DMA controller logic, so support 
>   for an external DMA controller was simply never added

- the driver may be using software-initiated DMA, which doesn't use a 
  DMA request line, nor does it rely on the device to start or stop DMA.
  Instead, the CPU reprograms the DMA controller when the driver receives 
  an interrupt


- Paul
