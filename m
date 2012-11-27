From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] net: cpts: fix for build break after ARM SoC
 integration
Date: Tue, 27 Nov 2012 14:42:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211271442270.20857@utopia.booyaka.com>
References: <1354012034-31686-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36974 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab2K0Omn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Nov 2012 09:42:43 -0500
In-Reply-To: <1354012034-31686-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, b-cousson@ti.com, richardcochran@gmail.com

On Tue, 27 Nov 2012, Mugunthan V N wrote:

>   CC      drivers/net/ethernet/ti/cpts.o
> drivers/net/ethernet/ti/cpts.c:30:24: fatal error: plat/clock.h: No such file or directory
> compilation terminated.
> make[4]: *** [drivers/net/ethernet/ti/cpts.o] Error 1
> make[3]: *** [drivers/net/ethernet/ti] Error 2
> make[2]: *** [drivers/net/ethernet] Error 2
> make[1]: *** [drivers/net] Error 2
> 
> fix for build break as the header file is removed from plat-omap as part of
> the below patch
> 
> commit a135eaae524acba1509a3b19c97fae556e4da7cd
> Author: Paul Walmsley <paul@pwsan.com>
> Date:   Thu Sep 27 10:33:34 2012 -0600
> 
>     ARM: OMAP: remove plat/clock.h
> 
>     Remove arch/arm/plat-omap/include/plat/clock.h by merging it into
>     arch/arm/mach-omap1/clock.h and arch/arm/mach-omap2/clock.h.
>     The goal here is to facilitate ARM single image kernels by removing
>     includes via the "plat/" symlink.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
