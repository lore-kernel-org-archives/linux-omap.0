From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] [OMAP3_PM] Fix zoom2 defconfig build
Date: Mon, 2 Nov 2009 13:29:24 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402540378B3@dbde02.ent.ti.com>
References: <1257148563-18604-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37699 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754047AbZKBH7Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 02:59:24 -0500
In-Reply-To: <1257148563-18604-1-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

It looks like config issue with git-send-email on my system.

Here is Patch Description:
 The CONFIG_DEBUG_FS is not enabled in omap_zoom2_defconfig which
 is breaking zoom2 defconfig build in linux-omap-pm(pm branch).
 This patch fixes build issue and kernel booting is also tested
 on zoom2.

> -----Original Message-----
> From: G, Manjunath Kondaiah 
> Sent: Monday, November 02, 2009 1:26 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; G, Manjunath Kondaiah
> Subject: [PATCH] [OMAP3_PM] Fix zoom2 defconfig build
> 
> From: Manjunatha GK <manjugk@ti.com>
> 
> 
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> ---
>  arch/arm/configs/omap_zoom2_defconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/configs/omap_zoom2_defconfig 
> b/arch/arm/configs/omap_zoom2_defconfig
> index f1739fa..8ca835a 100644
> --- a/arch/arm/configs/omap_zoom2_defconfig
> +++ b/arch/arm/configs/omap_zoom2_defconfig
> @@ -1350,7 +1350,7 @@ CONFIG_ENABLE_MUST_CHECK=y
>  CONFIG_FRAME_WARN=1024
>  CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_UNUSED_SYMBOLS is not set
> -# CONFIG_DEBUG_FS is not set
> +CONFIG_DEBUG_FS=y
>  # CONFIG_HEADERS_CHECK is not set
>  CONFIG_DEBUG_KERNEL=y
>  # CONFIG_DEBUG_SHIRQ is not set
> -- 
> 1.6.0.4
> 
> 