From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 3/7] arm: perf: support device with other non-irq
	resources
Date: Mon, 24 Oct 2011 16:08:14 +0100
Message-ID: <20111024150814.GA4771@mudshark.cambridge.arm.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-4-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1319467559-5518-4-git-send-email-ming.lei@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "ming.lei@canonical.com" <ming.lei@canonical.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Ming Lei,

On Mon, Oct 24, 2011 at 03:45:55PM +0100, ming.lei@canonical.com wrote:
> From: Ming Lei <ming.lei@canonical.com>
> 
> omap4 may create device via hwmod, which can create resources
> automatically, so may include some non-irq resources.
> 
> This patch supports device with other non-irq resources.

I'd rather not do this in the Perf code since we're essentially dealing with
an artifact of the hwmod -> platform_device conversion.

> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
>  arch/arm/kernel/perf_event.c |    5 +++--
>  arch/arm/kernel/pmu.c        |   12 ++++++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index f367780..d91dba2 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/uaccess.h>
> +#include <linux/cpumask.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/irq.h>
> @@ -414,7 +415,7 @@ armpmu_reserve_hardware(void)
>  		return -ENODEV;
>  	}
>  
> -	for (i = 0; i < pmu_device->num_resources; ++i) {
> +	for (i = 0; i < nr_cpu_ids; ++i) {
>  		irq = platform_get_irq(pmu_device, i);
>  		if (irq < 0)
>  			continue;

Hmm, I actually changed this code recently. Take a look:

https://github.com/wdeacon/linux-wd/blob/perf/system-pmus/arch/arm/kernel/perf_event.c

This should all be in for 3.2-rc1, so you can rebase then. If you still have
hwmod issues, please solve them outside of perf_event.c

> diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> index c53474f..0e9c908 100644
> --- a/arch/arm/kernel/pmu.c
> +++ b/arch/arm/kernel/pmu.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/cpumask.h>

'fraid I've changed this file too!

https://github.com/wdeacon/linux-wd/blob/perf/system-pmus/arch/arm/kernel/pmu.c

Will
