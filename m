From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 5/8 v2] ARM OMAP2+ GPMC: change get_gpmc_timing_reg output
 for DTS
Date: Wed, 25 Feb 2015 15:24:57 +0200
Message-ID: <54EDCD29.3010404@ti.com>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On 24/02/15 22:05, Robert ABEL wrote:
> DTS output was formatted to require additional work when copy-pasting into DTS.
> Nano-second timings were removed, because they were not a confidence interval nor
> an indication what timing values would result in the same #ticks

If they were not is it possible to dump min,max timings that will result in
the same ticks?

Otherwise patch is fine.

cheers,
-roger

> 
> Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
> ---
>  drivers/memory/omap-gpmc.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index b5c8305..ff1a1e7 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -337,32 +337,45 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
>  }
>  
>  #ifdef DEBUG
> +/**
> + * get_gpmc_timing_reg - read a timing parameter and print DTS settings for it.
> + * @cs      Chip Select Region
> + * @reg     GPMC_CS_CONFIGn register offset.
> + * @st_bit  Start Bit
> + * @end_bit End Bit. Must be >= @st_bit.
> + * @name    DTS node name, w/o "gpmc,"
> + * @raw     Raw Format Option.
> + *          raw format:  gpmc,name = <value>
> + *          tick format: gpmc,name = <value> /&zwj;* x ticks *&zwj;/
> + * @noval   Parameter values equal to 0 are not printed.
> + * @shift   Parameter value left shifts @shift, which is then printed instead of value.
> + *
> + */
>  static int get_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
>  			       bool raw, bool noval, int shift,
>  			       const char *name)
>  {
>  	u32 l;
> -	int nr_bits, max_value, mask;
> +	int nr_bits;
> +	int mask;
>  
>  	l = gpmc_cs_read_reg(cs, reg);
>  	nr_bits = end_bit - st_bit + 1;
> -	max_value = (1 << nr_bits) - 1;
> -	mask = max_value << st_bit;
> -	l = (l & mask) >> st_bit;
> +	mask = (1 << nr_bits) - 1;;
> +	l = (l >> st_bit) & mask;
>  	if (shift)
>  		l = (shift << l);
>  	if (noval && (l == 0))
>  		return 0;
>  	if (!raw) {
> -		unsigned int time_ns_min, time_ns, time_ns_max;
> +		/* DTS tick format for timings in ns */
> +		unsigned int time_ns;
>  
> -		time_ns_min = gpmc_ticks_to_ns(l ? l - 1 : 0);
>  		time_ns = gpmc_ticks_to_ns(l);
> -		time_ns_max = gpmc_ticks_to_ns(l + 1 > max_value ?
> -					       max_value : l + 1);
> -		pr_info("gpmc,%s = <%u> (%u - %u ns, %i ticks)\n",
> -			name, time_ns, time_ns_min, time_ns_max, l);
> +		pr_info("gpmc,%s = <%u> /* %i ticks */\n",
> +			name, time_ns, l);
>  	} else {
> +		/* raw format */
>  		pr_info("gpmc,%s = <%u>\n", name, l);
>  	}
>  
> 
