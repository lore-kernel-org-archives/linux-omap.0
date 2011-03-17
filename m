From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 12/19] OMAP3+: SR: introduce class start,stop and priv data
Date: Thu, 17 Mar 2011 10:23:50 -0700
Message-ID: <87y64d7ja1.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-13-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39535 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751566Ab1CQRXy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 13:23:54 -0400
Received: by mail-gw0-f52.google.com with SMTP id 15so2621574gwj.25
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:23:53 -0700 (PDT)
In-Reply-To: <1299338962-5602-13-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> Certain class drivers such as class 1.5 drivers, will need specific
> notification that they have to be started up or stopped independent
> of smart reflex operation. They also may need private data to be
> used for operations of their own, provide the same.
> This allows the class driver to initialize it's internal data structures
> on a need basis in preparation for the specific domain's autocomp usage.
> The resultant operation is as follows:
> when autocomp is set to 1 -> class drivers' start is called
> The existing enable/disable is still used as before by the SmartReflex
> core driver to enable disable the class operation.
> When autocomp is set to 0 -> class drivers' stop is called, signaling
> the end of usage for that domain.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Please also fixup the comments and printks to use the start/stop
terminology instead of the init/deinit terminology.

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   14 ++++++++++++++
>  arch/arm/mach-omap2/smartreflex.h |    6 ++++++
>  2 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 1e52d61..592e9a0 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -220,6 +220,13 @@ static void sr_start_vddautocomp(struct omap_sr *sr)
>  		return;
>  	}
>  
> +	if (sr_class->start &&
> +	    sr_class->start(sr->voltdm, sr_class->class_priv_data)) {
> +		dev_err(&sr->pdev->dev,
> +			"%s: SRClass initialization failed\n", __func__);
> +		return;
> +	}
> +
>  	if (!sr_class->enable(sr->voltdm))
>  		sr->autocomp_active = true;
>  }
> @@ -235,6 +242,13 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
>  
>  	if (sr->autocomp_active) {
>  		sr_class->disable(sr->voltdm, 1);
> +		if (sr_class->stop &&
> +		    sr_class->stop(sr->voltdm,
> +			    sr_class->class_priv_data)) {
> +			dev_err(&sr->pdev->dev,
> +				"%s: SR[%d]Class deinitialization failed\n",
> +				__func__, sr->srid);
> +		}
>  		sr->autocomp_active = false;
>  	}
>  }
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
> index 5f35b9e..d4b8bee 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -168,6 +168,8 @@ struct omap_sr_pmic_data {
>   *
>   * @enable:		API to enable a particular class smaartreflex.
>   * @disable:		API to disable a particular class smartreflex.
> + * @start:		API to do class specific initialization (optional)
> + * @stop:		API to do class specific deinitialization (optional)
>   * @configure:		API to configure a particular class smartreflex.
>   * @notify:		API to notify the class driver about an event in SR.
>   *			Not needed for class3.
> @@ -175,14 +177,18 @@ struct omap_sr_pmic_data {
>   * @class_type:		specify which smartreflex class.
>   *			Can be used by the SR driver to take any class
>   *			based decisions.
> + * @class_priv_data:	Class specific private data (optional)
>   */
>  struct omap_sr_class_data {
>  	int (*enable)(struct voltagedomain *voltdm);
>  	int (*disable)(struct voltagedomain *voltdm, int is_volt_reset);
> +	int (*start)(struct voltagedomain *voltdm, void *class_priv_data);
> +	int (*stop)(struct voltagedomain *voltdm, void *class_priv_data);
>  	int (*configure)(struct voltagedomain *voltdm);
>  	int (*notify)(struct voltagedomain *voltdm, u32 status);
>  	u8 notify_flags;
>  	u8 class_type;
> +	void *class_priv_data;
>  };
>  
>  /**
