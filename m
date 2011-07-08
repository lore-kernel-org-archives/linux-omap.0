From: "Raju, Sundaram" <sundaram@ti.com>
Subject: RE: [RFC] dmaengine: Moving TI SDMA driver to dmaengine - design
	plan
Date: Fri, 8 Jul 2011 15:44:02 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CDC4@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CD17@dbde02.ent.ti.com>
 <20110708100410.GA4957@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44045 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab1GHKOQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 06:14:16 -0400
In-Reply-To: <20110708100410.GA4957@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dan <dan.j.williams@intel.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Friday, July 08, 2011 3:34 PM
> To: Raju, Sundaram
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org; Dan;
> Shilimkar, Santosh; linux-kernel@vger.kernel.org
> Subject: Re: [RFC] dmaengine: Moving TI SDMA driver to dmaengine - design
> plan
> 
> On Fri, Jul 08, 2011 at 01:52:17PM +0530, Raju, Sundaram wrote:
> > I am planning to move TI SDMA driver in OMAP tree
> > into the dmaengine framework.
> >
> > The first immediate issue of concern I noticed is the
> > huge number of client drivers that use the existing SDMA driver.
> > More than 15 client drivers are using the current SDMA driver.
> >
> > Moving the SDMA driver along with all of these client drivers at a
> > single stretch seems a humungous task.
> > I noticed a model in the existing DMA drivers in dmaengine
> > framework that will over come this issue.
> 
> It _is_ sane to build a dmaengine driver on top of the existing SoC
> private API, then convert the drivers to DMA engine, and then cleanup
> the resulting DMA engine driver.

Yes, that is what I thought. Thanks.

> 
> What we must make sure though is that the DMA engine slave API (which
> isn't well documented) is correctly implemented before drivers are
> converted over to use the DMA engine support code, otherwise we may
> end up with lots of drivers that require re-fixing several times over.
>

Very true! Agreed!
I will send over the patches for review once I am done with testing.

Regards,
Sundaram
