From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] OMAP System Control fix for OMAP2420
Date: Wed, 5 Dec 2007 14:45:45 -0800
Message-ID: <20071205224545.GB4105@atomide.com>
References: <1196883889-18378-1-git-send-email-david.cohen@indt.org.br>
	<1196883889-18378-2-git-send-email-david.cohen@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1196883889-18378-2-git-send-email-david.cohen@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: david.cohen@indt.org.br
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* david.cohen@indt.org.br <david.cohen@indt.org.br> [071205 11:59]:
> From: David Cohen <david.cohen@indt.org.br>
> 
> OMAP2420 has a different offset for CONTROL_STATUS register.
> 
> Signed-off-by: David Cohen <david.cohen@indt.org.br>
> ---
>  include/asm-arm/arch-omap/control.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-arm/arch-omap/control.h b/include/asm-arm/arch-omap/control.h
> index 5f42725..8670d54 100644
> --- a/include/asm-arm/arch-omap/control.h
> +++ b/include/asm-arm/arch-omap/control.h
> @@ -37,7 +37,13 @@
>  
>  #define CONTROL_DEVCONF0		(CONTROL_GENERAL + 0x04)
>  #define CONTROL_DEVCONF1		(CONTROL_GENERAL + 0x68) /* > 242x */
> +
> +/* OMAP2420's CONTROL_STATUS offset is 0x2F8 */
> +#ifdef CONFIG_ARCH_OMAP2420
> +#define CONTROL_STATUS			(CONTROL_GENERAL + 0x88)
> +#else
>  #define CONTROL_STATUS			(CONTROL_GENERAL + 0x80)
> +#endif
>  

Please no more ifdefs in headers for 24XX vs 3440. Instead, please
define OMAP2420_CONTROL_STATUS and OMAP2430_CONTROL_STATUS or
something like that.

Regards,

Tony
