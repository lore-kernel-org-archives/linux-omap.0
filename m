From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Fix the BYTEBLOCK capability removal
Date: Thu, 15 Nov 2007 13:20:20 -0800
Message-ID: <20071115212019.GL20686@atomide.com>
References: <1194274461-6712-1-git-send-email-francisco.alecrim@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1194274461-6712-1-git-send-email-francisco.alecrim@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: francisco.alecrim@indt.org.br
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* francisco.alecrim@indt.org.br <francisco.alecrim@indt.org.br> [071105 06:51]:
> From: Francisco Alecrim <francisco.alecrim@indt.org.br>
> 
> According with commit 255d01af9a990fd5166f04ed0cc0b30b7b67e81e
> from Linux-OMAP tree, the BYTEBLOCK capability was removed by Pierre Ossman.
> MMC_CAP_BYTEBLOCK is not defined causing the compile error:
> 
> drivers/mmc/host/omap.c: In function `mmc_omap_probe':
> drivers/mmc/host/omap.c:1077: error: `MMC_CAP_BYTEBLOCK' undeclared (first use in this function)
> drivers/mmc/host/omap.c:1077: error: (Each undeclared identifier is reported only once
> drivers/mmc/host/omap.c:1077: error: for each function it appears in.)
> 
> Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> ---
>  drivers/mmc/host/omap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 87dc63a..ea8dbde 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1074,7 +1074,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
>  	mmc->f_min = 400000;
>  	mmc->f_max = 24000000;
>  	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> -	mmc->caps = MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK;
> +	mmc->caps = MMC_CAP_MULTIWRITE;
>  
>  	if (minfo->wire4)
>  		 mmc->caps |= MMC_CAP_4_BIT_DATA;
> -- 

Pushing today.

Tony
