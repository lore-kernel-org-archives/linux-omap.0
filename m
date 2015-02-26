From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/8] ARM OMAP2+ GPMC: change get_gpmc_timing_reg output
 for DTS
Date: Thu, 26 Feb 2015 18:06:18 +0300
Message-ID: <54EF366A.2050108@cogentembedded.com>
References: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de> <1424961956-29353-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424961956-29353-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, balbi@ti.com, rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hello.

On 02/26/2015 05:45 PM, Robert ABEL wrote:

> DTS output was formatted to require additional work when copy-pasting into DTS.
> Nano-second timings were replaced with interval of values that produce the same
> number of clock ticks.

> Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
> ---
>   drivers/memory/omap-gpmc.c | 35 ++++++++++++++++++++++++++---------
>   1 file changed, 26 insertions(+), 9 deletions(-)

> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index dbb6753..9340e7a 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -337,32 +337,49 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
>   }
>
>   #ifdef DEBUG
> +/**
> + * get_gpmc_timing_reg - read a timing parameter and print DTS settings for it.
> + * @cs      Chip Select Region

    Documentation/kernel-doc-nano-HOWTO.txt requires colons after the 
parameter names, doesn't it?

> + * @reg     GPMC_CS_CONFIGn register offset.
> + * @st_bit  Start Bit
> + * @end_bit End Bit. Must be >= @st_bit.
> + * @name    DTS node name, w/o "gpmc,"
> + * @raw     Raw Format Option.
> + *          raw format:  gpmc,name = <value>
> + *          tick format: gpmc,name = <value> /&zwj;*(x ns -- y ns]; x ticks *&zwj;/
> + *          Where (x ns -- y ns] is the half-open interval from x ns to y ns that
> + *          result in the same tick value.
> + * @noval   Parameter values equal to 0 are not printed.
> + * @shift   Parameter value left shifts @shift, which is then printed instead of value.
> + *

    You should also describe the meaning of the function's result in a 
"Return:" section.

> + */
>   static int get_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
>   			       bool raw, bool noval, int shift,
>   			       const char *name)
>   {
>   	u32 l;
> -	int nr_bits, max_value, mask;
> +	int nr_bits;
> +	int mask;
>
>   	l = gpmc_cs_read_reg(cs, reg);
>   	nr_bits = end_bit - st_bit + 1;
> -	max_value = (1 << nr_bits) - 1;
> -	mask = max_value << st_bit;
> -	l = (l & mask) >> st_bit;
> +	mask = (1 << nr_bits) - 1;

    BIT(nr_bits) - 1, perhaps?

WBR, Sergei
