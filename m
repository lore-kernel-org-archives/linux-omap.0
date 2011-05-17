From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3] ARM: omap4: i2c reset regs postidle
Date: Tue, 17 May 2011 16:12:45 +0200
Message-ID: <8762p94dr6.fsf@ti.com>
References: <4DD15BD5.9010303@ti.com>
	<1305624381-22524-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:44954 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754184Ab1EQOM5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 10:12:57 -0400
Received: by wwd20 with SMTP id 20so534588wwd.23
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 07:12:54 -0700 (PDT)
In-Reply-To: <1305624381-22524-1-git-send-email-j.weitzel@phytec.de> (Jan
	Weitzel's message of "Tue, 17 May 2011 11:26:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, andy.green@linaro.org, patches@linaro.org, andy@warmcat.com, tony@atomide.com, peter.maydell@linaro.org, ben-linux@fluff.org

Jan Weitzel <j.weitzel@phytec.de> writes:

> omap4430 get i2c timeouts at each access after an NACK message.
> OMAP_I2C_FLAG_RESET_REGS_POSTIDLE fix it.

We need a little better changelog here.  Specifically, *why* does this
flag fix the problem?   What exactly is going wrong such that this fix
is needed.

Does this happen all the time?  only when off-mode is used?  etc.

Looking closer at how this flag is used in the driver, I think the
driver's usage of runtime PM is a bit broken.  I'm not sure if it's
related to this problem, but I'll send a short series in a little bit to
clean up the runtime PM usage, and get rid of the dev->idle flag which
duplicates usage counting already provided by runtime PM.

Kevin

> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> Tested-by: Andy Green <andy.green@linaro.org>
> Acked-by: Andy Green <andy.green@linaro.org>
> ---
> Works on top of tmlind linux-omap-2.6.git
> v3: commit message
> v2: add Tested-by / Acked-by
>
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 5f4a1b2..3d3b4f4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -2130,7 +2130,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>  };
>  
>  static struct omap_i2c_dev_attr i2c_dev_attr = {
> -	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
> +	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
> +		  OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
>  };
>  
>  /* i2c1 */
