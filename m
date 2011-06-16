From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3evm: Add Mistral WL12XX config support
Date: Thu, 16 Jun 2011 15:23:08 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D563C4B@dbde02.ent.ti.com>
References: <y> <1308053788-25937-1-git-send-email-shahar@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48643 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab1FPJxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jun 2011 05:53:18 -0400
In-Reply-To: <1308053788-25937-1-git-send-email-shahar@wizery.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shahar Lev <shahar@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Shahar Lev
> Sent: Tuesday, June 14, 2011 5:46 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-arm; Tony Lindgren; Shahar Lev
> Subject: [PATCH] omap3evm: Add Mistral WL12XX config support
> 
> Add Kconfig entries indicating the existence of omap3evm's
> wlan/bt wl12xx daughter card (see
> http://mistralsolutions.com/component/jumi/Download_Common_Cod
> e.html?docid=298),
> and the exact reference clock type that the wl12xx device is hardwired
> to (the wl12xx driver must know this).
> 
> In addition, start using CONFIG_OMAP3EVM_MISTRAL_WL12XX in
> the omap3evm's board file instead of CONFIG_WL12XX_PLATFORM_DATA,
> because the latter only indicates that the driver is being built, and
> shouldn't be used to assume the existence of extension cards.
> 
> Signed-off-by: Shahar Lev <shahar@wizery.com>
> ---
>  arch/arm/mach-omap2/Kconfig          |   23 +++++++++++++++++++++++
>  arch/arm/mach-omap2/board-omap3evm.c |   12 ++++++------
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 19d5891..8ef012d 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -342,6 +342,29 @@ config OMAP3_SDRC_AC_TIMING
>  	  wish to say no.  Selecting yes without understanding what is
>  	  going on could result in system crashes;
>  
> +config OMAP3EVM_MISTRAL_WL12XX

[sp] Could this be renamed simply as: OMAP3EVM_WL12XX?
     OR is there a specific reason to add vendor/manufacturers' name
     to the defintion? 

~sanjeev

[snip]...[snip]
