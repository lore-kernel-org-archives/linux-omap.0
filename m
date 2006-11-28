From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Set keypad sense delays for the Palms.
Date: Tue, 28 Nov 2006 02:31:06 +0000
Message-ID: <20061128023105.GF7763@atomide.com>
References: <11645730008-git-send-email-balrog@zabor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11645730008-git-send-email-balrog@zabor.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Andrzej Zaborowski <balrog@zabor.org> [061126 18:30]:
> Wait a fixed amount of time between writing to the columns
> register and reading rows state to allow the keypad to respond
> on Palm Tungsten E and Zire 71.  The value for Zire 71 keypad
> was tested by Marek Vasut.
> 
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> ---
>  arch/arm/mach-omap1/board-palmte.c  |    1 +
>  arch/arm/mach-omap1/board-palmz71.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
> index 73e5f50..c23e8b6 100644
> --- a/arch/arm/mach-omap1/board-palmte.c
> +++ b/arch/arm/mach-omap1/board-palmte.c
> @@ -70,6 +70,7 @@ static struct omap_kp_platform_data palm
>  	.cols	= 8,
>  	.keymap = palmte_keymap,
>  	.rep	= 1,
> +	.delay	= 12,
>  };
>  
>  static struct resource palmte_kp_resources[] = {
> diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
> index ebcc6a7..b1ef1be 100644
> --- a/arch/arm/mach-omap1/board-palmz71.c
> +++ b/arch/arm/mach-omap1/board-palmz71.c
> @@ -76,6 +76,7 @@ static struct omap_kp_platform_data palm
>  	.cols	= 8,
>  	.keymap	= palmz71_keymap,
>  	.rep	= 1,
> +	.delay	= 80,
>  };
>  
>  static struct resource palmz71_kp_resources[] = {
> -- 
> 1.4.3.2

Thanks, pushing today.

Tony
