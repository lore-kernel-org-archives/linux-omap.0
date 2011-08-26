From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v14 REPOST 08/12] OMAP: dmtimer: add timeout to low-level
	routines
Date: Fri, 26 Aug 2011 21:00:05 +0530
Message-ID: <4E57BBFD.30600@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
	<1310731501-13078-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1310731501-13078-9-git-send-email-tarun.kanti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> The low-level read and write access routines wait on write-pending register
> in posted mode to make sure that previous write is complete on respective
> registers. This waiting is done in an infinite while loop. Now it is being
> modified to use timeout instead.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Reviewed-by: Varadarajan, Charulatha<charu@ti.com>
> Acked-by: Cousson, Benoit<b-cousson@ti.com>
> ---
>   arch/arm/plat-omap/include/plat/dmtimer.h |   34 ++++++++++++++++++++--------
>   1 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index 53d5da6..6e34094 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -36,6 +36,8 @@
>   #include<linux/delay.h>
>   #include<linux/platform_device.h>
>
> +#include<plat/common.h>
> +
>   #ifndef __ASM_ARCH_DMTIMER_H
>   #define __ASM_ARCH_DMTIMER_H
>
> @@ -230,6 +232,8 @@ int omap_dm_timers_active(void);
>   #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
>   		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR<<  WPSHIFT))
>
> +#define MAX_WRITE_PEND_WAIT            10000 /* 10ms timeout delay */
Minor comment.
Space out the comment with the tab or put it up.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Regards
Santosh
