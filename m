From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH] Fix checking for multiple boot tags in board config.
Date: Fri, 07 Apr 2006 18:50:15 +0300
Message-ID: <1144425015.19066.20.camel@bitbox.mine.nu>
References: <20060407150028.GT22929@earth.li>
Reply-To: imre.deak@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060407150028.GT22929@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Jonathan McDowell <noodles@earth.li>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, 2006-04-07 at 16:00 +0100, ext Jonathan McDowell wrote:
> Currently if we look for more than one instance of a boot tag and it's
> defined in the board config rather than passed by the boot loader we can
> get stuck in a loop where the same tag is processed many times. This can
> be seen with the gpio-switch driver, for example. The patch below fixes
> this by respecting the skip parameter to get_config when we're scanning
> the board config structure.
> 
> Signed-Off-By: Jonathan McDowell <noodles@earth.li>
> 
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 0625df5..39ab667 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -114,8 +114,12 @@ static const void *get_config(u16 tag, s
>  	 * in the kernel. */
>  	for (i = 0; i < omap_board_config_size; i++) {
>  		if (omap_board_config[i].tag == tag) {
> -			kinfo = &omap_board_config[i];
> -			break;
> +			if (skip == 0) {
> +				kinfo = &omap_board_config[i];
> +				break;
> +			} else {
> +				skip--;
> +			}
>  		}
>  	}
>  	if (kinfo == NULL)

Should the case be handled when a configuration is present in both the
boot tag and the board config? If so, we should stop parsing after the
boot tags whenever the requested tag is found, even if there are less
then 'skip' instances of it, and return NULL.

--Imre

> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
