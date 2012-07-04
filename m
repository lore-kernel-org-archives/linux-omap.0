From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: how to specify dma_mask and coherent_dma_mask in hwmod
Date: Wed, 4 Jul 2012 10:41:40 +0100
Message-ID: <20120704094140.GB16639@n2100.arm.linux.org.uk>
References: <EB1619762EAF8B4E97A227FB77B7E0293E9AB214@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37680 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826Ab2GDJls (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 05:41:48 -0400
Content-Disposition: inline
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9AB214@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 07, 2012 at 04:22:17PM +0000, N, Mugunthan V wrote:
> While converting platform device registry to Hwmod for CPSW Ethernet
> driver which is present in AM335X (OMAP2+), I am not finding a way
> to specify dma_mask and coherent_dma_mask.
> Is there a way to specify dma_mask and coherent_dma_mask in hwmod?

Just remember that we're moving stuff to DMA engine, and that means
the sDMA device has DMA masks, but none of the peripherals which make
use of sDMA should have DMA masks set.

The reason for this is because the device responsible for accessing
memory is sDMA, not the peripheral device, and therefore any memory
properties for DMA should come from the sDMA device, not the peripheral
device.
