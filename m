From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc
	callback
Date: Wed, 10 Mar 2010 19:57:50 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C46F13B4@dbde02.ent.ti.com>
References: <618f0c911003100611q42e7f23cuc3c8d3f116ca7eb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <618f0c911003100611q42e7f23cuc3c8d3f116ca7eb3@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "S, Venkatraman" <svenkatr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc
Cc: Tony Lindgren <tony@atomide.com>, "Chikkature Rajashekar,
	Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> Venkatraman S
> Sent: Wednesday, March 10, 2010 7:42 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-mmc@vger.kernel.org
> Cc: Adrian Hunter; Chikkature Rajashekar, Madhusudhan; Tony Lindgren
> Subject: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc callback
> 
> See previous post http://patchwork.kernel.org/patch/82907/
> Rebased to 2.6.34-rc1 and fixed comment alignment.
>
Why did you dropped change log in all your patches? You should retain that and
just change the patch version in the subject.
 
> CC: Adrian Hunter <adrian.hunter@nokia.com>
> CC: Madhusudhan C <madhu.cr@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++--------
>  1 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 83f0aff..ea2a082 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1046,8 +1046,18 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
> 
>  	if (end_cmd || ((status & CC) && host->cmd))
>  		omap_hsmmc_cmd_done(host, host->cmd);
> -	if ((end_trans || (status & TC)) && host->mrq)
> +	if ((end_trans || (status & TC)) && host->mrq) {
>  		omap_hsmmc_xfer_done(host, data);
> +		if (host->dma_ch != -1) {
> +			omap_free_dma(host->dma_ch);
> +			host->dma_ch = -1;
> +			/*
> +			 * Callback: run in interrupt context.
> +			 * mutex_unlock will throw a kernel warning if used.
> +			 */
> +			up(&host->sem);
> +		}
> +	}
> 
>  	spin_unlock(&host->irq_lock);
> 
> @@ -1267,13 +1277,6 @@ static void omap_hsmmc_dma_cb(int lch, u16
> ch_status, void *data)
>  		return;
>  	}
> 
> -	omap_free_dma(host->dma_ch);
> -	host->dma_ch = -1;
> -	/*
> -	 * DMA Callback: run in interrupt context.
> -	 * mutex_unlock will throw a kernel warning if used.
> -	 */
> -	up(&host->sem);
>  }
> 
>  /*
> --
> 1.6.3.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
