From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/6] ARM: OMAP: hwmod: remove runtime cpu_is checking
Date: Sun, 29 Apr 2012 10:29:03 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA02502@DBDE01.ent.ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58062 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802Ab2D2K3S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Apr 2012 06:29:18 -0400
In-Reply-To: <1335557140-10854-1-git-send-email-khilman@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Apr 28, 2012 at 01:35:34, Hilman, Kevin wrote:
> This series attempts to remove all the runtime cpu_is* checking in
> omap_hwmod.c in favor of using function pointers initialized at init
> time.
> 
> This series was motivated by the addition of support for the AM335x
> series which was done by adding several more cpu_is* checks, and
> provided the proverbial straw that broke the camel's back.  
> 
> In addition to the cleanup, this provides a much cleaner way of adding
> additional SoC support since it no longer requires adding additional
> runtime cpu_is* checks.
> 
> Boot tested on OMAP3530/Overo and OMAP4430/Panda.
> 

Also, tested on AM37xEVM. And also, will integrated for AM33xx development, so that I won't get into cpu_is_xxx check at all.


Thanks,
Vaibhav

> Kevin Hilman (6):
>   ARM: OMAP4: hwmod: rename _enable_module to _omap4_enable_module()
>   ARM: OMAP2+: hwmod: use init-time function ptrs for enable/disable
>     module
>   ARM: OMAP4: hwmod: drop extra cpu_is check from
>     _wait_target_disable()
>   ARM: OMAP2+: hwmod: use init-time function pointer for
>     wait_target_ready
>   ARM: OMAP2+: hwmod: use init-time function pointer for hardreset
>   ARM: OMAP2+: hwmod: use init-time function pointer for _init_clkdm
> 
>  arch/arm/mach-omap2/omap_hwmod.c             |  192 +++++++++++++++-----------
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |   11 ++
>  2 files changed, 126 insertions(+), 77 deletions(-)
> 
> -- 
> 1.7.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

