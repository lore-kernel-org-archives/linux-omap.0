From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 02/11] mmc: sdhci: Factor out some operations set to
 their own functions
Date: Wed, 15 Jan 2020 12:55:12 +0200
Message-ID: <e5aaf19b-6f9d-c9f7-cc42-5948cafe1f2f@intel.com>
References: <20200106110133.13791-1-faiz_abbas@ti.com>
 <20200106110133.13791-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20200106110133.13791-3-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 6/01/20 1:01 pm, Faiz Abbas wrote:
> In preparation for adding external dma support, factor out data initialization,
> block info and mrq_done to their own functions.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Minor changes below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 96 +++++++++++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1b1c26da3fe0..f6999054abcf 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1025,18 +1025,9 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  }
>  
> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +static void sdhci_initialize_data(struct sdhci_host *host,
> +				  struct mmc_data *data)
>  {
> -	struct mmc_data *data = cmd->data;
> -
> -	host->data_timeout = 0;
> -
> -	if (sdhci_data_line_cmd(cmd))
> -		sdhci_set_timeout(host, cmd);
> -
> -	if (!data)
> -		return;
> -
>  	WARN_ON(host->data);
>  
>  	/* Sanity checks */
> @@ -1048,6 +1039,36 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  	host->data_early = 0;
>  	host->data->bytes_xfered = 0;
>  

Unnessary blank line

> +}
> +
> +static inline void sdhci_set_block_info(struct sdhci_host *host,
> +					struct mmc_data *data)
> +{
> +
> +	/* Set the DMA boundary value and block size */
> +	sdhci_writew(host,
> +		     SDHCI_MAKE_BLKSZ(host->sdma_boundary, host->data->blksz),

host->data -> data

> +		     SDHCI_BLOCK_SIZE);
> +	/*
> +	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
> +	 * can be supported, in that case 16-bit block count register must be 0.
> +	 */
> +	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> +	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
> +		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
> +			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
> +		sdhci_writew(host, host->data->blocks, SDHCI_32BIT_BLK_CNT);

host->data -> data


> +	} else {
> +		sdhci_writew(host, host->data->blocks, SDHCI_BLOCK_COUNT);

host->data -> data

> +	}
> +}
> +
> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +
> +	sdhci_initialize_data(host, data);
> +
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
>  		struct scatterlist *sg;
>  		unsigned int length_mask, offset_mask;
> @@ -1133,22 +1154,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  
>  	sdhci_set_transfer_irqs(host);
>  
> -	/* Set the DMA boundary value and block size */
> -	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
> -		     SDHCI_BLOCK_SIZE);
> -
> -	/*
> -	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
> -	 * can be supported, in that case 16-bit block count register must be 0.
> -	 */
> -	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> -	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
> -		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
> -			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
> -		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
> -	} else {
> -		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> -	}
> +	sdhci_set_block_info(host, data);
>  }
>  
>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
> @@ -1245,22 +1251,10 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
>  		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
>  }
>  
> -static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> +static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	int i;
>  
> -	if (host->cmd && host->cmd->mrq == mrq)
> -		host->cmd = NULL;
> -
> -	if (host->data_cmd && host->data_cmd->mrq == mrq)
> -		host->data_cmd = NULL;
> -
> -	if (host->data && host->data->mrq == mrq)
> -		host->data = NULL;
> -
> -	if (sdhci_needs_reset(host, mrq))
> -		host->pending_reset = true;
> -
>  	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
>  		if (host->mrqs_done[i] == mrq) {
>  			WARN_ON(1);
> @@ -1276,6 +1270,23 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  	}
>  
>  	WARN_ON(i >= SDHCI_MAX_MRQS);
> +}
> +
> +static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> +{
> +	if (host->cmd && host->cmd->mrq == mrq)
> +		host->cmd = NULL;
> +
> +	if (host->data_cmd && host->data_cmd->mrq == mrq)
> +		host->data_cmd = NULL;
> +
> +	if (host->data && host->data->mrq == mrq)
> +		host->data = NULL;
> +
> +	if (sdhci_needs_reset(host, mrq))
> +		host->pending_reset = true;
> +
> +	sdhci_set_mrq_done(host, mrq);
>  
>  	sdhci_del_timer(host, mrq);
>  
> @@ -1390,12 +1401,15 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  
>  	host->cmd = cmd;
> +	host->data_timeout = 0;
>  	if (sdhci_data_line_cmd(cmd)) {
>  		WARN_ON(host->data_cmd);
>  		host->data_cmd = cmd;
> +		sdhci_set_timeout(host, cmd);
>  	}
>  
> -	sdhci_prepare_data(host, cmd);
> +	if (cmd->data)
> +		sdhci_prepare_data(host, cmd);
>  
>  	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
>  
> 
