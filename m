From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 07/16] mtd: onenand: omap2: Account waiting time as
 waiting on IO
Date: Tue, 14 Nov 2017 17:18:18 +0200
Message-ID: <2ef8bef6-5e13-9b6a-e520-23da353d7fac@ti.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212058.3xkqfw42ik6pre47@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111212058.3xkqfw42ik6pre47@lenoch>
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

On 11/11/17 23:20, Ladislav Michl wrote:
> Use wait_for_completion_io_timeout, which has an impact on how the
> task is accounted in scheduling stats.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>  Changes:
>  -v4: new patch
> 
>  drivers/mtd/onenand/omap2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 883993bbe40b..0e7772e16d75 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -170,9 +170,8 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
>  		if (result == 0) {
>  			int retry_cnt = 0;
>  retry:
> -			result = wait_for_completion_timeout(&c->irq_done,
> -						    msecs_to_jiffies(20));
> -			if (result == 0) {
> +			if (!wait_for_completion_io_timeout(&c->irq_done,
> +						msecs_to_jiffies(20))) {
>  				/* Timeout after 20ms */
>  				ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
>  				if (ctrl & ONENAND_CTRL_ONGO &&
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
