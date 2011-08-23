From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 05/22] gpio/omap: handle save/restore ctx in GPIO driver
Date: Tue, 23 Aug 2011 18:23:40 +0530
Message-ID: <4E53A2D4.90109@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1312455893-14922-6-git-send-email-tarun.kanti@ti.com>
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
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> Modify omap_gpio_prepare_for_idle()&  omap_gpio_resume_after_idle() functions
> to handle save context&  restore context respectively in the OMAP GPIO driver
> itself instead of calling these functions from pm specific files.
> For this, in gpio_prepare_for_idle(), call *_get_context_loss_count() and in
> gpio_resume_after_idle() call it again. If the count is different, do restore
> context. The workaround_enabled flag is no more required and is removed.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---

"ctx" ?
Please change it to 'context' is subject and rest of the code.


>   arch/arm/mach-omap2/gpio.c             |   12 +++
>   arch/arm/mach-omap2/pm34xx.c           |   14 ----
>   arch/arm/plat-omap/include/plat/gpio.h |    5 +-
>   drivers/gpio/gpio-omap.c               |  131 ++++++++++++++------------------
>   4 files changed, 73 insertions(+), 89 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 95195a8..2e65377 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -23,6 +23,7 @@
>
>   #include<plat/omap_hwmod.h>
>   #include<plat/omap_device.h>
> +#include<plat/omap-pm.h>
>
>   #include "powerdomain.h"
>
> @@ -34,6 +35,16 @@ static struct omap_device_pm_latency omap_gpio_latency[] = {
>   	},
>   };
>
> +#ifdef CONFIG_PM
> +static int omap_gpio_get_context_loss(struct device *dev)
> +{
> +	return omap_pm_get_dev_context_loss_count(dev);
> +}
Do you really need this wrapper. Use the funtion directly instead.

Rest looks fine to me
