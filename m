From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] memory: omap-gpmc: Fix debug output for access width
Date: Thu, 11 May 2017 12:46:21 +0300
Message-ID: <247d2c59-d536-99b2-d7ef-1996325ec98e@ti.com>
References: <20170505223706.4913-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170505223706.4913-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/05/17 01:37, Tony Lindgren wrote:
> The width needs to be configured in bytes with 1 meaning 8-bit
> access and 2 meaning 16-bit access.
> 
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>  drivers/memory/omap-gpmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -513,7 +513,7 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
>  	pr_info("gpmc cs%i access configuration:\n", cs);
>  	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1,  4,  4, "time-para-granularity");
>  	GPMC_GET_RAW(GPMC_CS_CONFIG1,  8,  9, "mux-add-data");
> -	GPMC_GET_RAW_MAX(GPMC_CS_CONFIG1, 12, 13,
> +	GPMC_GET_RAW_SHIFT_MAX(GPMC_CS_CONFIG1, 12, 13, 1,
>  			 GPMC_CONFIG1_DEVICESIZE_MAX, "device-width");
>  	GPMC_GET_RAW(GPMC_CS_CONFIG1, 16, 17, "wait-pin");
>  	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1, 21, 21, "wait-on-write");
> 

-- 
cheers,
-roger
