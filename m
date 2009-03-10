From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/6] OMAP: mmc-twl4030 fix name buffer length
Date: Tue, 10 Mar 2009 09:28:25 -0800
Message-ID: <200903101028.25844.david-b@pacbell.net>
References: <20090310093255.16889.30509.sendpatchset@ahunter-laptop> <20090310093302.16889.4535.sendpatchset@ahunter-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n30.bullet.mail.mud.yahoo.com ([68.142.207.49]:39853 "HELO
	n30.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754974AbZCJR2a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Mar 2009 13:28:30 -0400
In-Reply-To: <20090310093302.16889.4535.sendpatchset@ahunter-laptop>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Tuesday 10 March 2009, Adrian Hunter wrote:
> >From 60238a3a80b5be3e1843a049b39eabf729c315aa Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Thu, 22 Jan 2009 17:58:04 +0200
> Subject: [PATCH] OMAP: mmc-twl4030 fix name buffer length
> 
> Add 1 to buffer length for null terminator.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

An endless off-by-one bug ...


> ---
>  arch/arm/mach-omap2/mmc-twl4030.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
> index 33e5b9b..aeaab5a 100644
> --- a/arch/arm/mach-omap2/mmc-twl4030.c
> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> @@ -61,7 +61,7 @@ static struct twl_mmc_controller {
>  	struct omap_mmc_platform_data	*mmc;
>  	u8		twl_vmmc_dev_grp;
>  	u8		twl_mmc_dedicated;
> -	char		name[HSMMC_NAME_LEN];
> +	char		name[HSMMC_NAME_LEN + 1];
>  } hsmmc[OMAP34XX_NR_MMC] = {
>  	{
>  		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
> -- 
> 1.5.6.3
> 
> 



