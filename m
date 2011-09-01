From: "Maupin, Chase" <chase.maupin@ti.com>
Subject: RE: [PATCH] omap_vout: fix section mismatch in probe function
Date: Thu, 1 Sep 2011 13:19:13 +0000
Message-ID: <7D46E86EC0A8354091174257B2FED1010347884B@DLEE12.ent.ti.com>
References: <1314375015-15732-1-git-send-email-Chase.Maupin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50334 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757313Ab1IANTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 09:19:15 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p81DJEaf011495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 1 Sep 2011 08:19:14 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p81DJEPn007463
	for <linux-omap@vger.kernel.org>; Thu, 1 Sep 2011 08:19:14 -0500 (CDT)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p81DJE0R012493
	for <linux-omap@vger.kernel.org>; Thu, 1 Sep 2011 08:19:14 -0500 (CDT)
In-Reply-To: <1314375015-15732-1-git-send-email-Chase.Maupin@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Maupin, Chase
> Sent: Friday, August 26, 2011 11:10 AM
> To: linux-omap@vger.kernel.org
> Cc: Maupin, Chase
> Subject: [PATCH] omap_vout: fix section mismatch in probe function
> 
> Building the OMAP vout driver resulted in the following message:
> 
>     WARNING: vmlinux.o(.data+0x38084): Section mismatch in reference
>              from the variable omap_vout_driver to the function
>              .init.text:omap_vout_probe()
>     The variable omap_vout_driver references
>     the function __init omap_vout_probe()
>     If the reference is valid then annotate the
>     variable with __init* or __refdata (see linux/init.h) or name
>     the variable:
>     *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one,
>     *_console
> 
> Signed-off-by: Chase Maupin <Chase.Maupin@ti.com>

Just wanted to ping on this patch.  Are there any issues?

> ---
>  drivers/media/video/omap/omap_vout.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/media/video/omap/omap_vout.c
> b/drivers/media/video/omap/omap_vout.c
> index b3a5ecd..9b5dad5 100644
> --- a/drivers/media/video/omap/omap_vout.c
> +++ b/drivers/media/video/omap/omap_vout.c
> @@ -2133,7 +2133,7 @@ static int omap_vout_remove(struct
> platform_device *pdev)
>  	return 0;
>  }
> 
> -static int __init omap_vout_probe(struct platform_device *pdev)
> +static int omap_vout_probe(struct platform_device *pdev)
>  {
>  	int ret = 0, i;
>  	struct omap_overlay *ovl;
> --
> 1.7.0.4

