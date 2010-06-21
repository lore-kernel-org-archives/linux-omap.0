From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v3 2/3] OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
Date: Mon, 21 Jun 2010 11:50:41 +0300
Message-ID: <1277110241.2526.31.camel@tubuntu.research.nokia.com>
References: <1276778702-15280-1-git-send-email-svadivu@ti.com>
	 <1276778702-15280-2-git-send-email-svadivu@ti.com>
	 <1276778702-15280-3-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35064 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071Ab0FUIvU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 04:51:20 -0400
In-Reply-To: <1276778702-15280-3-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-dev@vger.kernel.org" <linux-dev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "hvaibhav@ti.com" <hvaibhav@ti.com>

On Thu, 2010-06-17 at 14:45 +0200, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> config VRFB should depend on ARCH_OMAP2 or ARCH_OMAP3.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
>  drivers/video/omap2/Kconfig            |    4 ++++
>  drivers/video/omap2/omapfb/Kconfig     |    1 -
>  2 files changed,  4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap2/Kconfig b/drivers/video/omap2/Kconfig
> index d877c36..18bb835 100644
> --- a/drivers/video/omap2/Kconfig
> +++ b/drivers/video/omap2/Kconfig
> @@ -3,6 +3,10 @@ config OMAP2_VRAM
>  
>  config OMAP2_VRFB
>  	bool
> +	depends on ARCH_OMAP2 || ARCH_OMAP3
> +	default y if FB_OMAP2
> +	help
> +	  OMAP VRFB buffer support is efficient for rotation
>  
>  source "drivers/video/omap2/dss/Kconfig"
>  source "drivers/video/omap2/omapfb/Kconfig"
> diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
> index a3ed15c..f186c2b 100644
> --- a/drivers/video/omap2/omapfb/Kconfig
> +++ b/drivers/video/omap2/omapfb/Kconfig
> @@ -3,7 +3,6 @@ menuconfig FB_OMAP2
>          depends on FB && OMAP2_DSS
>  
>  	select OMAP2_VRAM
> -	select OMAP2_VRFB
>          select FB_CFB_FILLRECT
>          select FB_CFB_COPYAREA
>          select FB_CFB_IMAGEBLIT

This is second patch set marked as v3. Please update the version for
every patch set.

I think the config selection is now a bit confusing. I think it should
either be:

The omap2/Kconfig left as it is, and omapfb/Kconfig changed to:
select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3

or

Let the user select VRFB.

 Tomi


