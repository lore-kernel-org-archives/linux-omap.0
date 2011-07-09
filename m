From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: omap_device: replace _find_by_pdev() with
 to_omap_device()
Date: Sat, 9 Jul 2011 16:40:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107091639290.15984@utopia.booyaka.com>
References: <1309980377-5964-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41796 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048Ab1GIWkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 18:40:19 -0400
In-Reply-To: <1309980377-5964-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, 6 Jul 2011, Kevin Hilman wrote:

> The omap_device layer currently has two ways of getting an omap_device
> pointer from a platform_device pointer.
> 
> Replace current usage of _find_by_pdev() with to_omap_device() since
> to_omap_device() is more familiar to the existing to_platform_device()
> used when getting a platform_device pointer from a struct device pointer.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Paul, please consider this minor cleanup for the v3.1 merge window.
> Applies to v3.0-c6.
> 
>  arch/arm/plat-omap/omap_device.c |   15 +++++----------
>  1 files changed, 5 insertions(+), 10 deletions(-)

Thanks, queued for 3.1 with Felipe's Reviewed-by at 
git://git.pwsan.com/linux-2.6 in 'omap_device_cleanup_3.1'.


- Paul
