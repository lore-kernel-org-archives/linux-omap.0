From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 08/14] Input: twl4030-vibra: Support for
 DT booted kernel
Date: Thu, 6 Sep 2012 09:19:33 -0700
Message-ID: <20120906161933.GA18562@core.coreip.homeip.net>
References: <1346933541-21547-1-git-send-email-peter.ujfalusi@ti.com>
 <1346933541-21547-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1346933541-21547-9-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On Thu, Sep 06, 2012 at 03:12:15PM +0300, Peter Ujfalusi wrote:
> Add support when the kernel has been booted with DT blob. In this case the
> pdata is NULL, we need to reach up to the core node and check if the codec
> part has been enabled to determine if we need to coexist with the codec or
> not.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/input/misc/twl4030-vibra.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
> index fc0ed9b..15620f8 100644
> --- a/drivers/input/misc/twl4030-vibra.c
> +++ b/drivers/input/misc/twl4030-vibra.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/jiffies.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
>  #include <linux/workqueue.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/mfd/twl4030-audio.h>
> @@ -194,13 +195,28 @@ static int twl4030_vibra_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(twl4030_vibra_pm_ops,
>  			 twl4030_vibra_suspend, twl4030_vibra_resume);
>  
> +static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
> +			      struct device_node *node)
> +{
> +	if (pdata && pdata->coexist)
> +		return true;
> +
> +#ifdef CONFIG_OF
> +	if (of_find_node_by_name(node, "codec"))
> +		return true;
> +#endif

In patch 6 you added a stub for of_find_node_by_name(), so do you really
need this #ifdef?

Otherwise it looks good.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
