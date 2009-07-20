From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 9/10] drivers/mmc: Move a dereference below a NULL test
Date: Mon, 20 Jul 2009 11:01:28 +0300
Message-ID: <4A642458.6080008@nokia.com>
References: <Pine.LNX.4.64.0907191729580.16542@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21101 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbZGTIBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jul 2009 04:01:04 -0400
In-Reply-To: <Pine.LNX.4.64.0907191729580.16542@ask.diku.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> If the NULL test is necessary, then the dereference should be moved below
> the NULL test.
> 
> The semantic patch that makes this change is as follows:
> (http://www.emn.fr/x-info/coccinelle/)
> 
> // <smpl>
> @@
> type T;
> expression E,E1;
> identifier i,fld;
> statement S;
> @@
> 
> - T i = E->fld;
> + T i;
>   ... when != E=E1
>       when != i
>   BUG_ON (E == NULL||
> -     i
> +     E->fld
>        == NULL || ...);
> + i = E->fld;
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  drivers/mmc/host/omap.c             |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index e7a331d..89281ab 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -255,11 +255,12 @@ static void mmc_omap_slot_release_work(struct work_struct *work)
>  
>  static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int clk_enabled)
>  {
> -	struct mmc_omap_host *host = slot->host;
> +	struct mmc_omap_host *host;
>  	unsigned long flags;
>  	int i;
>  
> -	BUG_ON(slot == NULL || host->mmc == NULL);
> +	BUG_ON(slot == NULL || slot->host->mmc == NULL);
> +	host = slot->host;
>  
>  	if (clk_enabled)
>  		/* Keeps clock running for at least 8 cycles on valid freq */
> --

If slot is NULL it will oops anyway, so the following is better IMHO:
 
static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int clk_enabled)
{
	struct mmc_omap_host *host = slot->host;
	unsigned long flags;
	int i;

> -	BUG_ON(slot == NULL || host->mmc == NULL);
> +	BUG_ON(host->mmc == NULL);

	if (clk_enabled)
		/* Keeps clock running for at least 8 cycles on valid freq */
