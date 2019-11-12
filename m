From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 13/17] remoteproc/omap: add support for system
 suspend/resume
Date: Mon, 11 Nov 2019 22:15:36 -0800
Message-ID: <20191112061536.GO3108315@builder>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-14-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191028124238.19224-14-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
[..]
> +static int _omap_rproc_suspend(struct rproc *rproc)

I think it would make sense to inline this and _omap_rproc_resume() in
their single call sites.

[..]
> +static int _omap_rproc_resume(struct rproc *rproc)
> +{
[..]
> @@ -806,6 +972,14 @@ static int omap_rproc_probe(struct platform_device *pdev)
>  			oproc->num_timers);
>  	}
>  
> +	init_completion(&oproc->pm_comp);
> +
> +	oproc->fck = of_clk_get(np, 0);

devm_clk_get() ? 

Otherwise I think you're lacking a clk_put() in omap_rproc_remove()

Regards,
Bjorn
