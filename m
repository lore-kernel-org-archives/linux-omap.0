From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: pm.c correct the initcall for an early init.
Date: Thu, 02 Dec 2010 14:33:15 +0100
Message-ID: <878w0847vo.fsf@deeprootsystems.com>
References: <1291201283-21185-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34732 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419Ab0LBNdX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 08:33:23 -0500
Received: by qyk11 with SMTP id 11so3952708qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 05:33:22 -0800 (PST)
In-Reply-To: <1291201283-21185-1-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Wed, 1 Dec 2010 16:31:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

Thara Gopinath <thara@ti.com> writes:

> omap2_common_pm_init is the API where generic system devices like
> mpu, l3 etc get initialized. This has to happen really early on
> during the boot and not at a later time. This is especially important
> with the new opp changes as these devices need to be built before the
> opp tables init happen. Today both are device initcalls and it works
> just because of the order of compilation

Why postcore?  there are several other inicalls earlier than
device_initcall.

Also, does this actually work?  Is the driver core initialized at
postcore_initcall time such that omap_devices w/platform_device
creation actually works?

Kevin

> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 59ca03b..6ec2ee1 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -143,5 +143,5 @@ static int __init omap2_common_pm_init(void)
>  
>  	return 0;
>  }
> -device_initcall(omap2_common_pm_init);
> +postcore_initcall(omap2_common_pm_init);
