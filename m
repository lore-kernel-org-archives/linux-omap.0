From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC PATCH 4/6] ARM: OMAP: SmartReflex: provide SoC integration
 API for VP
Date: Sat, 03 Nov 2012 13:10:01 +0000
Message-ID: <509517A9.6090602@deeprootsystems.com>
References: <1351028641-20832-1-git-send-email-nm@ti.com> <1351028641-20832-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41983 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab2KCNKC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 09:10:02 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so2961394wgb.1
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 06:10:01 -0700 (PDT)
In-Reply-To: <1351028641-20832-5-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>

On 10/23/2012 10:43 PM, Nishanth Menon wrote:
> SoC integration of SmartReflex AVS block is varied. Some use
> Voltage Processor for a hardware loop in certain OMAP SoC (called
> hardware loop), while others have just the AVS block without
> hardware loop automatic calibration mechanism for AVS block
> to talk through. So provide the Voltage Processor API
> to allow for SmartReflex class drivers to use the same.
>
> NOTE: SmartReflex class 3 mode of operation mandates VP APIs
> so, refuse to enable AVS driver if corresponding APIs are
> not available.
>
> As part of this change, remove the inclusion of voltage.h
> which is no longer needed as smartreflex.h includes
> linux/platform_data/voltage-omap.h which contain relevant
> definitions used here.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

[...]

> @@ -23,15 +22,26 @@ static int sr_class3_enable(struct omap_sr *sr)
>   				__func__, sr->name);
>   		return -ENODATA;
>   	}
> +	if (!sr->soc_ops.vp_enable) {
> +		pr_warn("%s: no VP enable available.Cannot enable %s!!\n",

nit: add space after '.'

There's a couple of these in the patch.

Kevin
