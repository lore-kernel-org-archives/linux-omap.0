From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/2] McSPI Slave and DMA,FIFO support
Date: Wed, 20 May 2009 11:48:20 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49CC02C@dbde02.ent.ti.com>
References: <54349.10.24.255.18.1242799017.squirrel@dbdmail.itg.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030574190F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60962 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbZETGS1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 02:18:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4K6IM08027721
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 01:18:28 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030574190F@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "V, Hemanth" <hemanthv@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> > +
> > +	/* SPI2 Pin MUX */
> > +	omap_cfg_reg(AA3_3430_McSPI2_CLK);
> > +	omap_cfg_reg(Y2_3430_McSPI2_SIMO);
> > +	omap_cfg_reg(Y3_3430_McSPI2_SOMI);
> > +	omap_cfg_reg(Y4_3430_McSPI2_CS0);
> > +
> 
> This will still change the padconf for this port unconditionally.
> 
> How do we handle the case where the same platform (SDP in this case)
> could have different configurations McSPI2 vs USBHOST2, etc? Is there
> a clean way, or do we have no option but to use a CONFIG option?

How about boot_arg or in case usb is a loadable module then module argument ?