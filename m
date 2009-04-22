From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: dma_alloc_coherent fragmentation
Date: Wed, 22 Apr 2009 14:21:55 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F6A7@dbde02.ent.ti.com>
References: <DFEF307E035C8647B119E6A60DB62D4A01793E6773@dlee02.ent.ti.com>
	 <20090319.084248.183029086.Hiroshi.DOYU@nokia.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF643980@dlee02.ent.ti.com>
	 <f502236f0904220046s50ff816cse752798deb895759@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F5F2@dbde02.ent.ti.com>
 <f502236f0904220123i6d278fdcj34abca9a7f6d8356@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60870 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZDVIwH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 04:52:07 -0400
In-Reply-To: <f502236f0904220123i6d278fdcj34abca9a7f6d8356@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pramod gurav <pramodforum@gmail.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

The actual apis are in mm/dmapool.c. There are quite a few users in the usb stack.

Here are few examples.

Amd5536udc.c (drivers\usb\gadget):	
Buffer.c (drivers\usb\core):
Ci13xxx_udc.c (drivers\usb\gadget)
Ci13xxx_udc.c (drivers\usb\gadget)
Cppi_dma.c (drivers\usb\musb):	
Ehci-mem.c (drivers\usb\host):
Ehci-mem.c (drivers\usb\host):
Ehci-mem.c (drivers\usb\host):
Ehci-mem.c (drivers\usb\host):
Ixp4xx_crypto.c (drivers\crypto):	
Ixp4xx_crypto.c (drivers\crypto):	
Ohci-mem.c (drivers\usb\host):
Ohci-mem.c (drivers\usb\host):
Uhci-hcd.c (drivers\usb\host):
Uhci-hcd.c (drivers\usb\host):

Regards,
Santosh
 

> -----Original Message-----
> From: pramod gurav [mailto:pramodforum@gmail.com] 
> Sent: Wednesday, April 22, 2009 1:54 PM
> To: Shilimkar, Santosh
> Cc: Menon, Nishanth; linux-omap@vger.kernel.org
> Subject: Re: dma_alloc_coherent fragmentation
> 
> Thanks for the quick reply.
> Can you please point me to some links on DMA pools. I am just 
> blank on this. :(
> I will still search for this in net.
> -- 