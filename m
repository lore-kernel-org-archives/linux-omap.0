From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Thu, 28 Jun 2012 16:31:22 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EAED713@DBDE01.ent.ti.com>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9BDE96@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EAED507@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1206280950440.2338@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50491 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538Ab2F1Qba convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 12:31:30 -0400
In-Reply-To: <alpine.DEB.2.00.1206280950440.2338@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>

Hi Paul,

On Thu, Jun 28, 2012 at 21:22:54, Paul Walmsley wrote:
[...]
> 
> dma_mask and coherent_dma_mask can be specified during 
> device creation.  See usb_musb_init() in arch/arm/mach-omap2/usb-musb.c 
> for an example.
> 

Thanks for pointing this out. Should omap_device_build() start handling this
or would that be an overkill?

Regards,
Vaibhav B.

