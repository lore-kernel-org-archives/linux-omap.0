From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as
 default
Date: Sat, 13 Sep 2008 07:48:44 +0300 (EEST)
Message-ID: <20080913.074844.161898930.Hiroshi.DOYU@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A5344A4F050@dlee03.ent.ti.com>
	<27F9C60D11D683428E133F85D2BB4A5344A4F051@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40849 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYIMEs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 00:48:56 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5344A4F051@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x00omar@ti.com
Cc: linux-omap@vger.kernel.org

Hi Omar,

From: "ext Ramirez Luna, Omar" <x00omar@ti.com>
Subject: RE: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as default
Date: Fri, 12 Sep 2008 23:27:01 -0500

> 
> >From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> >Date: Fri, 12 Sep 2008 22:09:45 -0500
> >Subject: [PATCH] BRIDGE: set 0 for phys_mempool_* as default
> 
> For this to work, we have observed that you must increase the size of Consistent DMA memory up to 14 MB, this is what we consider to be a safe standard size for bridge to work along with other OMAP components.
> 
> You can find this on menuconfig:
> 	-> Device Drivers                                                                                 
> 		-> Graphics support
> 		FB_OMAP_CONSISTENT_DMA_SIZE [=14]

Right.

I think that this configuration name "FB_OMAP_CONSISTENT_DMA_SIZE"
sounds a bit strange because it is not specific to framebuffer.

So how about renaming this more generic name like
"OMAP_CONSISTENT_DMA_SIZE"? Or making "CONSISTENT_DMA_SIZE" itself
configurable in menuconfig?

	Hiroshi DOYU
