From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Thu, 28 Jun 2012 15:27:06 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EAED507@DBDE01.ent.ti.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36255 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab2F1P1P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 11:27:15 -0400
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "N, Mugunthan V" <mugunthanvnm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>

+Paul, Benoit and Kevin

On Wed, Jun 27, 2012 at 11:11:32, N, Mugunthan V wrote:
> > -----Original Message-----
> > From: N, Mugunthan V
> > Sent: Thursday, June 07, 2012 9:52 PM
> > To: 'linux-omap@vger.kernel.org'
> > Cc: 'linux-arm-kernel@lists.infradead.org'
> > Subject: how to specify dma_mask and coherent_dma_mask in hwmod
> > 
> > Hi
> > 
> > While converting platform device registry to Hwmod for CPSW Ethernet
> > driver which is present in AM335X (OMAP2+), I am not finding a way to
> > specify
> > dma_mask and coherent_dma_mask.
> > Is there a way to specify dma_mask and coherent_dma_mask in hwmod?
> 
> Ping, any one has comment on this?

Right now there's no way of doing this in hwmod. But is omap_hwmod
the right place for this? It would help if you could describe why
the hwmod conversion is causing trouble for you.

Regards,
Vaibhav B.
