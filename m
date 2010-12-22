From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v6 0/7] nand prefetch-irq support and ecc layout chanage
Date: Wed, 22 Dec 2010 13:13:13 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A3B0397@dbde02.ent.ti.com>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
 <201012201045.53688.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43040 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab0LVHn1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 02:43:27 -0500
In-Reply-To: <201012201045.53688.manningc2@actrix.gen.nz>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: Charles Manning [mailto:manningc2@actrix.gen.nz]
> Sent: Monday, December 20, 2010 3:16 AM
> To: linux-mtd@lists.infradead.org
> Cc: Ghorai, Sukumar; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v6 0/7] nand prefetch-irq support and ecc layout
> chanage
> 
> On Saturday 27 November 2010 04:34:30 Sukumar Ghorai wrote:
> > The following set of patches applies on linux-2.6.
> >
> > The main motivations behind this patch series are -
> >         1. support NAND I/O in irq mode.
> >         2. support of different ECC schema.
> >         3. also to make ecc layout as like in romcode ecc layout
> 
> Why change the ECC layout?
> 
> Be very careful when you change ECC layouts. This can break production
> systems.
> 
> For example if people are running something earlier and then want to
> deliver a
> new kernel with 2.6.37 then their existing NAND file systems will no
> longer
> be readable.
> 
> Changes to ECC should only be done for very good reasons and should be
> controlled with a Kconfig with the default being the existing ECC layout.
> 
[Ghorai] we are just adding few ecc-layout(s) and based on the request from different customer. The default ecc-layout is the old one for backward compatibility and selection of ecc-layput is exposed form board file.  

