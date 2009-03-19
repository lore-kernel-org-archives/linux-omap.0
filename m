From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: dma_alloc_coherent fragmentation
Date: Thu, 19 Mar 2009 04:06:29 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF643980@dlee02.ent.ti.com>
References: <DFEF307E035C8647B119E6A60DB62D4A01793E6773@dlee02.ent.ti.com>
 <20090319.084248.183029086.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54224 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992AbZCSJG6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 05:06:58 -0400
In-Reply-To: <20090319.084248.183029086.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "Kamat, Nishant" <nskamat@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "2ameya@gmail.com" <2ameya@gmail.com>

Hi Hiroshi,
> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Thursday, March 19, 2009 8:43 AM

> 
> 
> What would happen with __GFP_RECLAIMABLE for dma_alloc_coherent()?
As per [1], GFP_TEMPORARY might be the right approach.. but yes,
Changing dummy to do:
dma_alloc_coherent(NULL, b[i].size, &b[i].phy, GFP_TEMPORARY);

Seems to resolve the issue with the dummy driver.

The question however still remains: For a driver to allocate a memory which is not temporary in nature we'd recommend GFP_KERNEL. But as part of the exit sequence the driver will deallocate that memory and as part of init sequence, reallocate. Given that the memory is not reclaimed immediately, it looks like the only way to ensure that would be to do GFP_KERNEL | __GFP_RECLAIMABLE (which essentially is the definition of GFP_TEMPORARY).

Regards,
Nishanth Menon
Ref:
[1] http://lkml.indiana.edu/hypermail/linux/kernel/0705.2/0638.html
