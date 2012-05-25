From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 06/11] OMAP2+: use control module mfd
	driver in omap_type
Date: Fri, 25 May 2012 14:53:41 +0200
Message-ID: <4FBF80D5.2000600@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-7-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1337934361-1606-7-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Eduardo,

On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
> OMAP system control module can be probed early, then
> omap_type is safe to use its APIs.
>
> TODO: add support for other omap versions
>
> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
> ---
>   arch/arm/mach-omap2/id.c |   16 +++++++++++++++-
>   1 files changed, 15 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 5bb9746..acfd698 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -18,6 +18,7 @@
>   #include<linux/kernel.h>
>   #include<linux/init.h>
>   #include<linux/io.h>
> +#include<linux/mfd/omap_control.h>
>
>   #include<asm/cputype.h>
>
> @@ -40,8 +41,14 @@ EXPORT_SYMBOL(omap_rev);
>
>   int omap_type(void)
>   {
> +	struct device *scm;
> +	int ret = 0;
>   	u32 val = 0;
>
> +	scm = omap_control_get();
> +	if (IS_ERR_OR_NULL(scm))
> +		return 0;
> +
>   	if (cpu_is_omap24xx()) {

OK, not really related to that patch, but the previous cpu_is_omap24xx 
makes me think of that :-)

What about the omap<X>_check_revision used by cpu_is_XXX?

This call is the very first one to require the control module access in 
order to get the ID_CODE inside the control module.

So far it still use that ugly hard coded phys -> virtual address macro 
that is sued for that.

>   		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
>   	} else if (cpu_is_am33xx()) {
> @@ -49,16 +56,23 @@ int omap_type(void)
>   	} else if (cpu_is_omap34xx()) {
>   		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
>   	} else if (cpu_is_omap44xx()) {
> -		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
> +		ret = omap_control_readl(scm, OMAP4_CTRL_MODULE_CORE_STATUS,
> +					&val);

I guess you should get rid of these cpu_is_omap44xx and store the 
omap_type somewhere to avoid further access to the control module since 
there are a couple of places that use that API.

Not necessarily in this patch for sure, but something that might be done 
in this series.

Regards,
Benoit
