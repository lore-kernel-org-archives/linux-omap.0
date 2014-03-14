From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] iommu/omap: Use the cache cleaning API
Date: Fri, 14 Mar 2014 17:57:48 +0100
Message-ID: <201403141757.48824.arnd@arndb.de>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com> <53226DD5.6070208@ti.com> <53232B0F.6090701@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.131]:55502 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052AbaCNQ54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2014 12:57:56 -0400
In-Reply-To: <53232B0F.6090701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "Anna, Suman" <s-anna@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Florian Vaussard <florian.vaussard@epfl.ch>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Friday 14 March 2014, Santosh Shilimkar wrote:
> I remember NAKing this approach in past and my stand remains same.
> The cache APIs which you are trying to use here are not suppose
> to be used outside.
> 
> I think the right way to fix this is to make use of streaming APIs.
> If needed, IOMMU can have its own dma_ops for special case
> handling if any.
> 
> Russell, Arnd might have more ideas.

I have a bad feeling about using the dma-mapping API within the
IOMMU code, because that driver is also used to implement the
dma-mapping API for devices attached to the IOMMU. It's possible
that it just works.

Is the IOMMU actually designed to have page tables in noncoherent
memory? I would have expected that the iopt accesses must all be
done on dma_alloc_coherent() provided memory to guarantee proper
accesses.

	Arnd
