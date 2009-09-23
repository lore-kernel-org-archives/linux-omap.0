From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2] OMAP3: iovmm: fix compiler warning
Date: Wed, 23 Sep 2009 12:22:15 +0300 (EEST)
Message-ID: <20090923.122215.246513921.Hiroshi.DOYU@nokia.com>
References: <1253697092-7808-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62400 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZIWJWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 05:22:25 -0400
In-Reply-To: <1253697092-7808-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: premi@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org

From: ext Sanjeev Premi <premi@ti.com>
Subject: [PATCH v2] OMAP3: iovmm: fix compiler warning
Date: Wed, 23 Sep 2009 11:11:32 +0200

> This patch fixes these compiler warnings:
> 
> arch/arm/plat-omap/iovmm.c: In function 'vmap_sg':
> arch/arm/plat-omap/iovmm.c:202: warning: passing argument 1 of
>  'flush_cache_vmap' makes integer from pointer without a cast
> arch/arm/plat-omap/iovmm.c:202: warning: passing argument 2 of
>  'flush_cache_vmap' makes integer from pointer without a cast
> arch/arm/plat-omap/iovmm.c: In function 'sgtable_fill_vmalloc':
> arch/arm/plat-omap/iovmm.c:393: warning: passing argument 1 of
>  'flush_cache_vmap' makes integer from pointer without a cast
> arch/arm/plat-omap/iovmm.c:393: warning: passing argument 2 of
>  'flush_cache_vmap' makes integer from pointer without a cast
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>

OK for me.
Tony, please put this in too.
