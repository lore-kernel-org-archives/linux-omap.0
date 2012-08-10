From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP: omap_device: track driver bound
 status
Date: Fri, 10 Aug 2012 16:57:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208101651220.29149@utopia.booyaka.com>
References: <1344623953-26434-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43222 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759358Ab2HJW5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Aug 2012 18:57:52 -0400
In-Reply-To: <1344623953-26434-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Fri, 10 Aug 2012, Kevin Hilman wrote:

> Add support for the omap_device layer to keep track of driver bound status.
> 
> This will be used to track whether or not a driver is bound in order
> to make intelligent omap_device enable/idle decisions (e.g. ensuring
> omap_devices are idled when no driver is present, or driver probe
> fails.)
> 
> Also, the omap_device layer implements PM domains for all
> omap_devices, and knowing whether or not a driver is bound is needed
> to know whether or not a drivers callbacks are valid, especially in
> cases of failed driver probe.
> 
> Kevin Hilman (3):
>   ARM: OMAP: omap_device: keep track of driver bound status
>   ARM: OMAP: omap_device: don't attempt late suspend if no driver bound
>   ARM: OMAP: omap_device: idle devices with no driver bound
> 
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/omap_device.c              |   56 ++++++++++++++++++++++---
>  2 files changed, 53 insertions(+), 5 deletions(-)

Thanks, these have been queued for 3.7 with a couple of changes to patch 
3.  Those changes fix a checkpatch issue, and drop the superfluous blank 
line at the top of omap_device.c added by an earlier commit.


- Paul
