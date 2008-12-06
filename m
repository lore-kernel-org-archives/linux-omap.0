From: Tony Lindgren <tony@atomide.com>
Subject: Re: mmc broken?
Date: Fri, 5 Dec 2008 16:49:43 -0800
Message-ID: <20081206004942.GS9714@atomide.com>
References: <5e088bd90812051631i35d541d7peedcae421bf23bc3@mail.gmail.com> <20081206003432.GR9714@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Fba/0zbH8Xs+Fj9o"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64742 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbYLFAtp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 19:49:45 -0500
Content-Disposition: inline
In-Reply-To: <20081206003432.GR9714@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [081205 16:34]:
> * Steve Sakoman <sakoman@gmail.com> [081205 16:31]:
> > I attempted an Overo build this afternoon with
> > fb3d15c023ff08c879155db630895f38526b95f6.
> > 
> > I set bootargs for rootfs on mmc.  The boot progresses normally and
> > then hangs waiting for the rootfs to mount.
> > 
> > Where I previously got:
> > 
> >   Waiting for root device /dev/mmcblk0p2...
> >   mmc0: host does not support reading read-only switch. assuming write-enable.
> >   mmc0: new SD card at address ee21
> >   mmcblk0: mmc0:ee21 SU02G 1.89 GiB
> >    mmcblk0: p1 p2
> > 
> > I now get:
> > 
> >   Waiting for root device /dev/mmcblk0p2...
> > 
> > Has anyone else seen mmc issues with rc7?
> 
> I think I did it again while cleaning up.. Can you try this patch?
> The name was conflicting with the other MMC omap driver.

Actually now it breaks for earlier omaps, it  needs to be like this
patch instead.

> Tony


--Fba/0zbH8Xs+Fj9o
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mmc-fix.patch"

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 25c6d10..2c3c72f 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -204,9 +204,15 @@ int __init omap_mmc_add(int id, unsigned long base, unsigned long size,
 {
 	struct platform_device *pdev;
 	struct resource res[OMAP_MMC_NR_RES];
+	char *name;
 	int ret;
 
-	pdev = platform_device_alloc("mmci-omap", id);
+	if (cpu_class_is_omap1() || cpu_is_omap242x())
+		name = "mmci-omap";
+	else
+		name = "mmci-omap-hs";
+
+	pdev = platform_device_alloc(name, id);
 	if (!pdev)
 		return -ENOMEM;
 

--Fba/0zbH8Xs+Fj9o--
