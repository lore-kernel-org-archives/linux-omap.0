From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 01/10] ARM: OMAP3/4: cpuidle: fix sparse and checkpatch
 warnings
Date: Wed, 12 Dec 2012 10:28:34 +0100
Message-ID: <50C84E42.2040402@ti.com>
References: <20121209011755.19716.25244.stgit@dusk.lan> <20121209012334.19716.44831.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33900 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab2LLJ2B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Dec 2012 04:28:01 -0500
In-Reply-To: <20121209012334.19716.44831.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>

On Sunday 09 December 2012 02:23 AM, Paul Walmsley wrote:
> Fix the following sparse warnings in the OMAP3/4 CPUIdle code:
>
> arch/arm/mach-omap2/cpuidle34xx.c:272:1: warning: symbol 'omap3_idle_dev' was not declared. Should it be static?
> arch/arm/mach-omap2/cpuidle34xx.c:274:23: warning: symbol 'omap3_idle_driver' was not declared. Should it be static?
> arch/arm/mach-omap2/cpuidle44xx.c:164:1: warning: symbol 'omap4_idle_dev' was not declared. Should it be static?
> arch/arm/mach-omap2/cpuidle44xx.c:166:23: warning: symbol 'omap4_idle_driver' was not declared. Should it be static?
>
> Also fix the following checkpatch warnings:
>
> WARNING: please, no space before tabs
> #44: FILE: arch/arm/mach-omap2/cpuidle34xx.c:105:
> +^I.name = ^I"omap3_idle",$
>
> WARNING: please, no space before tabs
> #45: FILE: arch/arm/mach-omap2/cpuidle34xx.c:106:
> +^I.owner = ^ITHIS_MODULE,$
>
> ERROR: code indent should use tabs where possible
> #211: FILE: arch/arm/mach-omap2/cpuidle44xx.c:74:
> +                        /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */$
>
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---

Acked-by: Santosh Shilimkar@ti.com

