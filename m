From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Resending - PATCH 1/3] Triton BCI driver device setup for OMAP3430
Date: Thu, 03 Jul 2008 08:08:32 -0500
Message-ID: <60b6f36a0c398d87284f428bc42c7a79@felipebalbi.com>
References: <44944.192.168.10.88.1215086750.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33485 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762108AbYGCNIf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 09:08:35 -0400
In-Reply-To: <44944.192.168.10.88.1215086750.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org



On Thu, 3 Jul 2008 17:35:50 +0530 (IST), "Madhusudhan Chikkature"
<madhu.cr@ti.com> wrote:

> Index: linux-omap-2.6/arch/arm/mach-omap2/bci.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-omap-2.6/arch/arm/mach-omap2/bci.c	2008-07-03
16:59:40.000000000
> +0530
> @@ -0,0 +1,34 @@
> +/*
> + * linux/arch/arm/mach-omap2/board-3430sdp-bci.c

just fix this name please.

Style only.


> +
> +static struct platform_device twl4030_bci_battery_device = {
> +	.name           = "twl4030-bci-battery",
> +	.id             = 1,

use -1. There will be no other twl4030-bci-battery in the system :-)

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

