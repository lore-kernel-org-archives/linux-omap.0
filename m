From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/3] OMAP: avoid build wdt platform device if with dt
 support
Date: Tue, 29 May 2012 12:53:38 -0500
Message-ID: <4FC50D22.4090409@ti.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com> <1337942552-28218-3-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40866 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab2E2Rxz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 13:53:55 -0400
In-Reply-To: <1337942552-28218-3-git-send-email-jgq516@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jgq516@gmail.com
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, rob.herring@calxeda.com, grant.likely@secretlab.ca, rnayak@ti.com, tony@atomide.com, wim@iguana.be, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org



On 05/25/2012 05:42 AM, jgq516@gmail.com wrote:
> From: Xiao Jiang <jgq516@gmail.com>
> 
> If provided dt support, then skip add wdt platform device as usual.
> 
> Signed-off-by: Xiao Jiang <jgq516@gmail.com>
> ---
>  arch/arm/mach-omap2/devices.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index ae62ece..80d7e3f 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -759,7 +759,7 @@ static int __init omap_init_wdt(void)
>  	char *oh_name = "wd_timer2";
>  	char *dev_name = "omap_wdt";
>  
> -	if (!cpu_class_is_omap2())
> +	if (!cpu_class_is_omap2() || of_have_populated_dt())
>  		return 0;
>  
>  	oh = omap_hwmod_lookup(oh_name);

Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
