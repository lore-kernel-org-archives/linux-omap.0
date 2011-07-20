From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH] MTD: Nand: use MTD_NAND_OMAP2 for OMAP4
Date: Wed, 20 Jul 2011 07:53:05 +0300
Message-ID: <1311137590.20738.135.camel@sauron>
References: <1310727174-8183-1-git-send-email-j.weitzel@phytec.de>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41027 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab1GTEvn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jul 2011 00:51:43 -0400
Received: by iyb12 with SMTP id 12so4686187iyb.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Jul 2011 21:51:43 -0700 (PDT)
In-Reply-To: <1310727174-8183-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Artem.Bityutskiy@nokia.com, vimalsingh@ti.com

On Fri, 2011-07-15 at 12:52 +0200, Jan Weitzel wrote:
>  config MTD_NAND_OMAP2
>  	tristate "NAND Flash device on OMAP2 and OMAP3"

I guess you need to add OMAP4 to the string above as well.

> -	depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3)
> +	depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4)
>  	help
> -          Support for NAND flash on Texas Instruments OMAP2 and OMAP3 platforms.
> +          Support for NAND flash on Texas Instruments OMAP2, OMAP3 and OMAP4
> +	  platforms.


-- 
Best Regards,
Artem Bityutskiy

