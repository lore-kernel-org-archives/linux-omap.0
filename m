From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mach_omap2: use PTR_RET instead of IS_ERR + PTR_ERR
Date: Tue, 12 Mar 2013 11:05:57 +0000
Message-ID: <20130312110557.GF30923@n2100.arm.linux.org.uk>
References: <1363075109-27038-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33152 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab3CLLGE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 07:06:04 -0400
Content-Disposition: inline
In-Reply-To: <1363075109-27038-1-git-send-email-silviupopescu1990@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Mar 12, 2013 at 09:58:29AM +0200, Silviu-Mihai Popescu wrote:
> This uses PTR_RET instead of IS_ERR and PTR_ERR in order to increase
> readability.
> 
> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
> ---
>  arch/arm/mach-omap2/devices.c |    4 ++--
>  arch/arm/mach-omap2/fb.c      |    5 +----
>  arch/arm/mach-omap2/gpmc.c    |    2 +-
>  arch/arm/mach-omap2/pmu.c     |    5 +----
>  4 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 1ec7f05..2a0816e 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -66,7 +66,7 @@ static int __init omap3_l3_init(void)
>  
>  	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
>  
> -	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
> +	return PTR_RET(pdev);

This is incorrect.

The return value will be tested for < 0.  Kernel pointers in general are
all above 3GB, and so are all "< 0".

I'm afraid none of these changes stuff is an improvement - they all
introduce bugs.
