From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v9 3/3] ARM: OMAP2+: gpmc: minimal driver support
Date: Wed, 12 Sep 2012 16:34:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209121631440.17903@utopia.booyaka.com>
References: <cover.1347355380.git.afzal@ti.com> <35901c3137e42170066f3efb5026b0749ccdcbb5.1347355380.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40616 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab2ILQeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 12:34:17 -0400
In-Reply-To: <35901c3137e42170066f3efb5026b0749ccdcbb5.1347355380.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Tue, 11 Sep 2012, Afzal Mohammed wrote:

> Create a minimal driver out of gpmc code.
> Responsibilities handled by earlier gpmc
> initialization is now achieved in probe.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Two checkpatch warnings are added by this patch:

CHECK: multiple assignments should be avoided
#77: FILE: arch/arm/mach-omap2/gpmc.c:454:
+	res->start = res->end = 0;

CHECK: Alignment should match open parenthesis
#216: FILE: arch/arm/mach-omap2/gpmc.c:936:
+	dev_info(gpmc_dev, "GPMC revision %d.%d\n",
+				GPMC_REVISION_MAJOR(l), GPMC_REVISION_MINOR(l));

I've fixed them here in the obvious way.  But please make sure that all 
your patches are clean with 'checkpatch.pl --strict'; saves us time and 
frustration...


- Paul
