From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] omap: i2c: Add calls for pinctrl state select
Date: Wed, 22 Apr 2015 19:32:26 -0500
Message-ID: <55383D9A.4020302@ti.com>
References: <1429693667-28942-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58097 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965965AbbDWAcd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2015 20:32:33 -0400
In-Reply-To: <1429693667-28942-1-git-send-email-pascal.huerst@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pascal.huerst@gmail.com, wsa@the-dreams.de
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

few nitpicks:
i2c: omap:  in $subject instead of omap: i2c:
I usually would do:
git log --no-merges --oneline drivers/i2c/busses/i2c-omap.c
and look for common usage.

On 04/22/2015 04:07 AM, pascal.huerst@gmail.com wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
> 
> This adds calls to pinctrl subsystem in order to switch pin states
> on suspend/resume if you provide a "sleep" state in DT.
> 
> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
> ---
>  drivers/i2c/busses/i2c-omap.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 0e89419..8261941 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -38,6 +38,7 @@
>  #include <linux/slab.h>
>  #include <linux/i2c-omap.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
> 
>  /* I2C controller revisions */
>  #define OMAP_I2C_OMAP1_REV_2		0x20
> @@ -1423,6 +1424,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
>  		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
>  	}
> 
> +	pinctrl_pm_select_sleep_state(dev);
> +
>  	return 0;
>  }
> 
> @@ -1431,6 +1434,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
> 
> +	pinctrl_pm_select_default_state(dev);
> +
>  	if (!_dev->regs)
>  		return 0;
> 
> --
> 2.1.0
> 
Build tested with omap2plus_defconfig on linus master (27cf3a16b253)
and next-20150422
While I do understand that the sleep state and default states are
optional - might be nice to state it in commit message (as a result of
which we dont do error checks).

Would you think adding relevant documentation in
Documentation/devicetree/bindings/i2c/i2c-omap.txt might be good as
well? I mean, folks should know looking at dt documentation that this
bus driver does indeed support this option..

-- 
Regards,
Nishanth Menon
