From: Paul Walmsley <paul@pwsan.com>
Subject: RE: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Thu, 28 Jun 2012 09:52:54 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206280950440.2338@utopia.booyaka.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com> <B5906170F1614E41A8A28DE3B8D121433EAED507@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36430 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab2F1Pwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 11:52:55 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EAED507@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>

Hi

On Thu, 28 Jun 2012, Bedia, Vaibhav wrote:

> On Wed, Jun 27, 2012 at 11:11:32, N, Mugunthan V wrote:
> > > -----Original Message-----
> > > From: N, Mugunthan V
> > > Sent: Thursday, June 07, 2012 9:52 PM
> > > To: 'linux-omap@vger.kernel.org'
> > > Cc: 'linux-arm-kernel@lists.infradead.org'
> > > Subject: how to specify dma_mask and coherent_dma_mask in hwmod
> > > 
> > > While converting platform device registry to Hwmod for CPSW Ethernet
> > > driver which is present in AM335X (OMAP2+), I am not finding a way to
> > > specify
> > > dma_mask and coherent_dma_mask.
> > > Is there a way to specify dma_mask and coherent_dma_mask in hwmod?
> > 
> > Ping, any one has comment on this?
> 
> Right now there's no way of doing this in hwmod. But is omap_hwmod
> the right place for this? It would help if you could describe why
> the hwmod conversion is causing trouble for you.

dma_mask and coherent_dma_mask can be specified during 
device creation.  See usb_musb_init() in arch/arm/mach-omap2/usb-musb.c 
for an example.

I take it that you're just planning to set both of those to 0xffffffff?


- Paul
