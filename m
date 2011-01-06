From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3+: sr_device: include pm header
Date: Wed, 05 Jan 2011 16:28:01 -0800
Message-ID: <87y66yub8u.fsf@ti.com>
References: <1294083341-32147-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59877 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751470Ab1AFA2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 19:28:24 -0500
Received: by mail-yw0-f48.google.com with SMTP id 7so6728677ywo.21
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 16:28:23 -0800 (PST)
In-Reply-To: <1294083341-32147-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Mon, 3 Jan 2011 13:35:41 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>

Nishanth Menon <nm@ti.com> writes:

> omap_enable_smartreflex_on_init is meant to be used by boards
> which would like to have SR enabled by default on the platform, while
> omap_devinit_smartreflex is used by pm code, the protos are defined
> in pm.h. This header should be included to ensure that sr_device
> function definitions match the prototypes.
>
> including pm.h fixes the sparse warnings (with CONFIG_OMAP_SMARTREFLEX=y):
> arch/arm/mach-omap2/sr_device.c:138:13: warning: symbol 'omap_enable_smartreflex_on_init' was not declared. Should it be static?
> arch/arm/mach-omap2/sr_device.c:143:12: warning: symbol 'omap_devinit_smartreflex' was not declared. Should it be static?
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, will queue as a fix for 2.6.38-rc cycle.

Kevin

> Based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> branch: omap-for-linus
>
>  arch/arm/mach-omap2/sr_device.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
> index 786d685..b1e0af1 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -27,6 +27,7 @@
>  #include <plat/voltage.h>
>  
>  #include "control.h"
> +#include "pm.h"
>  
>  static bool sr_enable_on_init;
