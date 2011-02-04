From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 01/13] OMAP: hwmod: Add member 'name' to
	omap_hwmod_addr_space struct
Date: Fri, 04 Feb 2011 11:45:52 -0800
Message-ID: <8762szpor3.fsf@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1296485437-12806-2-git-send-email-kishon@ti.com> (Kishon Vijay
	Abraham, I's message of "Mon, 31 Jan 2011 20:20:25 +0530")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: alsa-devel@alsa-project.org, b-cousson@ti.com, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, p-basak2@ti.com, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, shubhrajyoti@ti.com, charu@ti.com
List-Id: linux-omap@vger.kernel.org

Kishon Vijay Abraham I <kishon@ti.com> writes:

> Adds a structure member 'name' to 'omap_hwmod_addr_space' structure.
> The drivers can use platform_get_resource_byname() to get resource of
> type 'IORESOURCE_MEM' by name so that it need not rely on the order to get
> the proper resource.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |    1 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +++-
>  2 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 709543a..7bd4900 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1898,6 +1898,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
>  		os = oh->slaves[i];
>  
>  		for (j = 0; j < os->addr_cnt; j++) {
> +			(res + r)->name = (os->addr + j)->name;
>  			(res + r)->start = (os->addr + j)->pa_start;
>  			(res + r)->end = (os->addr + j)->pa_end;
>  			(res + r)->flags = IORESOURCE_MEM;
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 76f0274..85899a7 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -178,7 +178,8 @@ struct omap_hwmod_omap2_firewall {
>  #define ADDR_TYPE_RT		(1 << 1)
>  
>  /**
> - * struct omap_hwmod_addr_space - MPU address space handled by the hwmod
> + * struct omap_hwmod_addr_space - address space handled by the hwmod

Any reason you modified the comment here?  

Kevin

> + * @name: name of the address space
>   * @pa_start: starting physical address
>   * @pa_end: ending physical address
>   * @flags: (see omap_hwmod_addr_space.flags macros above)
> @@ -187,6 +188,7 @@ struct omap_hwmod_omap2_firewall {
>   * structure.  GPMC is one example.
>   */
>  struct omap_hwmod_addr_space {
> +	const char *name;
>  	u32 pa_start;
>  	u32 pa_end;
>  	u8 flags;
