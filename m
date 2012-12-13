From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 1/5] ARM: CORESIGHT: Add generic lock/unlock helpers
Date: Thu, 13 Dec 2012 14:58:03 +0000
Message-ID: <20121213145803.GL26540@mudshark.cambridge.arm.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
 <1355348588-22318-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1355348588-22318-2-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On Wed, Dec 12, 2012 at 09:43:04PM +0000, Jon Hunter wrote:
> The Cross Trigger Interface (CTI) helpers in cti.h include definitions
> for the Coresight Lock Access Register (LAR) and Lock Status Register
> (LSR). These registers are already defined in coresight.h and so rather
> than having multiple definitions, just use the definitions from
> coresight.h.
> 
> Add the following coresight macros ...
> - coresight_unlock() --> Unlocks coresight module
> - coresight_lock()   --> Locks coresight module
> 
> Use the above macros for ETB, ETM and CTI. The do-while(0) statement
> has been removed from the macro as it is not a multi-line macro.
> 
> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/include/asm/cti.h                |   16 +++-------------
>  arch/arm/include/asm/hardware/coresight.h |   16 ++++++++--------
>  2 files changed, 11 insertions(+), 21 deletions(-)

[...]

> diff --git a/arch/arm/include/asm/hardware/coresight.h b/arch/arm/include/asm/hardware/coresight.h
> index 7ecd793..dcd0e66 100644
> --- a/arch/arm/include/asm/hardware/coresight.h
> +++ b/arch/arm/include/asm/hardware/coresight.h
> @@ -141,17 +141,17 @@
>  #define ETBFF_TRIGEVT		BIT(9)
>  #define ETBFF_TRIGFL		BIT(10)
>  
> -#define etb_writel(t, v, x) \
> -	(__raw_writel((v), (t)->etb_regs + (x)))
> +#define etb_writel(t, v, x) (__raw_writel((v), (t)->etb_regs + (x)))
>  #define etb_readl(t, x) (__raw_readl((t)->etb_regs + (x)))
>  
> -#define etm_lock(t) do { etm_writel((t), 0, CSMR_LOCKACCESS); } while (0)
> -#define etm_unlock(t) \
> -	do { etm_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
> +#define etb_lock(t) coresight_lock((t)->etb_regs)
> +#define etb_unlock(t) coresight_unlock((t)->etb_regs)
> +#define etm_lock(t) coresight_lock((t)->etm_regs)
> +#define etm_unlock(t) coresight_unlock((t)->etm_regs)
>  
> -#define etb_lock(t) do { etb_writel((t), 0, CSMR_LOCKACCESS); } while (0)
> -#define etb_unlock(t) \
> -	do { etb_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
> +#define coresight_lock(base) (__raw_writel(0, base + CSMR_LOCKACCESS))
> +#define coresight_unlock(base) \
> +	(__raw_writel(UNLOCK_MAGIC, base + CSMR_LOCKACCESS))
>  
>  #endif /* __ASM_HARDWARE_CORESIGHT_H */

How about we take this opportunity to divorce the more general coresight
bits from the etb specific parts, like you've done for the cti. We could
move the ETB stuff out into asm/etb.h (although it might be nice to keep all
the coresight device headers in one place... answers on a postcard) and just
have the architected coresight functionality in this header.

Will

> -- 
> 1.7.10.4
> 
> 
