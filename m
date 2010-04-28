From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 1/2] OMAP3: PM: Smartreflex IP update changes for OMAP3630
Date: Wed, 28 Apr 2010 16:28:36 -0700
Message-ID: <877hnr9mxn.fsf@deeprootsystems.com>
References: <1271413196-6087-1-git-send-email-thara@ti.com>
	<1271413196-6087-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:58598 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab0D1X2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 19:28:55 -0400
Received: by pxi17 with SMTP id 17so2995969pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 16:28:55 -0700 (PDT)
In-Reply-To: <1271413196-6087-2-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 15\:49\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> OMAP3430 uses the 65nm version of the smartreflex IP where as
> OMAP3630 and OMAP4430 uses the 45nm updated IP.
>
> This patch adds support for the updated smartreflex IP used
> in OMAP3630 and OMAP4 in the smartreflex driver.
>
> Major changes between the two versions of IP involve:
> 1. Change in offset position for ERRCONFIG and SENERROR registers
> 2. Change in bit positions for VP bound interrupt enable and status
>    in ERRCONFIG register.
> 3. Change in bit positions and width of SENNENABLE and SENPENABLE
>    bits in SRCONFIG registers.
> 4. Introduction of separate irq registers for MCU bound interrupts.
> 5. Removal of clockactivity bits in ERRCONFIG and introduction of
>   idlemode and wakeupenable bits in ERRCONFIG.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

Looks good.  One minor comment for discussion below...

[...]

> @@ -619,6 +717,7 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
>  	sr_info->srid = pdev->id;
>  	sr_info->is_autocomp_active = 0;
>  	sr_info->clk_length = 0;
> +	sr_info->sr_ip_type = odev->hwmods[0]->class->rev;

I'm not crazy about drivers having to know the details of hwmod
structs.  I'd suggest a HWMOD API for getting this revision.

Other ideas?

Kevin
