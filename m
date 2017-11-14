From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 05/16] mtd: onenand: omap2: Remove skip initial
 unlocking support
Date: Tue, 14 Nov 2017 17:14:13 +0200
Message-ID: <898b46f0-9f3f-cac7-0f89-dcefe8c8a0e3@ti.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111211942.643qupch2dnopz7i@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111211942.643qupch2dnopz7i@lenoch>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

On 11/11/17 23:19, Ladislav Michl wrote:
> No platform data user sets skip_initial_unlocking, so remove test
> for this field.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>  Changes:
>  -v2: new patch
>  -v3: none
>  -v4: none
> 
>  drivers/mtd/onenand/omap2.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index a03e1fe4aa48..93bd94337b35 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -700,9 +700,6 @@ static int omap2_onenand_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (pdata->skip_initial_unlocking)
> -		this->options |= ONENAND_SKIP_INITIAL_UNLOCKING;
> -
>  	if ((r = onenand_scan(&c->mtd, 1)) < 0)
>  		goto err_release_dma;
>  
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
