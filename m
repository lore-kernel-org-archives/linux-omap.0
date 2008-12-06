From: Tony Lindgren <tony@atomide.com>
Subject: Re: mmc broken?
Date: Fri, 5 Dec 2008 16:34:37 -0800
Message-ID: <20081206003432.GR9714@atomide.com>
References: <5e088bd90812051631i35d541d7peedcae421bf23bc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58430 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbYLFAej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 19:34:39 -0500
Content-Disposition: inline
In-Reply-To: <5e088bd90812051631i35d541d7peedcae421bf23bc3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Steve Sakoman <sakoman@gmail.com> [081205 16:31]:
> I attempted an Overo build this afternoon with
> fb3d15c023ff08c879155db630895f38526b95f6.
> 
> I set bootargs for rootfs on mmc.  The boot progresses normally and
> then hangs waiting for the rootfs to mount.
> 
> Where I previously got:
> 
>   Waiting for root device /dev/mmcblk0p2...
>   mmc0: host does not support reading read-only switch. assuming write-enable.
>   mmc0: new SD card at address ee21
>   mmcblk0: mmc0:ee21 SU02G 1.89 GiB
>    mmcblk0: p1 p2
> 
> I now get:
> 
>   Waiting for root device /dev/mmcblk0p2...
> 
> Has anyone else seen mmc issues with rc7?

I think I did it again while cleaning up.. Can you try this patch?
The name was conflicting with the other MMC omap driver.

Tony

--wac7ysb48OaltWcw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mmc-fix.patch"

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 25c6d10..70108f8 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -206,7 +206,7 @@ int __init omap_mmc_add(int id, unsigned long base, unsigned long size,
 	struct resource res[OMAP_MMC_NR_RES];
 	int ret;
 
-	pdev = platform_device_alloc("mmci-omap", id);
+	pdev = platform_device_alloc("mmci-omap-hs", id);
 	if (!pdev)
 		return -ENOMEM;
 

--wac7ysb48OaltWcw--
