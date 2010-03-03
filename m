From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/16] OMAP3: PM: Convert smartreflex driver into a platform driver using hwmods and omap-device layer
Date: Tue, 02 Mar 2010 16:02:25 -0800
Message-ID: <87aauqs25q.fsf@deeprootsystems.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52197 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab0CCAC2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 19:02:28 -0500
Received: by pwj8 with SMTP id 8so505649pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Mar 2010 16:02:28 -0800 (PST)
In-Reply-To: <1267003757-22456-4-git-send-email-thara@ti.com> (Thara Gopinath's message of "Wed\, 24 Feb 2010 14\:59\:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch converts the exisitng smartreflex library into a
> platform driver with device , driver registrations using hardware mods.
> As part of this Ntarget values are passed as platform data.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

>  
> +static int __devinit omap_smartreflex_probe(struct platform_device *pdev)

This can be __init when using platform_driver_probe()...

[...]

>  
> +static struct platform_driver smartreflex_driver = {
> +	.probe          = omap_smartreflex_probe,

and shouldn't need to be listed here either, since it will be __init
and disappear after boot.


Kevin
