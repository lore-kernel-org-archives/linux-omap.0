From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix compile break
Date: Sun, 30 Oct 2011 02:39:55 +0200
Message-ID: <201110300239.55207.marek.vasut@gmail.com>
References: <1319931847-5140-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52381 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932547Ab1J3Aj6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Oct 2011 20:39:58 -0400
Received: by faan17 with SMTP id n17so4600505faa.19
        for <linux-omap@vger.kernel.org>; Sat, 29 Oct 2011 17:39:57 -0700 (PDT)
In-Reply-To: <1319931847-5140-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org

> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> omap_hsmmc.c: In function 'omap_hsmmc_protect_card':
> omap_hsmmc.c:1273: error: 'pr_info' undeclared (first use in this function)
> omap_hsmmc.c:1273: error: (Each undeclared identifier is reported only once
> omap_hsmmc.c:1273: error: for each function it appears in.)
> omap_hsmmc.c:1273: error: expected ';' before string constant
> omap_hsmmc.c:1275: error: expected statement before ')' token
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index e8ff123..101cd31 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct
> omap_hsmmc_host *host) }
>  	} else {
>  		if (!host->protect_card) {
> -			pr_info"%s: cover is open, "
> +			pr_info("%s: cover is open, "
>  					 "card is now inaccessible\n",
>  					 mmc_hostname(host->mmc));
>  			host->protect_card = 1;

Hey,

please care to check mailing list next time before you submit patch. This is 
already fixed for about five hours now. Actually, the last patch submitted to 
the mailing list fixes exactly this problem:

[PATCH] omap_hsmmc: fix missing parenthesis in pr_info
