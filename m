From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC/PATCH 3/7] OMAP: McBSP: use existing macros for converting between devices
Date: Fri, 22 Jul 2011 13:19:21 -0700
Message-ID: <87y5zqysom.fsf@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-5-git-send-email-khilman@ti.com>
	<4E296DFB.3010205@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59916 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755132Ab1GVUTY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 16:19:24 -0400
Received: by mail-gy0-f180.google.com with SMTP id 4so2033781gyg.25
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 13:19:23 -0700 (PDT)
In-Reply-To: <4E296DFB.3010205@ru.mvista.com> (Sergei Shtylyov's message of
	"Fri, 22 Jul 2011 16:32:59 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi Sergei,

Sergei Shtylyov <sshtylyov@mvista.com> writes:

> On 22-07-2011 3:52, Kevin Hilman wrote:
>
>> For converting from struct device to platform_device, and from
>> platform_device to struct device,
>
>    You mean from platform_device to omap_device?
>

Yes indeed, thanks.  Updated patch below (only changelog changed)

Kevin


>From e3996fdb48e6850bc3f2a383e86fe67be5796d40 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Thu, 21 Jul 2011 14:03:51 -0700
Subject: [RFC/PATCH 3/7] OMAP: McBSP: use existing macros for converting
 between devices

For converting from struct device to platform_device, and from
platform_device to struct omap_device, there are existing macros.  Use
them instead of manual use of container_of().

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6c62af1..02199e8 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -260,9 +260,9 @@ EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap_device *find_omap_device_by_dev(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-					struct platform_device, dev);
-	return container_of(pdev, struct omap_device, pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return to_omap_device(pdev);
 }
 
 static void omap_st_on(struct omap_mcbsp *mcbsp)
-- 
1.7.6


