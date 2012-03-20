From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Tue, 20 Mar 2012 10:02:13 -0400
Message-ID: <20120320140213.GG14084@beef>
References: <4F22DEF2.5000807@ti.com>
 <4F621939.9040906@ti.com>
 <20120315195753.GA2842@n2100.arm.linux.org.uk>
 <201203152041.53754.arnd@arndb.de>
 <4F626180.2010902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62018 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760033Ab2CTOBz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 10:01:55 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so65781iag.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 07:01:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F626180.2010902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>

On Thu, Mar 15, 2012 at 10:39:12PM +0100, Cousson, Benoit wrote:
> On 3/15/2012 9:41 PM, Arnd Bergmann wrote:
> >The numbers definitely need to become local to each of the controllers, but
> >that is the case pretty much automatically using the proposed binding,
> >because each dma request identifier starts with the phandle of the
> >controller.
> 
> Indeed, and in the case of the OMAP SDMA controller, it can handle
> up to 127 DMA request lines numbered from 0 to 126... So a local
> number seems to be a good representation... especially for a number.
> I'm not sure to understand the issue with this binding.
> 
> And AFAIK, there is the only one general purpose DMA controller in
> OMAP so far. The other ones are private to some IPs like MMC or USB,
> so they do not need necessarily need any DT representation.

AM335x has an EDMA controller instead of SDMA. This is the same EDMA
found on mach-davinci/ parts.

-Matt
