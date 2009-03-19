From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: dma_alloc_coherent fragmentation
Date: Thu, 19 Mar 2009 08:42:48 +0200 (EET)
Message-ID: <20090319.084248.183029086.Hiroshi.DOYU@nokia.com>
References: <DFEF307E035C8647B119E6A60DB62D4A01793E6773@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20561 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbZCSGnM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 02:43:12 -0400
In-Reply-To: <DFEF307E035C8647B119E6A60DB62D4A01793E6773@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-arm-kernel@lists.arm.linux.org.uk, nskamat@ti.com, linux-omap@vger.kernel.org, x00omar@ti.com, h-kanigeri2@ti.com, x0095840@ti.com, khilman@deeprootsystems.com, 2ameya@gmail.com

Hi Nishant,

From: "ext Kamat, Nishant" <nskamat@ti.com>
Subject: dma_alloc_coherent fragmentation
Date: Wed, 18 Mar 2009 14:03:45 +0100

> Forwarding on behalf of Nishanth Menon:
> 
> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Tuesday, March 17, 2009 8:17 AM
> To: 'linux-arm-kernel@lists.arm.linux.org.uk'
> Cc: Gupta, Ramesh; Kevin Hilman; linux-omap@vger.kernel.org; Ramirez Luna, Omar; Kanigeri, Hari; Ameya Palande; Guzman Lugo, Fernando; Ameya Palande
> Subject: dma_alloc_coherent fragmentation
> 
> Looping in linux-arm ML:
> 
> Discussion Ref: [1](linux-omap mailing list)
> While working with Linux OMAP kernel[2] we found that on allocating
> 4 meg chunks using dma_alloc_coherent and de-allocating with
> dma_free_coherent in a loop using a test driver[7], the memory is
> getting fragmented as shown by Ameya's observation [3] finally
> resulting in dump_stack due to lack of pages.

What would happen with __GFP_RECLAIMABLE for dma_alloc_coherent()?
