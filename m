From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 13/17] remoteproc/omap: add support for system
 suspend/resume
Date: Tue, 12 Nov 2019 10:06:23 -0800
Message-ID: <20191112180623.GI3797@yoga>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-14-t-kristo@ti.com>
 <20191112061536.GO3108315@builder>
 <c0fe03eb-86c9-8c67-684e-b1f6f606b7ed@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c0fe03eb-86c9-8c67-684e-b1f6f606b7ed@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, s-anna@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue 12 Nov 00:45 PST 2019, Tero Kristo wrote:

> On 12/11/2019 08:15, Bjorn Andersson wrote:
> > On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:
> > > diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> > [..]
> > > +static int _omap_rproc_suspend(struct rproc *rproc)
> > 
> > I think it would make sense to inline this and _omap_rproc_resume() in
> > their single call sites.
> 
> Well, these get re-used in following patch for runtime PM also, so it is
> probably better leave this for compiler to decide?
> 

I didn't see that until later, this is fine.

Regards,
Bjorn

> > 
> > [..]
> > > +static int _omap_rproc_resume(struct rproc *rproc)
> > > +{
> > [..]
> > > @@ -806,6 +972,14 @@ static int omap_rproc_probe(struct platform_device *pdev)
> > >   			oproc->num_timers);
> > >   	}
> > > +	init_completion(&oproc->pm_comp);
> > > +
> > > +	oproc->fck = of_clk_get(np, 0);
> > 
> > devm_clk_get() ?
> > 
> > Otherwise I think you're lacking a clk_put() in omap_rproc_remove()
> 
> Yeah, let me replace with devm_clk_get.
> 
> -Tero
> 
> > 
> > Regards,
> > Bjorn
> > 
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
