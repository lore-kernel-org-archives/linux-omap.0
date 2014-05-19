From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 02/13] ARM: edma: Take the number of tc from edma_soc_info
 (pdata)
Date: Mon, 19 May 2014 16:37:18 +0530
Message-ID: <5379E5E6.9080500@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com> <1400242640-9902-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1400242640-9902-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, joelf@ti.com, arnd@arndb.de
Cc: linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

Peter,

On Friday 16 May 2014 05:47 PM, Peter Ujfalusi wrote:
> Instead of saving the for loop length, take the num_tc value from the pdata.
> In case of DT boot set the n_tc to 3 as it is hardwired in edma_of_parse_dt()
> This is a temporary state since upcoming patch(es) will change how we are
> dealing with these parameters.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/common/edma.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 01707aae0a2b..d42c84a3432a 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c

> @@ -1741,9 +1743,6 @@ static int edma_probe(struct platform_device *pdev)
>  			map_queue_tc(j, queue_tc_mapping[i][0],
>  					queue_tc_mapping[i][1]);
>  
> -		/* Save the number of TCs */
> -		edma_cc[j]->num_tc = i;
> -

To which baseline do the patches apply? These lines are not present at
least in v3.15-rc5. I am applying the patch without this hunk.

Thanks,
Sekhar

