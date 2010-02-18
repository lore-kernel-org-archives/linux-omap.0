From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 7/9] omap4: Add auto-generated irq and dma headers
Date: Thu, 18 Feb 2010 23:03:47 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C417F8FE@dbde02.ent.ti.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-3-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-4-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-5-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-6-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-7-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1002181014470.24812@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36114 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757440Ab0BRReD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 12:34:03 -0500
In-Reply-To: <alpine.DEB.2.00.1002181014470.24812@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, February 18, 2010 10:53 PM
> To: Shilimkar, Santosh
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Cousson,
> Benoit
> Subject: Re: [PATCH 7/9] omap4: Add auto-generated irq and dma headers
> 
> Hello Santosh,
> 
> thanks for sending these in.  One minor comment:
> 
> On Thu, 18 Feb 2010, Santosh Shilimkar wrote:
> 
> > These files are generated along with the HWMOD and will eventually be
> > in the existing header files as soon as all drivers will be migrate to
> > omap_hwmod / omap_device.
> >
> > The dma-44xx.h file should be in 'arch/arm/mach-omap2/include/mach/',
> > but this would need dma.h header also present in the mach directory to
> > make local include possible, like what is done for irq.h. Then the
> > script is needed to modify the drivers to include 'mach/dma.h' instead
> > of 'plat/dma.h'. This would be a bigger change and hence left out for now
> 
> I think I originally wrote the DMA generator script, so please add a Nokia
> copyright and put my name in there also.  After that point, it has my ack.
Sure Paul. Will add that information and send updated patch.

Benoit,
We need to update the scripts and regenerate this. I will do that.

Regards,
Santosh 
