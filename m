From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap3: fix compile-time warnings
Date: Mon, 28 Feb 2011 17:10:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102281709330.29478@utopia.booyaka.com>
References: <1297415100-15912-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36979 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab1CAAKR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 19:10:17 -0500
In-Reply-To: <1297415100-15912-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 11 Feb 2011, Sanjeev Premi wrote:

> This patch fixes these warnings when building kernel for OMAP3EVM
> only.
> 
>   CC      arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.o
> arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c:95: warning:
>  'dsp_24xx_wkdeps' defined but not used
> arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c:119: warning:
>  'mpu_24xx_wkdeps' defined but not used
> arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c:147: warning:
>  'core_24xx_wkdeps' defined but not used
> 
> The problem should be noticed when building for other OMAP3
> platforms (only) as well.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>

I just noticed this patch when digging through Patchwork.  I've dropped my 
(later) patch which does the same thing and applied this one instead for 
the 2.6.39 queue.


- Paul
