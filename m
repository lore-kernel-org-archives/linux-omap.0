From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 4/8] OMAPDSS: HDMI: use vdda_hdmi_dac
Date: Fri, 24 Aug 2012 11:50:23 +0530
Message-ID: <50371D27.1010707@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com> <1345729514-2441-5-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53371 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab2HXGV5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 02:21:57 -0400
In-Reply-To: <1345729514-2441-5-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 23 August 2012 07:15 PM, Tomi Valkeinen wrote:
> The HDMI driver requires vdda_hdmi_dac power for operation, but does not
> enable it. This has worked because the regulator has been always
> enabled.
>
> But this may not always be the case, as I encountered when implementing
> HDMI device tree support.
>
> This patch changes the HDMI driver to use the vdda_hdmi_dac.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/hdmi.c |   23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index 96a6e29..ccfc677 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -33,6 +33,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/clk.h>
>   #include <linux/gpio.h>
> +#include <linux/regulator/consumer.h>
>   #include <video/omapdss.h>
>
>   #include "ti_hdmi.h"
> @@ -62,6 +63,7 @@ static struct {
>   	struct hdmi_ip_data ip_data;
>
>   	struct clk *sys_clk;
> +	struct regulator *vdda_hdmi_dac_reg;
>
>   	int ct_cp_hpd_gpio;
>   	int ls_oe_gpio;
> @@ -331,6 +333,19 @@ static int __init hdmi_init_display(struct omap_dss_device *dssdev)
>
>   	dss_init_hdmi_ip_ops(&hdmi.ip_data);
>
> +	if (hdmi.vdda_hdmi_dac_reg == NULL) {
> +		struct regulator *reg;
> +
> +		reg = devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");

There is no corresponding devm_regulator_put() call here, I guess that's 
what devm_* calls are supposed to help us with. But the only place I saw 
the usage of dev_regulator_get() is here:

sound/soc/ux500/ux500_msp_dai.c

And here, they are doing devm_regulator_put() calls to, so I was 
wondering what the deal is.

Archit

