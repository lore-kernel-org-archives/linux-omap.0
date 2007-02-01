From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap-hw: Fix build
Date: Thu, 1 Feb 2007 10:14:42 -0800
Message-ID: <20070201181441.GE19495@atomide.com>
References: <85sldqnqfw.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <85sldqnqfw.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [070201 02:06]:
> Hi,
> 
> The n800 patches are renaming a struct and a atag name which is used in
> the omap-hw driver without updating it. This patch does it.
> 
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---

> ---
>  drivers/mtd/nand/omap-hw.c |    4 	2 +	2 -	0 !
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-2.6/drivers/mtd/nand/omap-hw.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/mtd/nand/omap-hw.c	2007-01-27 12:00:20.000000000 +0100
> +++ linux-omap-2.6/drivers/mtd/nand/omap-hw.c	2007-01-27 12:00:55.000000000 +0100
> @@ -669,12 +669,12 @@ static int __init add_dynamic_parts(stru
>  {
>  	static const char *part_parsers[] = { "cmdlinepart", NULL };
>  	struct mtd_partition *parts;
> -	const struct omap_flash_part_config *cfg;
> +	const struct omap_flash_part_str_config *cfg;
>  	char *part_str = NULL;
>  	size_t part_str_len;
>  	int c;
>  
> -	cfg = omap_get_var_config(OMAP_TAG_FLASH_PART, &part_str_len);
> +	cfg = omap_get_var_config(OMAP_TAG_FLASH_PART_STR, &part_str_len);
>  	if (cfg != NULL) {
>  		part_str = kmalloc(part_str_len + 1, GFP_KERNEL);
>  		if (part_str == NULL)

Pushing today.

Tony
