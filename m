From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Update ov9640 ifparm for H4 board.
Date: Mon, 17 Sep 2007 11:32:33 -0700
Message-ID: <20070917183233.GH21226@atomide.com>
References: <5d5443650709060536q6a407aa6ia56e471c01c28579@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650709060536q6a407aa6ia56e471c01c28579@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [070906 05:40]:
> -- 
> --Trilok Soni

> From c2f1169a933107c9f6ccfb47c7cc35f1e904821c Mon Sep 17 00:00:00 2001
> From: Trilok Soni <soni.trilok@gmail.com>
> Date: Thu, 6 Sep 2007 23:33:23 +0530
> Subject: [PATCH] OMAP: Update ov9640 ifparm for H4 board.
> 
> - Update ov9640 ifparm due to change in naming
>   for parallel interface and added clock_min/max
>   for ov9640.
> 
> Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
> ---
>  arch/arm/mach-omap2/board-h4.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
> index 2561174..fc30021 100644
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -625,12 +625,14 @@ static int ov9640_sensor_power_set(int power)
>  }
>  
>  static struct v4l2_ifparm ifparm = {
> -	.if_type = V4L2_IF_TYPE_PARALLEL,
> +	.if_type = V4L2_IF_TYPE_BT656,
>  	.u = {
> -		.parallel = {
> +		.bt656 = {
>  			 .frame_start_on_rising_vs = 1,
>  			 .nobt_vs_inv = 1,
> -			 .mode = V4L2_IF_TYPE_PARALLEL_MODE_NOBT_8BIT,
> +			 .mode = V4L2_IF_TYPE_BT656_MODE_NOBT_8BIT,
> +			 .clock_min = OV9640_XCLK_MIN,
> +			 .clock_max = OV9640_XCLK_MAX,
>  		 },
>  	},
>  };

Pushing today.

Tony
