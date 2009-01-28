From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/10] omap mailbox: fix empty struct device for omap1
Date: Wed, 28 Jan 2009 17:50:43 +0000
Message-ID: <20090128175043.GB23301@n2100.arm.linux.org.uk>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com> <20090116082727.17571.87307.stgit@oreo.research.nokia.com> <20090128144955.GA23089@n2100.arm.linux.org.uk> <20090128.172951.193700554.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45078 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbZA1Ru5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 12:50:57 -0500
Content-Disposition: inline
In-Reply-To: <20090128.172951.193700554.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Wed, Jan 28, 2009 at 05:29:51PM +0200, Hiroshi DOYU wrote:
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 44e9101..af32db0 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -14,7 +14,9 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
> -#include <linux/io.h>
> +
> +#include <asm/io.h>
> +

NAK.

> diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
> index 59abbf3..92a90be 100644
> --- a/arch/arm/mach-omap1/mailbox.c
> +++ b/arch/arm/mach-omap1/mailbox.c
> @@ -1,7 +1,7 @@
>  /*
>   * Mailbox reservation modules for DSP
>   *
> - * Copyright (C) 2006 Nokia Corporation
> + * Copyright (C) 2006-2009 Nokia Corporation
>   * Written by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>   *
>   * This file is subject to the terms and conditions of the GNU General Public
> @@ -13,7 +13,9 @@
>  #include <linux/resource.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/io.h>
> +
> +#include <asm/io.h>
> +

NAK.

See fced80c735941fa518ac67c0b61bbe153fb8c050.

The above can not be explained by a mis-merge - they are not a mere
reversion of the above change.  They look like a purposeful change
back to the wrong include file.

Can someone please work out why this has happened and what needs to
be done to prevent it happening in the future.
