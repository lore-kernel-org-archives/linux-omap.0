From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] dmaengine: Moving TI SDMA driver to dmaengine - design
	plan
Date: Fri, 8 Jul 2011 11:04:10 +0100
Message-ID: <20110708100410.GA4957@n2100.arm.linux.org.uk>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CD17@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58678 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab1GHKEZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 06:04:25 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94030259CD17@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raju, Sundaram" <sundaram@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dan <dan.j.williams@intel.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jul 08, 2011 at 01:52:17PM +0530, Raju, Sundaram wrote:
> I am planning to move TI SDMA driver in OMAP tree
> into the dmaengine framework.
> 
> The first immediate issue of concern I noticed is the
> huge number of client drivers that use the existing SDMA driver.
> More than 15 client drivers are using the current SDMA driver.
> 
> Moving the SDMA driver along with all of these client drivers at a
> single stretch seems a humungous task. 
> I noticed a model in the existing DMA drivers in dmaengine
> framework that will over come this issue. 

It _is_ sane to build a dmaengine driver on top of the existing SoC
private API, then convert the drivers to DMA engine, and then cleanup
the resulting DMA engine driver.

What we must make sure though is that the DMA engine slave API (which
isn't well documented) is correctly implemented before drivers are
converted over to use the DMA engine support code, otherwise we may
end up with lots of drivers that require re-fixing several times over.
