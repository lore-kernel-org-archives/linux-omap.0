From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: SmartReflex: pass device dependent data via platform data
Date: Tue, 02 Oct 2012 15:21:12 -0700
Message-ID: <877gr87bxj.fsf@deeprootsystems.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
	<1348496201-6378-1-git-send-email-j-pihet@ti.com>
	<1348496201-6378-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63921 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab2JBWVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Oct 2012 18:21:13 -0400
Received: by pbbrr4 with SMTP id rr4so9201690pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Oct 2012 15:21:12 -0700 (PDT)
In-Reply-To: <1348496201-6378-3-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Mon, 24 Sep 2012 16:16:41 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Anton Vorontsov <cbou@mail.ru>, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

Hi Jean,

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Remove the device dependent settings (cpu_is_xxx(), IP fck etc.)
> from the driver code and pass them instead via the platform
> data.
> This allows a clean separation of the driver code and the platform
> code, as required by the move of the platform header files to
> include/linux/platform_data.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Could you make pdata change and the clock change should be two different
patches?  Also, your previous patch to align SR clock names should be
combined with the changes made here.

Some comments on the clock change below...

> ---
>  arch/arm/mach-omap2/sr_device.c   |   13 ++++++++++++
>  drivers/power/avs/smartreflex.c   |   40 ++++++++++--------------------------
>  include/linux/power/smartreflex.h |   14 +++++++++++-
>  3 files changed, 36 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
> index d033a65..2885a77 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -122,6 +122,19 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
>  	sr_data->senn_mod = 0x1;
>  	sr_data->senp_mod = 0x1;
>  
> +	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> +		sr_data->err_weight = OMAP3430_SR_ERRWEIGHT;
> +		sr_data->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
> +		sr_data->accum_data = OMAP3430_SR_ACCUMDATA;
> +		if (!(strcmp(sr_data->name, "smartreflex_mpu"))) {
> +			sr_data->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
> +			sr_data->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
> +		} else {
> +			sr_data->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
> +			sr_data->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
> +		}
> +	}
> +
>  	sr_data->voltdm = voltdm_lookup(sr_dev_attr->sensor_voltdm_name);
>  	if (IS_ERR(sr_data->voltdm)) {
>  		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> index 92f6728..7c03c90 100644
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -128,17 +128,16 @@ static irqreturn_t sr_interrupt(int irq, void *data)
>  
>  static void sr_set_clk_length(struct omap_sr *sr)
>  {
> +	char fck_name[16]; /* "smartreflex.0" fits in 16 chars */
>  	struct clk *sys_ck;
>  	u32 sys_clk_speed;
>  
> -	if (cpu_is_omap34xx())
> -		sys_ck = clk_get(NULL, "sys_ck");
> -	else
> -		sys_ck = clk_get(NULL, "sys_clkin_ck");
> +	sprintf(fck_name, "smartreflex.%d", sr->srid);

hmm, isn't this the same as dev_name(&sr->pdev.dev) ?

Combined with your earlier patch to align clock names, this should just
be:

        sys_ck = clk_get(&sr->pdev.dev, "fck");

Also note that you've changed this from sys_clk to the SR functional
clock, which seems to be the same clock on 34xx and 44xx, but that change
should be clearly documented in the changelog.

Kevin
