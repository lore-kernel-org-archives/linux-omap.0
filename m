From: Paul Walmsley <paul@pwsan.com>
Subject: RE: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Thu, 28 Jun 2012 10:32:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206281031510.2338@utopia.booyaka.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com> <B5906170F1614E41A8A28DE3B8D121433EAED507@DBDE01.ent.ti.com> <alpine.DEB.2.00.1206280950440.2338@utopia.booyaka.com> <B5906170F1614E41A8A28DE3B8D121433EAED713@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60807 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab2F1Qcr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 12:32:47 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EAED713@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "N, Mugunthan V" <mugunthanvnm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>

On Thu, 28 Jun 2012, Bedia, Vaibhav wrote:

> On Thu, Jun 28, 2012 at 21:22:54, Paul Walmsley wrote:
> [...]
> > 
> > dma_mask and coherent_dma_mask can be specified during 
> > device creation.  See usb_musb_init() in arch/arm/mach-omap2/usb-musb.c 
> > for an example.
> > 
> 
> Thanks for pointing this out. Should omap_device_build() start handling this
> or would that be an overkill?

If both dma_mask and coherent_dma_mask are always 0xffffffff on all OMAPs 
and we can set that safely even for devices that don't use it, then yeah 
it sounds like we should set it.

Care to send a patch?


- Paul
