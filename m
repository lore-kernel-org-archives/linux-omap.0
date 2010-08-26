From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/5 v3] OMAP2PLUS: WDT: Conversion to runtime PM
Date: Thu, 26 Aug 2010 16:03:36 -0700
Message-ID: <874oehx9h3.fsf@deeprootsystems.com>
References: <1281965809-20585-1-git-send-email-charu@ti.com>
	<1281965809-20585-2-git-send-email-charu@ti.com>
	<1281965809-20585-3-git-send-email-charu@ti.com>
	<1281965809-20585-4-git-send-email-charu@ti.com>
	<1281965809-20585-5-git-send-email-charu@ti.com>
	<1281965809-20585-6-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44004 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0HZXDk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:03:40 -0400
Received: by gwj17 with SMTP id 17so890967gwj.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 16:03:39 -0700 (PDT)
In-Reply-To: <1281965809-20585-6-git-send-email-charu@ti.com> (Charulatha V.'s
	message of "Mon, 16 Aug 2010 19:06:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, wim@iguana.be, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com

Charulatha V <charu@ti.com> writes:

> This patch converts the OMAP Watchdog timer driver to
> get adapted to HWMOD FW and to use the runtime PM APIs.

Technically, the driver knows nothing about the HWMOD framework, as
that's an OMAP core implementation detail.

What's really happening here is two separate things:

1) conversion of driver to runtime PM instead of clock framework
2) convert platform_device/_data over to be omap_device-based

These should be done in two separate patches (and in that order.) 

Other than that, the patch contents look good.  Some minor comments below...

> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Basak, Partha <p-basak2@ti.com>
> ---
>  arch/arm/plat-omap/devices.c |   64 ++++++++++++++++++++++++++++-------------
>  drivers/watchdog/omap_wdt.c  |   43 +++++-----------------------
>  2 files changed, 52 insertions(+), 55 deletions(-)
>

[...]

> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 76b58ab..7645ca3 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -38,13 +38,14 @@
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
>  #include <linux/moduleparam.h>
> -#include <linux/clk.h>
>  #include <linux/bitops.h>
>  #include <linux/io.h>
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>  #include <mach/hardware.h>
>  #include <plat/prcm.h>
> +#include <plat/omap_device.h>

This should not be needed in the driver, as there is no need for driver
to call omap_device API.

[...]

Kevin

